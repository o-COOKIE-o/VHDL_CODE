--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_AXI4S_GPI is
  generic (
    G_DAT_WIDTH               : integer;
    G_ADR_WIDTH               : integer
  );
  port (
    --Address Control
    i_adr_base                : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_adr_mask                : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    --Read Request
    i_axis_tdata              : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_axis_tstrb              : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);--UnUsed
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;
    --Read Return
    o_axis_tdata              : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_tstrb              : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;
    --Read address and data port
    o_gpi_vld                 : out std_logic;
    o_gpi_adr                 : out std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_gpi_dat                 : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_gpi_rdy                 : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BRG_AXI4S_GPI;
architecture RTL of IM_BRG_AXI4S_GPI is
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

  signal adr_match0           : boolean := FALSE;
  signal adr_match1           : boolean := FALSE;
  signal adr_match2           : boolean := FALSE;
  signal adr_match            : boolean := FALSE;
  signal trs_axirq            : boolean := FALSE;
  signal trs_axirt            : boolean := FALSE;
  signal trs_gpi              : boolean := FALSE;
  signal adr_vld              : boolean := FALSE;
  signal flag_busy            : boolean := FALSE;
  signal o_axis_tready_buf    : std_logic := '0';
  signal o_axis_tdata_buf     : std_logic_vector(o_axis_tdata'range) := (others => '0');
  signal o_axis_tstrb_buf     : std_logic_vector(o_axis_tstrb'range) := (others => '1');
  signal o_axis_tlast_buf     : std_logic := '0';
  signal o_axis_tvalid_buf    : std_logic := '0';
  signal o_gpi_vld_buf        : std_logic := '0';
  signal o_gpi_adr_buf        : std_logic_vector(o_gpi_adr'range) := (others => '0');
begin
  adr_match0                  <= i_axis_tlast = '0';
  adr_match1                  <= ((i_axis_tdata(ADR_RNG'range) xor i_adr_base(ADR_RNG'range)) and i_adr_mask(ADR_RNG'range)) = 0;
  adr_match2                  <= i_axis_tdata(0) = '1';--R/W FLAG('0':Write '1':Read Request)
  adr_match                   <= adr_match0 and adr_match1 and adr_match2;
  trs_axirq                   <= i_axis_tvalid     = '1' and o_axis_tready_buf = '1';
  trs_axirt                   <= o_axis_tvalid_buf = '1' and i_axis_tready     = '1';
  trs_gpi                     <= o_gpi_vld_buf     = '1' and i_gpi_rdy         = '1';

  o_axis_tready_buf           <= '0' when (adr_match and flag_busy) else '1';
  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    if    (i_gpi_rdy = '1') then
      o_gpi_vld_buf           <= '0';
    end if;

    if    (i_axis_tready = '1') then
      o_axis_tvalid_buf       <= '0';
    end if;

    if    (trs_gpi) then
      o_axis_tdata_buf        <= i_gpi_dat;
      o_axis_tlast_buf        <= '1';
      o_axis_tvalid_buf       <= '1';
    end if;

    if    (trs_axirt) then
      if    (o_axis_tlast_buf = '0') then
        o_gpi_vld_buf         <= '1';
      else
        flag_busy             <= FALSE;
      end if;
    end if;

    if    (trs_axirq) then
      adr_vld                 <= FALSE;
      if    (adr_match) then
        adr_vld               <= TRUE;
        o_gpi_adr_buf(ADR_RNG'range)    <= i_axis_tdata(ADR_RNG'range);
      elsif (i_axis_tlast = '1' and adr_vld) then
        flag_busy             <= TRUE;
        o_axis_tdata_buf      <= i_axis_tdata;--Return Address
        o_axis_tdata_buf(0)   <= '0';--R/W FLAG('0':Write '1':Read Request)
        o_axis_tlast_buf      <= '0';
        o_axis_tvalid_buf     <= '1';
      end if;
    end if;

    if    (i_rst = '1') then
      flag_busy               <= FALSE;
      adr_vld                 <= FALSE;
      o_axis_tvalid_buf       <= '0';
      o_gpi_vld_buf           <= '0';
    end if;
  end if;
  end process;
  o_axis_tready               <= o_axis_tready_buf;
  o_axis_tdata                <= o_axis_tdata_buf;
  o_axis_tstrb                <= o_axis_tstrb_buf;
  o_axis_tlast                <= o_axis_tlast_buf;
  o_axis_tvalid               <= o_axis_tvalid_buf;
  o_gpi_vld                   <= o_gpi_vld_buf;
  o_gpi_adr                   <= o_gpi_adr_buf;
end RTL;
