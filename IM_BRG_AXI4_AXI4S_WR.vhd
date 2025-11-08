--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_AXI4_AXI4S_WR is
  generic (
    G_ID_WIDTH                : integer;
    G_DAT_WIDTH               : integer range 16 to 1024;
    G_ADR_WIDTH               : integer range 16 to 1024
  );
  port (
    i_axi_awid                : in  std_logic_vector(G_ID_WIDTH - 1 downto 0);
    i_axi_awaddr              : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_axi_awlen               : in  std_logic_vector( 7 downto 0);
    i_axi_awsize              : in  std_logic_vector( 2 downto 0);
    i_axi_awburst             : in  std_logic_vector( 1 downto 0);
    i_axi_awvalid             : in  std_logic;
    o_axi_awready             : out std_logic;
    i_axi_wdata               : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_axi_wstrb               : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    i_axi_wlast               : in  std_logic;
    i_axi_wvalid              : in  std_logic;
    o_axi_wready              : out std_logic;
    o_axi_bid                 : out std_logic_vector(G_ID_WIDTH - 1 downto 0);
    o_axi_bresp               : out std_logic_vector( 1 downto 0);
    o_axi_bvalid              : out std_logic;
    i_axi_bready              : in  std_logic;

    o_axis_tdata              : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_tstrb              : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BRG_AXI4_AXI4S_WR;
architecture RTL of IM_BRG_AXI4_AXI4S_WR is
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

  signal trs_a                : boolean := FALSE;
  signal trs_b                : boolean := FALSE;
  signal trs_d                : boolean := FALSE;
  signal snd_adr              : boolean := FALSE;
  signal wrap_len             : integer range 0 to 4 := 0;
  signal adr_cntr             : std_logic_vector(ADR_RNG_H downto 0) := (others => '0');
  signal adr_cntr_add         : std_logic_vector(adr_cntr'range) := (others => '0');
  signal adr_step             : std_logic_vector(adr_cntr'range) := (others => '0');
  signal wready               : boolean := FALSE;
  signal flag_ad              : boolean := FALSE;
  signal bvalid               : boolean := FALSE;
  signal wrap_rng             : integer range 0 to 12 := 0;
  signal o_axi_awready_buf    : std_logic := '0';
  signal o_axi_wready_buf     : std_logic := '0';
  signal o_axi_bid_buf        : std_logic_vector(o_axi_bid   'range) := (others => '0');
  signal o_axi_bresp_buf      : std_logic_vector(o_axi_bresp 'range) := (others => '0');
  signal o_axi_bvalid_buf     : std_logic := '0';
  signal o_axis_tdata_buf     : std_logic_vector(o_axis_tdata'range) := (others => '0');
  signal o_axis_tstrb_buf     : std_logic_vector(o_axis_tstrb'range) := (others => '0');
  signal o_axis_tlast_buf     : std_logic := '0';
  signal o_axis_tvalid_buf    : std_logic := '0';
begin
  trs_a                       <= i_axi_awvalid    = '1' and o_axi_awready_buf = '1';
  trs_b                       <= o_axi_bvalid_buf = '1' and i_axi_bready      = '1';
  trs_d                       <= i_axi_wvalid     = '1' and o_axi_wready_buf  = '1';
  snd_adr                     <= (o_axis_tvalid_buf = '0' or i_axis_tready = '1') and wready and flag_ad;
  adr_cntr_add                <= adr_cntr + adr_step;
  o_axi_awready_buf           <= '0' when (wready or bvalid or i_rst = '1') else '1';
  o_axi_wready_buf            <= '1' when (wready and flag_ad = FALSE and (o_axis_tvalid_buf = '0' or i_axis_tready = '1')) else '0';
  o_axi_bvalid_buf            <= '1' when (bvalid and  o_axis_tvalid_buf = '0') else '0';

  wrap_len                    <=
    1 when (i_axi_awlen =  1) else--2Burst
    2 when (i_axi_awlen =  3) else--4Burst
    3 when (i_axi_awlen =  7) else--8Burst
    4 when (i_axi_awlen = 15) else--16Burst
    0;

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    if    (i_axis_tready = '1') then
      o_axis_tdata_buf        <= (others => '0');
      o_axis_tstrb_buf        <= (others => '0');
      o_axis_tlast_buf        <= '0';
      o_axis_tvalid_buf       <= '0';
    end if;

    if    (snd_adr) then
      flag_ad                 <= FALSE;
      for L in 0 to 11 loop
        if    (L < wrap_rng) then
          adr_cntr(L)         <= adr_cntr_add(L);
        end if;
      end loop;
      o_axis_tdata_buf(ADR_RNG_H downto ADR_RNG_L)     <= adr_cntr(ADR_RNG_H downto ADR_RNG_L);
      o_axis_tdata_buf(0)     <= '0';--Write Flag
      o_axis_tstrb_buf        <= (others => '1');
      o_axis_tvalid_buf       <= '1';
    end if;

    if    (trs_b) then
      bvalid                  <= FALSE;
    end if;

    if    (trs_d) then
      flag_ad                 <= TRUE;
      o_axis_tdata_buf        <= i_axi_wdata;
      o_axis_tstrb_buf        <= i_axi_wstrb;
      o_axis_tlast_buf        <= '1';
      o_axis_tvalid_buf       <= '1';
      if    (i_axi_wlast = '1') then
        wready                <= FALSE;
        bvalid                <= TRUE;
      end if;
    end if;

    if    (trs_a) then
      adr_cntr                <= i_axi_awaddr(adr_cntr'range);
      adr_step                <= (others => '0');
      for L in 0 to 7 loop
        if    (L = i_axi_awsize) then
          adr_step(L)         <= '1';
        end if;
      end loop;
      wready                  <= TRUE;
      flag_ad                 <= TRUE;

      if    (i_axi_awburst = 1) then--INCR
        wrap_rng              <= 12;
      elsif (i_axi_awburst = 2) then--WRAP
        wrap_rng              <= conv_integer(i_axi_awsize) + wrap_len;
      else
        wrap_rng              <= 0;--FIXED
      end if;

      o_axi_bid_buf           <= i_axi_awid;
    end if;

    if    (i_rst = '1') then
      wready                  <= FALSE;
      bvalid                  <= FALSE;
      o_axi_bid_buf           <= (others => '0');
      o_axis_tdata_buf        <= (others => '0');
      o_axis_tstrb_buf        <= (others => '0');
      o_axis_tlast_buf        <= '0';
      o_axis_tvalid_buf       <= '0';
    end if;
  end if;
  end process;
  o_axi_awready               <= o_axi_awready_buf;
  o_axi_wready                <= o_axi_wready_buf;
  o_axi_bid                   <= o_axi_bid_buf;
  o_axi_bresp                 <= o_axi_bresp_buf;--Always "00"(OKAY)
  o_axi_bvalid                <= o_axi_bvalid_buf;
  o_axis_tdata                <= o_axis_tdata_buf;
  o_axis_tstrb                <= o_axis_tstrb_buf;
  o_axis_tlast                <= o_axis_tlast_buf;
  o_axis_tvalid               <= o_axis_tvalid_buf;
end RTL;
