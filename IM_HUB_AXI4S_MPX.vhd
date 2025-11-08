--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_HUB_AXI4S_MPX is
  generic (
    G_DAT_WIDTH               : integer
  );
  port (
    i_axis_0_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_0_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_0_tlast            : in  std_logic := '0';
    i_axis_0_tvalid           : in  std_logic := '0';
    o_axis_0_tready           : out std_logic;

    i_axis_1_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_1_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_1_tlast            : in  std_logic := '0';
    i_axis_1_tvalid           : in  std_logic := '0';
    o_axis_1_tready           : out std_logic;

    i_axis_2_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_2_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_2_tlast            : in  std_logic := '0';
    i_axis_2_tvalid           : in  std_logic := '0';
    o_axis_2_tready           : out std_logic;

    i_axis_3_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_3_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_3_tlast            : in  std_logic := '0';
    i_axis_3_tvalid           : in  std_logic := '0';
    o_axis_3_tready           : out std_logic;

    i_axis_4_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_4_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_4_tlast            : in  std_logic := '0';
    i_axis_4_tvalid           : in  std_logic := '0';
    o_axis_4_tready           : out std_logic;

    i_axis_5_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_5_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_5_tlast            : in  std_logic := '0';
    i_axis_5_tvalid           : in  std_logic := '0';
    o_axis_5_tready           : out std_logic;

    i_axis_6_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_6_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_6_tlast            : in  std_logic := '0';
    i_axis_6_tvalid           : in  std_logic := '0';
    o_axis_6_tready           : out std_logic;

    i_axis_7_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_7_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_7_tlast            : in  std_logic := '0';
    i_axis_7_tvalid           : in  std_logic := '0';
    o_axis_7_tready           : out std_logic;

    i_axis_8_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_8_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_8_tlast            : in  std_logic := '0';
    i_axis_8_tvalid           : in  std_logic := '0';
    o_axis_8_tready           : out std_logic;

    i_axis_9_tdata            : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_9_tstrb            : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_9_tlast            : in  std_logic := '0';
    i_axis_9_tvalid           : in  std_logic := '0';
    o_axis_9_tready           : out std_logic;

    i_axis_10_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_10_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_10_tlast           : in  std_logic := '0';
    i_axis_10_tvalid          : in  std_logic := '0';
    o_axis_10_tready          : out std_logic;

    i_axis_11_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_11_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_11_tlast           : in  std_logic := '0';
    i_axis_11_tvalid          : in  std_logic := '0';
    o_axis_11_tready          : out std_logic;

    i_axis_12_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_12_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_12_tlast           : in  std_logic := '0';
    i_axis_12_tvalid          : in  std_logic := '0';
    o_axis_12_tready          : out std_logic;

    i_axis_13_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_13_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_13_tlast           : in  std_logic := '0';
    i_axis_13_tvalid          : in  std_logic := '0';
    o_axis_13_tready          : out std_logic;

    i_axis_14_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_14_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_14_tlast           : in  std_logic := '0';
    i_axis_14_tvalid          : in  std_logic := '0';
    o_axis_14_tready          : out std_logic;

    i_axis_15_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_15_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_15_tlast           : in  std_logic := '0';
    i_axis_15_tvalid          : in  std_logic := '0';
    o_axis_15_tready          : out std_logic;

    i_axis_16_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_16_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_16_tlast           : in  std_logic := '0';
    i_axis_16_tvalid          : in  std_logic := '0';
    o_axis_16_tready          : out std_logic;

    i_axis_17_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_17_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_17_tlast           : in  std_logic := '0';
    i_axis_17_tvalid          : in  std_logic := '0';
    o_axis_17_tready          : out std_logic;

    i_axis_18_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_18_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_18_tlast           : in  std_logic := '0';
    i_axis_18_tvalid          : in  std_logic := '0';
    o_axis_18_tready          : out std_logic;

    i_axis_19_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_19_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_19_tlast           : in  std_logic := '0';
    i_axis_19_tvalid          : in  std_logic := '0';
    o_axis_19_tready          : out std_logic;

    i_axis_20_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_20_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_20_tlast           : in  std_logic := '0';
    i_axis_20_tvalid          : in  std_logic := '0';
    o_axis_20_tready          : out std_logic;

    i_axis_21_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_21_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_21_tlast           : in  std_logic := '0';
    i_axis_21_tvalid          : in  std_logic := '0';
    o_axis_21_tready          : out std_logic;

    i_axis_22_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_22_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_22_tlast           : in  std_logic := '0';
    i_axis_22_tvalid          : in  std_logic := '0';
    o_axis_22_tready          : out std_logic;

    i_axis_23_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_23_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_23_tlast           : in  std_logic := '0';
    i_axis_23_tvalid          : in  std_logic := '0';
    o_axis_23_tready          : out std_logic;

    i_axis_24_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_24_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_24_tlast           : in  std_logic := '0';
    i_axis_24_tvalid          : in  std_logic := '0';
    o_axis_24_tready          : out std_logic;

    i_axis_25_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_25_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_25_tlast           : in  std_logic := '0';
    i_axis_25_tvalid          : in  std_logic := '0';
    o_axis_25_tready          : out std_logic;

    i_axis_26_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_26_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_26_tlast           : in  std_logic := '0';
    i_axis_26_tvalid          : in  std_logic := '0';
    o_axis_26_tready          : out std_logic;

    i_axis_27_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_27_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_27_tlast           : in  std_logic := '0';
    i_axis_27_tvalid          : in  std_logic := '0';
    o_axis_27_tready          : out std_logic;

    i_axis_28_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_28_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_28_tlast           : in  std_logic := '0';
    i_axis_28_tvalid          : in  std_logic := '0';
    o_axis_28_tready          : out std_logic;

    i_axis_29_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_29_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_29_tlast           : in  std_logic := '0';
    i_axis_29_tvalid          : in  std_logic := '0';
    o_axis_29_tready          : out std_logic;

    i_axis_30_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_30_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_30_tlast           : in  std_logic := '0';
    i_axis_30_tvalid          : in  std_logic := '0';
    o_axis_30_tready          : out std_logic;

    i_axis_31_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_31_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_31_tlast           : in  std_logic := '0';
    i_axis_31_tvalid          : in  std_logic := '0';
    o_axis_31_tready          : out std_logic;

    o_axis_tdata              : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_tstrb              : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_HUB_AXI4S_MPX;
architecture RTL of IM_HUB_AXI4S_MPX is
  constant ARR_CNT                      : integer := 32 - 1;

  type TYP_DAT_ARR is array (ARR_CNT downto 0) of std_logic_vector(o_axis_tdata'range);
  type TYP_STR_ARR is array (ARR_CNT downto 0) of std_logic_vector(o_axis_tstrb'range);

  signal i_axis_tdata                   : TYP_DAT_ARR := (others => (others => '0'));
  signal i_axis_tstrb                   : TYP_STR_ARR := (others => (others => '0'));
  signal i_axis_tlast                   : std_logic_vector(ARR_CNT downto 0) := (others => '0');
  signal i_axis_tvalid                  : std_logic_vector(ARR_CNT downto 0) := (others => '0');
  signal trs_out                        : boolean := FALSE;
  signal mpx_sel                        : integer range 0 to ARR_CNT := 0;
  signal mpx_sel_lat                    : integer range 0 to ARR_CNT := ARR_CNT;
  signal mpx_sel_unlock                 : boolean := TRUE;
  signal o_axis_tready_buf              : std_logic_vector(ARR_CNT downto 0) := (others => '0');
  signal o_axis_tdata_buf               : std_logic_vector(o_axis_tdata'range) := (others => '0');
  signal o_axis_tstrb_buf               : std_logic_vector(o_axis_tstrb'range) := (others => '0');
  signal o_axis_tlast_buf               : std_logic := '0';
  signal o_axis_tvalid_buf              : std_logic := '0';
begin
  i_axis_tdata (0)            <= i_axis_0_tdata;
  i_axis_tstrb (0)            <= i_axis_0_tstrb;
  i_axis_tlast (0)            <= i_axis_0_tlast;
  i_axis_tvalid(0)            <= i_axis_0_tvalid;

  i_axis_tdata (1)            <= i_axis_1_tdata;
  i_axis_tstrb (1)            <= i_axis_1_tstrb;
  i_axis_tlast (1)            <= i_axis_1_tlast;
  i_axis_tvalid(1)            <= i_axis_1_tvalid;

  i_axis_tdata (2)            <= i_axis_2_tdata;
  i_axis_tstrb (2)            <= i_axis_2_tstrb;
  i_axis_tlast (2)            <= i_axis_2_tlast;
  i_axis_tvalid(2)            <= i_axis_2_tvalid;

  i_axis_tdata (3)            <= i_axis_3_tdata;
  i_axis_tstrb (3)            <= i_axis_3_tstrb;
  i_axis_tlast (3)            <= i_axis_3_tlast;
  i_axis_tvalid(3)            <= i_axis_3_tvalid;

  i_axis_tdata (4)            <= i_axis_4_tdata;
  i_axis_tstrb (4)            <= i_axis_4_tstrb;
  i_axis_tlast (4)            <= i_axis_4_tlast;
  i_axis_tvalid(4)            <= i_axis_4_tvalid;

  i_axis_tdata (5)            <= i_axis_5_tdata;
  i_axis_tstrb (5)            <= i_axis_5_tstrb;
  i_axis_tlast (5)            <= i_axis_5_tlast;
  i_axis_tvalid(5)            <= i_axis_5_tvalid;

  i_axis_tdata (6)            <= i_axis_6_tdata;
  i_axis_tstrb (6)            <= i_axis_6_tstrb;
  i_axis_tlast (6)            <= i_axis_6_tlast;
  i_axis_tvalid(6)            <= i_axis_6_tvalid;

  i_axis_tdata (7)            <= i_axis_7_tdata;
  i_axis_tstrb (7)            <= i_axis_7_tstrb;
  i_axis_tlast (7)            <= i_axis_7_tlast;
  i_axis_tvalid(7)            <= i_axis_7_tvalid;

  i_axis_tdata (8)            <= i_axis_8_tdata;
  i_axis_tstrb (8)            <= i_axis_8_tstrb;
  i_axis_tlast (8)            <= i_axis_8_tlast;
  i_axis_tvalid(8)            <= i_axis_8_tvalid;

  i_axis_tdata (9)            <= i_axis_9_tdata;
  i_axis_tstrb (9)            <= i_axis_9_tstrb;
  i_axis_tlast (9)            <= i_axis_9_tlast;
  i_axis_tvalid(9)            <= i_axis_9_tvalid;

  i_axis_tdata (10)           <= i_axis_10_tdata;
  i_axis_tstrb (10)           <= i_axis_10_tstrb;
  i_axis_tlast (10)           <= i_axis_10_tlast;
  i_axis_tvalid(10)           <= i_axis_10_tvalid;

  i_axis_tdata (11)           <= i_axis_11_tdata;
  i_axis_tstrb (11)           <= i_axis_11_tstrb;
  i_axis_tlast (11)           <= i_axis_11_tlast;
  i_axis_tvalid(11)           <= i_axis_11_tvalid;

  i_axis_tdata (12)           <= i_axis_12_tdata;
  i_axis_tstrb (12)           <= i_axis_12_tstrb;
  i_axis_tlast (12)           <= i_axis_12_tlast;
  i_axis_tvalid(12)           <= i_axis_12_tvalid;

  i_axis_tdata (13)           <= i_axis_13_tdata;
  i_axis_tstrb (13)           <= i_axis_13_tstrb;
  i_axis_tlast (13)           <= i_axis_13_tlast;
  i_axis_tvalid(13)           <= i_axis_13_tvalid;

  i_axis_tdata (14)           <= i_axis_14_tdata;
  i_axis_tstrb (14)           <= i_axis_14_tstrb;
  i_axis_tlast (14)           <= i_axis_14_tlast;
  i_axis_tvalid(14)           <= i_axis_14_tvalid;

  i_axis_tdata (15)           <= i_axis_15_tdata;
  i_axis_tstrb (15)           <= i_axis_15_tstrb;
  i_axis_tlast (15)           <= i_axis_15_tlast;
  i_axis_tvalid(15)           <= i_axis_15_tvalid;

  i_axis_tdata (16)           <= i_axis_16_tdata;
  i_axis_tstrb (16)           <= i_axis_16_tstrb;
  i_axis_tlast (16)           <= i_axis_16_tlast;
  i_axis_tvalid(16)           <= i_axis_16_tvalid;

  i_axis_tdata (17)           <= i_axis_17_tdata;
  i_axis_tstrb (17)           <= i_axis_17_tstrb;
  i_axis_tlast (17)           <= i_axis_17_tlast;
  i_axis_tvalid(17)           <= i_axis_17_tvalid;

  i_axis_tdata (18)           <= i_axis_18_tdata;
  i_axis_tstrb (18)           <= i_axis_18_tstrb;
  i_axis_tlast (18)           <= i_axis_18_tlast;
  i_axis_tvalid(18)           <= i_axis_18_tvalid;

  i_axis_tdata (19)           <= i_axis_19_tdata;
  i_axis_tstrb (19)           <= i_axis_19_tstrb;
  i_axis_tlast (19)           <= i_axis_19_tlast;
  i_axis_tvalid(19)           <= i_axis_19_tvalid;

  i_axis_tdata (20)           <= i_axis_20_tdata;
  i_axis_tstrb (20)           <= i_axis_20_tstrb;
  i_axis_tlast (20)           <= i_axis_20_tlast;
  i_axis_tvalid(20)           <= i_axis_20_tvalid;

  i_axis_tdata (21)           <= i_axis_21_tdata;
  i_axis_tstrb (21)           <= i_axis_21_tstrb;
  i_axis_tlast (21)           <= i_axis_21_tlast;
  i_axis_tvalid(21)           <= i_axis_21_tvalid;

  i_axis_tdata (22)           <= i_axis_22_tdata;
  i_axis_tstrb (22)           <= i_axis_22_tstrb;
  i_axis_tlast (22)           <= i_axis_22_tlast;
  i_axis_tvalid(22)           <= i_axis_22_tvalid;

  i_axis_tdata (23)           <= i_axis_23_tdata;
  i_axis_tstrb (23)           <= i_axis_23_tstrb;
  i_axis_tlast (23)           <= i_axis_23_tlast;
  i_axis_tvalid(23)           <= i_axis_23_tvalid;

  i_axis_tdata (24)           <= i_axis_24_tdata;
  i_axis_tstrb (24)           <= i_axis_24_tstrb;
  i_axis_tlast (24)           <= i_axis_24_tlast;
  i_axis_tvalid(24)           <= i_axis_24_tvalid;

  i_axis_tdata (25)           <= i_axis_25_tdata;
  i_axis_tstrb (25)           <= i_axis_25_tstrb;
  i_axis_tlast (25)           <= i_axis_25_tlast;
  i_axis_tvalid(25)           <= i_axis_25_tvalid;

  i_axis_tdata (26)           <= i_axis_26_tdata;
  i_axis_tstrb (26)           <= i_axis_26_tstrb;
  i_axis_tlast (26)           <= i_axis_26_tlast;
  i_axis_tvalid(26)           <= i_axis_26_tvalid;

  i_axis_tdata (27)           <= i_axis_27_tdata;
  i_axis_tstrb (27)           <= i_axis_27_tstrb;
  i_axis_tlast (27)           <= i_axis_27_tlast;
  i_axis_tvalid(27)           <= i_axis_27_tvalid;

  i_axis_tdata (28)           <= i_axis_28_tdata;
  i_axis_tstrb (28)           <= i_axis_28_tstrb;
  i_axis_tlast (28)           <= i_axis_28_tlast;
  i_axis_tvalid(28)           <= i_axis_28_tvalid;

  i_axis_tdata (29)           <= i_axis_29_tdata;
  i_axis_tstrb (29)           <= i_axis_29_tstrb;
  i_axis_tlast (29)           <= i_axis_29_tlast;
  i_axis_tvalid(29)           <= i_axis_29_tvalid;

  i_axis_tdata (30)           <= i_axis_30_tdata;
  i_axis_tstrb (30)           <= i_axis_30_tstrb;
  i_axis_tlast (30)           <= i_axis_30_tlast;
  i_axis_tvalid(30)           <= i_axis_30_tvalid;

  i_axis_tdata (31)           <= i_axis_31_tdata;
  i_axis_tstrb (31)           <= i_axis_31_tstrb;
  i_axis_tlast (31)           <= i_axis_31_tlast;
  i_axis_tvalid(31)           <= i_axis_31_tvalid;

  o_axis_0_tready             <= o_axis_tready_buf(0);
  o_axis_1_tready             <= o_axis_tready_buf(1);
  o_axis_2_tready             <= o_axis_tready_buf(2);
  o_axis_3_tready             <= o_axis_tready_buf(3);
  o_axis_4_tready             <= o_axis_tready_buf(4);
  o_axis_5_tready             <= o_axis_tready_buf(5);
  o_axis_6_tready             <= o_axis_tready_buf(6);
  o_axis_7_tready             <= o_axis_tready_buf(7);
  o_axis_8_tready             <= o_axis_tready_buf(8);
  o_axis_9_tready             <= o_axis_tready_buf(9);
  o_axis_10_tready            <= o_axis_tready_buf(10);
  o_axis_11_tready            <= o_axis_tready_buf(11);
  o_axis_12_tready            <= o_axis_tready_buf(12);
  o_axis_13_tready            <= o_axis_tready_buf(13);
  o_axis_14_tready            <= o_axis_tready_buf(14);
  o_axis_15_tready            <= o_axis_tready_buf(15);
  o_axis_16_tready            <= o_axis_tready_buf(16);
  o_axis_17_tready            <= o_axis_tready_buf(17);
  o_axis_18_tready            <= o_axis_tready_buf(18);
  o_axis_19_tready            <= o_axis_tready_buf(19);
  o_axis_20_tready            <= o_axis_tready_buf(20);
  o_axis_21_tready            <= o_axis_tready_buf(21);
  o_axis_22_tready            <= o_axis_tready_buf(22);
  o_axis_23_tready            <= o_axis_tready_buf(23);
  o_axis_24_tready            <= o_axis_tready_buf(24);
  o_axis_25_tready            <= o_axis_tready_buf(25);
  o_axis_26_tready            <= o_axis_tready_buf(26);
  o_axis_27_tready            <= o_axis_tready_buf(27);
  o_axis_28_tready            <= o_axis_tready_buf(28);
  o_axis_29_tready            <= o_axis_tready_buf(29);
  o_axis_30_tready            <= o_axis_tready_buf(30);
  o_axis_31_tready            <= o_axis_tready_buf(31);

  g_tready : for L in o_axis_tready_buf'range generate
    o_axis_tready_buf(L)      <= i_axis_tready when (mpx_sel = L) else '0';
  end generate;

  trs_out                     <= o_axis_tvalid_buf = '1' and i_axis_tready = '1';

  process (i_axis_tvalid, mpx_sel_lat, mpx_sel_unlock)
  begin
    mpx_sel                   <= mpx_sel_lat;
    if    (mpx_sel_unlock) then
      for L in ARR_CNT downto 0 loop
        if    (i_axis_tvalid(L) = '1') then
          mpx_sel             <= L;
        end if;
      end loop;

      for L in ARR_CNT downto 0 loop
        if (L > mpx_sel_lat) then
          if    (i_axis_tvalid(L) = '1') then
            mpx_sel           <= L;
          end if;
        end if;
      end loop;
    end if;
  end process;

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    if    (trs_out) then
      if    (o_axis_tlast_buf = '0') then
        mpx_sel_lat           <= mpx_sel;
        mpx_sel_unlock        <= FALSE;
      else
        if    (mpx_sel_unlock) then
          mpx_sel_lat         <= mpx_sel;
        end if;
        mpx_sel_unlock        <= TRUE;
      end if;
    end if;

    if    (i_rst = '1') then
      mpx_sel_lat             <= ARR_CNT;
      mpx_sel_unlock          <= TRUE;
    end if;
  end if;
  end process;
  o_axis_tdata_buf            <= i_axis_tdata (mpx_sel);
  o_axis_tstrb_buf            <= i_axis_tstrb (mpx_sel);
  o_axis_tlast_buf            <= i_axis_tlast (mpx_sel);
  o_axis_tvalid_buf           <= i_axis_tvalid(mpx_sel);

  o_axis_tdata                <= o_axis_tdata_buf;
  o_axis_tstrb                <= o_axis_tstrb_buf;
  o_axis_tlast                <= o_axis_tlast_buf;
  o_axis_tvalid               <= o_axis_tvalid_buf;
end RTL;
