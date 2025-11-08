--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_AXI4_AXI4S_RD is
  generic (
    G_ID_WIDTH                : integer;
    G_DAT_WIDTH               : integer range 16 to 1024;
    G_ADR_WIDTH               : integer range 16 to 1024;
    G_TO_CNT                  : integer := 256--タイムアウトカウント
  );
  port (
    i_axi_arid                : in  std_logic_vector(G_ID_WIDTH - 1 downto 0);
    i_axi_araddr              : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_axi_arlen               : in  std_logic_vector( 7 downto 0);
    i_axi_arsize              : in  std_logic_vector( 2 downto 0);
    i_axi_arburst             : in  std_logic_vector( 1 downto 0);
    i_axi_arvalid             : in  std_logic;
    o_axi_arready             : out std_logic;
    o_axi_rid                 : out std_logic_vector(G_ID_WIDTH - 1 downto 0);
    o_axi_rdata               : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axi_rresp               : out std_logic_vector( 1 downto 0);
    o_axi_rlast               : out std_logic;
    o_axi_rvalid              : out std_logic;
    i_axi_rready              : in  std_logic;
    --Read Request
    o_axis_tdata              : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_tstrb              : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;
    --Read Return
    i_axis_tdata              : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_axis_tstrb              : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);--UnUsed
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    i_return_adr              : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);--Don't change this value on the AXI bus sequence.

    i_decerr_en               : in  std_logic;
    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BRG_AXI4_AXI4S_RD;
architecture RTL of IM_BRG_AXI4_AXI4S_RD is
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
  constant TO_CNT             : integer := G_TO_CNT;

  signal trs_a                : boolean := FALSE;
  signal trs_r                : boolean := FALSE;
  signal trs_treq             : boolean := FALSE;
  signal trs_trtn             : boolean := FALSE;
  signal snd_adr              : boolean := FALSE;
  signal snd_dat              : boolean := FALSE;
  signal wrap_len             : integer range 0 to 4 := 0;
  signal adr_cntr             : std_logic_vector(ADR_RNG_H downto 0) := (others => '0');
  signal adr_cntr_add         : std_logic_vector(adr_cntr'range) := (others => '0');
  signal to_cntr              : integer range 0 to TO_CNT := 0;
  signal len_cntr             : integer range 0 to 256 := 0;
  signal adr_step             : std_logic_vector(adr_cntr'range) := (others => '0');
  signal flag_ad              : boolean := FALSE;
  signal snd_vld              : boolean := FALSE;
  signal rtn_vld              : boolean := FALSE;
  signal adr_vld              : boolean := FALSE;
  signal wrap_rng             : integer range 0 to 12 := 0;
  signal o_axi_arready_buf    : std_logic := '0';
  signal o_axi_rid_buf        : std_logic_vector(o_axi_rid  'range) := (others => '0');
  signal o_axi_rdata_buf      : std_logic_vector(o_axi_rdata'range) := (others => '0');
  signal o_axi_rresp_buf      : std_logic_vector(o_axi_rresp'range) := (others => '0');
  signal o_axi_rlast_buf      : std_logic := '0';
  signal o_axi_rvalid_buf     : std_logic := '0';
  signal o_axis_tdata_buf     : std_logic_vector(o_axis_tdata'range) := (others => '0');
  signal o_axis_tstrb_buf     : std_logic_vector(o_axis_tstrb'range) := (others => '0');
  signal o_axis_tlast_buf     : std_logic := '0';
  signal o_axis_tvalid_buf    : std_logic := '0';
begin
  trs_a                       <= i_axi_arvalid     = '1' and o_axi_arready_buf = '1';
  trs_r                       <= o_axi_rvalid_buf  = '1' and i_axi_rready      = '1';
  trs_treq                    <= o_axis_tvalid_buf = '1' and i_axis_tready     = '1';
  trs_trtn                    <= i_axis_tvalid     = '1';
  snd_adr                     <= (o_axis_tvalid_buf = '0' or i_axis_tready = '1') and snd_vld and flag_ad and rtn_vld = FALSE;
  snd_dat                     <= (o_axis_tvalid_buf = '0' or i_axis_tready = '1') and snd_vld and flag_ad = FALSE;
  adr_cntr_add                <= adr_cntr + adr_step;
  o_axi_arready_buf           <= '0' when (snd_vld or rtn_vld or i_rst = '1') else '1';

  wrap_len                    <=
    1 when (i_axi_arlen =  1) else--2Burst
    2 when (i_axi_arlen =  3) else--4Burst
    3 when (i_axi_arlen =  7) else--8Burst
    4 when (i_axi_arlen = 15) else--16Burst
    0;

  process (i_clk)
    variable rdat_set         : boolean;
    variable rdat_to          : boolean;
  begin
  if (i_clk'event and i_clk = '1') then
    rdat_set                  := FALSE;
    rdat_to                   := FALSE;

    if    (to_cntr /= 0) then
      to_cntr                 <= to_cntr - 1;
    end if;

    if    (to_cntr = 1) then--タイムアウト発生
      rdat_to                 := TRUE;
    end if;

    if    (i_axi_rready = '1') then
      o_axi_rdata_buf         <= (others => '0');
      o_axi_rresp_buf         <= (others => '0');
      o_axi_rlast_buf         <= '0';
      o_axi_rvalid_buf        <= '0';
    end if;

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
      rtn_vld                 <= TRUE;
      o_axis_tdata_buf(ADR_RNG_H downto ADR_RNG_L)     <= adr_cntr(ADR_RNG_H downto ADR_RNG_L);
      o_axis_tdata_buf(0)     <= '1';--Read Request Flag
      o_axis_tstrb_buf        <= (others => '1');
      o_axis_tvalid_buf       <= '1';
    end if;

    if    (snd_dat) then
      len_cntr                <= len_cntr - 1;
      flag_ad                 <= TRUE;
      o_axis_tdata_buf(ADR_RNG_H downto ADR_RNG_L)     <= i_return_adr(ADR_RNG_H downto ADR_RNG_L);
      o_axis_tstrb_buf        <= (others => '1');
      o_axis_tlast_buf        <= '1';
      o_axis_tvalid_buf       <= '1';
      if    (len_cntr = 1) then
        snd_vld               <= FALSE;
      end if;
    end if;

    if    (trs_treq) then--Read Requestが流れたら、タイムアウトカウント開始
      if    (o_axis_tlast_buf = '1') then
        to_cntr               <= TO_CNT;
      end if;
    end if;

    if    (trs_trtn) then
      adr_vld                 <= FALSE;
      if    (i_axis_tlast = '0') then
        if    (i_axis_tdata(ADR_RNG_H downto ADR_RNG_L) = i_return_adr(ADR_RNG_H downto ADR_RNG_L)) then
          if    (i_axis_tdata(0) = '0') then
            adr_vld           <= rtn_vld;
          end if;
        end if;
      elsif   (adr_vld) then
        rdat_set              := TRUE;
      end if;
    end if;

    if   (rdat_set or rdat_to) then
      to_cntr                 <= 0;
      adr_vld                 <= FALSE;

      if    (i_decerr_en = '1') then
        o_axi_rresp_buf       <= "11";
      end if;

      if    (rdat_set) then
        o_axi_rdata_buf       <= i_axis_tdata;
        o_axi_rresp_buf       <= "00";
      end if;

      o_axi_rlast_buf         <= '0';
      if    (snd_vld = FALSE) then
        o_axi_rlast_buf       <= '1';
      end if;

      o_axi_rvalid_buf        <= '1';
    end if;

    if    (trs_r) then
      rtn_vld                 <= FALSE;
    end if;

    if    (trs_a) then
      adr_cntr                <= i_axi_araddr(adr_cntr'range);
      len_cntr                <= conv_integer(i_axi_arlen) + 1;
      adr_step                <= (others => '0');
      for L in 0 to 7 loop
        if    (L = i_axi_arsize) then
          adr_step(L)         <= '1';
        end if;
      end loop;
      flag_ad                 <= TRUE;
      snd_vld                 <= TRUE;
      rtn_vld                 <= FALSE;

      if    (i_axi_arburst = 1) then--INCR
        wrap_rng              <= 12;
      elsif (i_axi_arburst = 2) then--WRAP
        wrap_rng              <= conv_integer(i_axi_arsize) + wrap_len;
      else
        wrap_rng              <= 0;--FIXED
      end if;

      o_axi_rid_buf           <= i_axi_arid;
    end if;

    if    (i_rst = '1') then
      to_cntr                 <= 0;
      len_cntr                <= 0;
      snd_vld                 <= FALSE;
      rtn_vld                 <= FALSE;
      adr_vld                 <= FALSE;
      o_axi_rid_buf           <= (others => '0');
      o_axi_rdata_buf         <= (others => '0');
      o_axi_rresp_buf         <= (others => '0');
      o_axi_rlast_buf         <= '0';
      o_axi_rvalid_buf        <= '0';
      o_axis_tdata_buf        <= (others => '0');
      o_axis_tstrb_buf        <= (others => '0');
      o_axis_tlast_buf        <= '0';
      o_axis_tvalid_buf       <= '0';
    end if;
  end if;
  end process;
  o_axi_arready               <= o_axi_arready_buf;
  o_axi_rid                   <= o_axi_rid_buf;
  o_axi_rdata                 <= o_axi_rdata_buf;
  o_axi_rresp                 <= o_axi_rresp_buf;
  o_axi_rlast                 <= o_axi_rlast_buf;
  o_axi_rvalid                <= o_axi_rvalid_buf;
  o_axis_tdata                <= o_axis_tdata_buf;
  o_axis_tstrb                <= o_axis_tstrb_buf;
  o_axis_tlast                <= o_axis_tlast_buf;
  o_axis_tvalid               <= o_axis_tvalid_buf;
  o_axis_tready               <= '1';--Always '1'
end RTL;
