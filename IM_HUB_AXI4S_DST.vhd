--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_HUB_AXI4S_DST is
  generic (
    G_DAT_WIDTH               : integer
  );
  port (
    i_axis_tdata              : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_axis_tstrb              : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    o_axis_0_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_0_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_0_tlast            : out std_logic;
    o_axis_0_tvalid           : out std_logic;
    i_axis_0_tready           : in  std_logic := '1';

    o_axis_1_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_1_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_1_tlast            : out std_logic;
    o_axis_1_tvalid           : out std_logic;
    i_axis_1_tready           : in  std_logic := '1';

    o_axis_2_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_2_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_2_tlast            : out std_logic;
    o_axis_2_tvalid           : out std_logic;
    i_axis_2_tready           : in  std_logic := '1';

    o_axis_3_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_3_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_3_tlast            : out std_logic;
    o_axis_3_tvalid           : out std_logic;
    i_axis_3_tready           : in  std_logic := '1';

    o_axis_4_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_4_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_4_tlast            : out std_logic;
    o_axis_4_tvalid           : out std_logic;
    i_axis_4_tready           : in  std_logic := '1';

    o_axis_5_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_5_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_5_tlast            : out std_logic;
    o_axis_5_tvalid           : out std_logic;
    i_axis_5_tready           : in  std_logic := '1';

    o_axis_6_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_6_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_6_tlast            : out std_logic;
    o_axis_6_tvalid           : out std_logic;
    i_axis_6_tready           : in  std_logic := '1';

    o_axis_7_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_7_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_7_tlast            : out std_logic;
    o_axis_7_tvalid           : out std_logic;
    i_axis_7_tready           : in  std_logic := '1';

    o_axis_8_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_8_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_8_tlast            : out std_logic;
    o_axis_8_tvalid           : out std_logic;
    i_axis_8_tready           : in  std_logic := '1';

    o_axis_9_tdata            : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_9_tstrb            : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_9_tlast            : out std_logic;
    o_axis_9_tvalid           : out std_logic;
    i_axis_9_tready           : in  std_logic := '1';

    o_axis_10_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_10_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_10_tlast           : out std_logic;
    o_axis_10_tvalid          : out std_logic;
    i_axis_10_tready          : in  std_logic := '1';

    o_axis_11_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_11_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_11_tlast           : out std_logic;
    o_axis_11_tvalid          : out std_logic;
    i_axis_11_tready          : in  std_logic := '1';

    o_axis_12_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_12_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_12_tlast           : out std_logic;
    o_axis_12_tvalid          : out std_logic;
    i_axis_12_tready          : in  std_logic := '1';

    o_axis_13_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_13_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_13_tlast           : out std_logic;
    o_axis_13_tvalid          : out std_logic;
    i_axis_13_tready          : in  std_logic := '1';

    o_axis_14_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_14_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_14_tlast           : out std_logic;
    o_axis_14_tvalid          : out std_logic;
    i_axis_14_tready          : in  std_logic := '1';

    o_axis_15_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_15_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_15_tlast           : out std_logic;
    o_axis_15_tvalid          : out std_logic;
    i_axis_15_tready          : in  std_logic := '1';

    o_axis_16_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_16_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_16_tlast           : out std_logic;
    o_axis_16_tvalid          : out std_logic;
    i_axis_16_tready          : in  std_logic := '1';

    o_axis_17_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_17_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_17_tlast           : out std_logic;
    o_axis_17_tvalid          : out std_logic;
    i_axis_17_tready          : in  std_logic := '1';

    o_axis_18_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_18_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_18_tlast           : out std_logic;
    o_axis_18_tvalid          : out std_logic;
    i_axis_18_tready          : in  std_logic := '1';

    o_axis_19_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_19_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_19_tlast           : out std_logic;
    o_axis_19_tvalid          : out std_logic;
    i_axis_19_tready          : in  std_logic := '1';

    o_axis_20_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_20_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_20_tlast           : out std_logic;
    o_axis_20_tvalid          : out std_logic;
    i_axis_20_tready          : in  std_logic := '1';

    o_axis_21_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_21_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_21_tlast           : out std_logic;
    o_axis_21_tvalid          : out std_logic;
    i_axis_21_tready          : in  std_logic := '1';

    o_axis_22_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_22_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_22_tlast           : out std_logic;
    o_axis_22_tvalid          : out std_logic;
    i_axis_22_tready          : in  std_logic := '1';

    o_axis_23_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_23_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_23_tlast           : out std_logic;
    o_axis_23_tvalid          : out std_logic;
    i_axis_23_tready          : in  std_logic := '1';

    o_axis_24_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_24_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_24_tlast           : out std_logic;
    o_axis_24_tvalid          : out std_logic;
    i_axis_24_tready          : in  std_logic := '1';

    o_axis_25_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_25_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_25_tlast           : out std_logic;
    o_axis_25_tvalid          : out std_logic;
    i_axis_25_tready          : in  std_logic := '1';

    o_axis_26_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_26_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_26_tlast           : out std_logic;
    o_axis_26_tvalid          : out std_logic;
    i_axis_26_tready          : in  std_logic := '1';

    o_axis_27_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_27_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_27_tlast           : out std_logic;
    o_axis_27_tvalid          : out std_logic;
    i_axis_27_tready          : in  std_logic := '1';

    o_axis_28_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_28_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_28_tlast           : out std_logic;
    o_axis_28_tvalid          : out std_logic;
    i_axis_28_tready          : in  std_logic := '1';

    o_axis_29_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_29_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_29_tlast           : out std_logic;
    o_axis_29_tvalid          : out std_logic;
    i_axis_29_tready          : in  std_logic := '1';

    o_axis_30_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_30_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_30_tlast           : out std_logic;
    o_axis_30_tvalid          : out std_logic;
    i_axis_30_tready          : in  std_logic := '1';

    o_axis_31_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_31_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_31_tlast           : out std_logic;
    o_axis_31_tvalid          : out std_logic;
    i_axis_31_tready          : in  std_logic := '1';

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_HUB_AXI4S_DST;
architecture RTL of IM_HUB_AXI4S_DST is
  constant ARR_CNT                      : integer := 32 - 1;

  signal i_axis_tready                  : std_logic_vector(ARR_CNT downto 0) := (others => '0');
  signal trs_in                         : boolean := FALSE;
  signal tready_n                       : std_logic_vector(ARR_CNT downto 0) := (others => '0');
  signal tvalid                         : std_logic_vector(ARR_CNT downto 0) := (others => '1');
  signal o_axis_tready_buf              : std_logic := '0';
  signal o_axis_tvalid_buf              : std_logic_vector(ARR_CNT downto 0) := (others => '0');
begin
  i_axis_tready(0)            <= i_axis_0_tready;
  i_axis_tready(1)            <= i_axis_1_tready;
  i_axis_tready(2)            <= i_axis_2_tready;
  i_axis_tready(3)            <= i_axis_3_tready;
  i_axis_tready(4)            <= i_axis_4_tready;
  i_axis_tready(5)            <= i_axis_5_tready;
  i_axis_tready(6)            <= i_axis_6_tready;
  i_axis_tready(7)            <= i_axis_7_tready;
  i_axis_tready(8)            <= i_axis_8_tready;
  i_axis_tready(9)            <= i_axis_9_tready;
  i_axis_tready(10)           <= i_axis_10_tready;
  i_axis_tready(11)           <= i_axis_11_tready;
  i_axis_tready(12)           <= i_axis_12_tready;
  i_axis_tready(13)           <= i_axis_13_tready;
  i_axis_tready(14)           <= i_axis_14_tready;
  i_axis_tready(15)           <= i_axis_15_tready;
  i_axis_tready(16)           <= i_axis_16_tready;
  i_axis_tready(17)           <= i_axis_17_tready;
  i_axis_tready(18)           <= i_axis_18_tready;
  i_axis_tready(19)           <= i_axis_19_tready;
  i_axis_tready(20)           <= i_axis_20_tready;
  i_axis_tready(21)           <= i_axis_21_tready;
  i_axis_tready(22)           <= i_axis_22_tready;
  i_axis_tready(23)           <= i_axis_23_tready;
  i_axis_tready(24)           <= i_axis_24_tready;
  i_axis_tready(25)           <= i_axis_25_tready;
  i_axis_tready(26)           <= i_axis_26_tready;
  i_axis_tready(27)           <= i_axis_27_tready;
  i_axis_tready(28)           <= i_axis_28_tready;
  i_axis_tready(29)           <= i_axis_29_tready;
  i_axis_tready(30)           <= i_axis_30_tready;
  i_axis_tready(31)           <= i_axis_31_tready;

  trs_in                      <= i_axis_tvalid = '1' and o_axis_tready_buf = '1';

  o_axis_tready_buf           <= '1' when (tready_n = 0) else '0';

  g_loop : for L in ARR_CNT downto 0 generate
    tready_n(L)               <= '0' when (tvalid(L) = '0' or i_axis_tready(L) = '1') else '1';
    o_axis_tvalid_buf(L)      <= i_axis_tvalid and tvalid(L);
  end generate;

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    for L in ARR_CNT downto 0 loop
      if    (i_axis_tvalid = '1' and i_axis_tready(L) = '1') then
        tvalid(L)             <= '0';
      end if;
    end loop;

    if    (trs_in) then
      tvalid                  <= (others => '1');
    end if;

    if    (i_rst = '1') then
      tvalid                  <= (others => '1');
    end if;
  end if;
  end process;
  o_axis_tready               <= o_axis_tready_buf;

  o_axis_0_tdata              <= i_axis_tdata;
  o_axis_0_tstrb              <= i_axis_tstrb;
  o_axis_0_tlast              <= i_axis_tlast;
  o_axis_0_tvalid             <= o_axis_tvalid_buf(0);

  o_axis_1_tdata              <= i_axis_tdata;
  o_axis_1_tstrb              <= i_axis_tstrb;
  o_axis_1_tlast              <= i_axis_tlast;
  o_axis_1_tvalid             <= o_axis_tvalid_buf(1);

  o_axis_2_tdata              <= i_axis_tdata;
  o_axis_2_tstrb              <= i_axis_tstrb;
  o_axis_2_tlast              <= i_axis_tlast;
  o_axis_2_tvalid             <= o_axis_tvalid_buf(2);

  o_axis_3_tdata              <= i_axis_tdata;
  o_axis_3_tstrb              <= i_axis_tstrb;
  o_axis_3_tlast              <= i_axis_tlast;
  o_axis_3_tvalid             <= o_axis_tvalid_buf(3);

  o_axis_4_tdata              <= i_axis_tdata;
  o_axis_4_tstrb              <= i_axis_tstrb;
  o_axis_4_tlast              <= i_axis_tlast;
  o_axis_4_tvalid             <= o_axis_tvalid_buf(4);

  o_axis_5_tdata              <= i_axis_tdata;
  o_axis_5_tstrb              <= i_axis_tstrb;
  o_axis_5_tlast              <= i_axis_tlast;
  o_axis_5_tvalid             <= o_axis_tvalid_buf(5);

  o_axis_6_tdata              <= i_axis_tdata;
  o_axis_6_tstrb              <= i_axis_tstrb;
  o_axis_6_tlast              <= i_axis_tlast;
  o_axis_6_tvalid             <= o_axis_tvalid_buf(6);

  o_axis_7_tdata              <= i_axis_tdata;
  o_axis_7_tstrb              <= i_axis_tstrb;
  o_axis_7_tlast              <= i_axis_tlast;
  o_axis_7_tvalid             <= o_axis_tvalid_buf(7);

  o_axis_8_tdata              <= i_axis_tdata;
  o_axis_8_tstrb              <= i_axis_tstrb;
  o_axis_8_tlast              <= i_axis_tlast;
  o_axis_8_tvalid             <= o_axis_tvalid_buf(8);

  o_axis_9_tdata              <= i_axis_tdata;
  o_axis_9_tstrb              <= i_axis_tstrb;
  o_axis_9_tlast              <= i_axis_tlast;
  o_axis_9_tvalid             <= o_axis_tvalid_buf(9);

  o_axis_10_tdata             <= i_axis_tdata;
  o_axis_10_tstrb             <= i_axis_tstrb;
  o_axis_10_tlast             <= i_axis_tlast;
  o_axis_10_tvalid            <= o_axis_tvalid_buf(10);

  o_axis_11_tdata             <= i_axis_tdata;
  o_axis_11_tstrb             <= i_axis_tstrb;
  o_axis_11_tlast             <= i_axis_tlast;
  o_axis_11_tvalid            <= o_axis_tvalid_buf(11);

  o_axis_12_tdata             <= i_axis_tdata;
  o_axis_12_tstrb             <= i_axis_tstrb;
  o_axis_12_tlast             <= i_axis_tlast;
  o_axis_12_tvalid            <= o_axis_tvalid_buf(12);

  o_axis_13_tdata             <= i_axis_tdata;
  o_axis_13_tstrb             <= i_axis_tstrb;
  o_axis_13_tlast             <= i_axis_tlast;
  o_axis_13_tvalid            <= o_axis_tvalid_buf(13);

  o_axis_14_tdata             <= i_axis_tdata;
  o_axis_14_tstrb             <= i_axis_tstrb;
  o_axis_14_tlast             <= i_axis_tlast;
  o_axis_14_tvalid            <= o_axis_tvalid_buf(14);

  o_axis_15_tdata             <= i_axis_tdata;
  o_axis_15_tstrb             <= i_axis_tstrb;
  o_axis_15_tlast             <= i_axis_tlast;
  o_axis_15_tvalid            <= o_axis_tvalid_buf(15);

  o_axis_16_tdata             <= i_axis_tdata;
  o_axis_16_tstrb             <= i_axis_tstrb;
  o_axis_16_tlast             <= i_axis_tlast;
  o_axis_16_tvalid            <= o_axis_tvalid_buf(16);

  o_axis_17_tdata             <= i_axis_tdata;
  o_axis_17_tstrb             <= i_axis_tstrb;
  o_axis_17_tlast             <= i_axis_tlast;
  o_axis_17_tvalid            <= o_axis_tvalid_buf(17);

  o_axis_18_tdata             <= i_axis_tdata;
  o_axis_18_tstrb             <= i_axis_tstrb;
  o_axis_18_tlast             <= i_axis_tlast;
  o_axis_18_tvalid            <= o_axis_tvalid_buf(18);

  o_axis_19_tdata             <= i_axis_tdata;
  o_axis_19_tstrb             <= i_axis_tstrb;
  o_axis_19_tlast             <= i_axis_tlast;
  o_axis_19_tvalid            <= o_axis_tvalid_buf(19);

  o_axis_20_tdata             <= i_axis_tdata;
  o_axis_20_tstrb             <= i_axis_tstrb;
  o_axis_20_tlast             <= i_axis_tlast;
  o_axis_20_tvalid            <= o_axis_tvalid_buf(20);

  o_axis_21_tdata             <= i_axis_tdata;
  o_axis_21_tstrb             <= i_axis_tstrb;
  o_axis_21_tlast             <= i_axis_tlast;
  o_axis_21_tvalid            <= o_axis_tvalid_buf(21);

  o_axis_22_tdata             <= i_axis_tdata;
  o_axis_22_tstrb             <= i_axis_tstrb;
  o_axis_22_tlast             <= i_axis_tlast;
  o_axis_22_tvalid            <= o_axis_tvalid_buf(22);

  o_axis_23_tdata             <= i_axis_tdata;
  o_axis_23_tstrb             <= i_axis_tstrb;
  o_axis_23_tlast             <= i_axis_tlast;
  o_axis_23_tvalid            <= o_axis_tvalid_buf(23);

  o_axis_24_tdata             <= i_axis_tdata;
  o_axis_24_tstrb             <= i_axis_tstrb;
  o_axis_24_tlast             <= i_axis_tlast;
  o_axis_24_tvalid            <= o_axis_tvalid_buf(24);

  o_axis_25_tdata             <= i_axis_tdata;
  o_axis_25_tstrb             <= i_axis_tstrb;
  o_axis_25_tlast             <= i_axis_tlast;
  o_axis_25_tvalid            <= o_axis_tvalid_buf(25);

  o_axis_26_tdata             <= i_axis_tdata;
  o_axis_26_tstrb             <= i_axis_tstrb;
  o_axis_26_tlast             <= i_axis_tlast;
  o_axis_26_tvalid            <= o_axis_tvalid_buf(26);

  o_axis_27_tdata             <= i_axis_tdata;
  o_axis_27_tstrb             <= i_axis_tstrb;
  o_axis_27_tlast             <= i_axis_tlast;
  o_axis_27_tvalid            <= o_axis_tvalid_buf(27);

  o_axis_28_tdata             <= i_axis_tdata;
  o_axis_28_tstrb             <= i_axis_tstrb;
  o_axis_28_tlast             <= i_axis_tlast;
  o_axis_28_tvalid            <= o_axis_tvalid_buf(28);

  o_axis_29_tdata             <= i_axis_tdata;
  o_axis_29_tstrb             <= i_axis_tstrb;
  o_axis_29_tlast             <= i_axis_tlast;
  o_axis_29_tvalid            <= o_axis_tvalid_buf(29);

  o_axis_30_tdata             <= i_axis_tdata;
  o_axis_30_tstrb             <= i_axis_tstrb;
  o_axis_30_tlast             <= i_axis_tlast;
  o_axis_30_tvalid            <= o_axis_tvalid_buf(30);

  o_axis_31_tdata             <= i_axis_tdata;
  o_axis_31_tstrb             <= i_axis_tstrb;
  o_axis_31_tlast             <= i_axis_tlast;
  o_axis_31_tvalid            <= o_axis_tvalid_buf(31);
end RTL;
