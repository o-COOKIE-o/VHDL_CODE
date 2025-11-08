--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_AXI4S_GPO is
  generic (
    G_DAT_WIDTH               : integer;
    G_ADR_WIDTH               : integer
  );
  port (
    --Address Control
    i_adr_base                : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_adr_mask                : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    --Write Access
    i_axis_tdata              : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_axis_tstrb              : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;
    --Write address and data port
    o_gpo_vld                 : out std_logic;
    o_gpo_adr                 : out std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    o_gpo_dat                 : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_gpo_stb                 : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    i_gpo_rdy                 : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BRG_AXI4S_GPO;
architecture RTL of IM_BRG_AXI4S_GPO is
  function minimum(a, b: integer) return integer is
    variable ret_val          : integer;
  begin
    if    (a < b) then
      ret_val       := a;
    else
      ret_val       := b;
    end if;
    return ret_val;
  end function;

  function log2(val : integer) return integer is
    variable ret_val          : integer;
  begin
    ret_val         := -1;
    for L in 0 to 30 loop
      if    (val = 2 ** L) then
        ret_val     := L;
      end if;
    end loop;
    return ret_val;
  end function;

  constant ADR_RNG_H          : integer := minimum(G_DAT_WIDTH, G_ADR_WIDTH) - 1;
  constant ADR_RNG_L          : integer := log2(G_DAT_WIDTH) - 3;
  constant ADR_RNG            : std_logic_vector(ADR_RNG_H downto ADR_RNG_L) := (others => '0');

  signal adr_match            : boolean := FALSE;
  signal trs_axi              : boolean := FALSE;
  signal adr_vld              : boolean := FALSE;
  signal o_axis_tready_buf    : std_logic := '0';
  signal o_gpo_vld_buf        : std_logic := '0';
  signal o_gpo_adr_buf        : std_logic_vector(o_gpo_adr'range) := (others => '0');
  signal o_gpo_dat_buf        : std_logic_vector(o_gpo_dat'range) := (others => '0');
  signal o_gpo_stb_buf        : std_logic_vector(o_gpo_stb'range) := (others => '0');
begin
  adr_match                   <= ((i_axis_tdata(ADR_RNG'range) xor i_adr_base(ADR_RNG'range)) and i_adr_mask(ADR_RNG'range)) = 0;
  trs_axi                     <= i_axis_tvalid = '1' and o_axis_tready_buf = '1';
  o_axis_tready_buf           <= '1' when (o_gpo_vld_buf = '0' or i_gpo_rdy = '1') else '0';

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    if    (i_gpo_rdy = '1') then
      o_gpo_vld_buf           <= '0';
    end if;

    if    (trs_axi) then
      adr_vld                 <= FALSE;
      if    (i_axis_tlast = '0') then
        if    (adr_match) then
          if    (i_axis_tdata(0) = '0') then--R/W FLAG('0':Write '1':Read Request)
            adr_vld           <= TRUE;
            o_gpo_adr_buf(ADR_RNG'range)          <= i_axis_tdata(ADR_RNG'range);
          end if;
        end if;
      else
        if    (adr_vld) then
          o_gpo_vld_buf       <= '1';
          o_gpo_dat_buf       <= i_axis_tdata;
          o_gpo_stb_buf       <= i_axis_tstrb;
        end if;
      end if;
    end if;

    if    (i_rst = '1') then
      adr_vld                 <= FALSE;
      o_gpo_vld_buf           <= '0';
    end if;
  end if;
  end process;
  o_axis_tready               <= o_axis_tready_buf;
  o_gpo_vld                   <= o_gpo_vld_buf;
  o_gpo_adr                   <= o_gpo_adr_buf;
  o_gpo_dat                   <= o_gpo_dat_buf;
  o_gpo_stb                   <= o_gpo_stb_buf;
end RTL;
