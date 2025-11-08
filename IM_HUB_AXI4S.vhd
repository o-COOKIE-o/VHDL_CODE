--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_HUB_AXI4S is
  generic (
    G_DAT_WIDTH               : integer;
    G_FIFO_WRITE_DEPTH        : integer range 16 to 4194304;
    G_FIFO_MEMORY_TYPE        : string := "auto" --"auto", "block", "distributed", "ultra"
  );
  port (
    i_axis_s0_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s0_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s0_tlast           : in  std_logic := '0';
    i_axis_s0_tvalid          : in  std_logic := '0';
    o_axis_s0_tready          : out std_logic;

    i_axis_s1_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s1_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s1_tlast           : in  std_logic := '0';
    i_axis_s1_tvalid          : in  std_logic := '0';
    o_axis_s1_tready          : out std_logic;

    i_axis_s2_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s2_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s2_tlast           : in  std_logic := '0';
    i_axis_s2_tvalid          : in  std_logic := '0';
    o_axis_s2_tready          : out std_logic;

    i_axis_s3_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s3_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s3_tlast           : in  std_logic := '0';
    i_axis_s3_tvalid          : in  std_logic := '0';
    o_axis_s3_tready          : out std_logic;

    i_axis_s4_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s4_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s4_tlast           : in  std_logic := '0';
    i_axis_s4_tvalid          : in  std_logic := '0';
    o_axis_s4_tready          : out std_logic;

    i_axis_s5_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s5_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s5_tlast           : in  std_logic := '0';
    i_axis_s5_tvalid          : in  std_logic := '0';
    o_axis_s5_tready          : out std_logic;

    i_axis_s6_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s6_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s6_tlast           : in  std_logic := '0';
    i_axis_s6_tvalid          : in  std_logic := '0';
    o_axis_s6_tready          : out std_logic;

    i_axis_s7_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s7_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s7_tlast           : in  std_logic := '0';
    i_axis_s7_tvalid          : in  std_logic := '0';
    o_axis_s7_tready          : out std_logic;

    i_axis_s8_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s8_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s8_tlast           : in  std_logic := '0';
    i_axis_s8_tvalid          : in  std_logic := '0';
    o_axis_s8_tready          : out std_logic;

    i_axis_s9_tdata           : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s9_tstrb           : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s9_tlast           : in  std_logic := '0';
    i_axis_s9_tvalid          : in  std_logic := '0';
    o_axis_s9_tready          : out std_logic;

    i_axis_s10_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s10_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s10_tlast          : in  std_logic := '0';
    i_axis_s10_tvalid         : in  std_logic := '0';
    o_axis_s10_tready         : out std_logic;

    i_axis_s11_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s11_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s11_tlast          : in  std_logic := '0';
    i_axis_s11_tvalid         : in  std_logic := '0';
    o_axis_s11_tready         : out std_logic;

    i_axis_s12_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s12_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s12_tlast          : in  std_logic := '0';
    i_axis_s12_tvalid         : in  std_logic := '0';
    o_axis_s12_tready         : out std_logic;

    i_axis_s13_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s13_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s13_tlast          : in  std_logic := '0';
    i_axis_s13_tvalid         : in  std_logic := '0';
    o_axis_s13_tready         : out std_logic;

    i_axis_s14_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s14_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s14_tlast          : in  std_logic := '0';
    i_axis_s14_tvalid         : in  std_logic := '0';
    o_axis_s14_tready         : out std_logic;

    i_axis_s15_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s15_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s15_tlast          : in  std_logic := '0';
    i_axis_s15_tvalid         : in  std_logic := '0';
    o_axis_s15_tready         : out std_logic;

    i_axis_s16_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s16_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s16_tlast          : in  std_logic := '0';
    i_axis_s16_tvalid         : in  std_logic := '0';
    o_axis_s16_tready         : out std_logic;

    i_axis_s17_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s17_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s17_tlast          : in  std_logic := '0';
    i_axis_s17_tvalid         : in  std_logic := '0';
    o_axis_s17_tready         : out std_logic;

    i_axis_s18_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s18_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s18_tlast          : in  std_logic := '0';
    i_axis_s18_tvalid         : in  std_logic := '0';
    o_axis_s18_tready         : out std_logic;

    i_axis_s19_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s19_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s19_tlast          : in  std_logic := '0';
    i_axis_s19_tvalid         : in  std_logic := '0';
    o_axis_s19_tready         : out std_logic;

    i_axis_s20_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s20_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s20_tlast          : in  std_logic := '0';
    i_axis_s20_tvalid         : in  std_logic := '0';
    o_axis_s20_tready         : out std_logic;

    i_axis_s21_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s21_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s21_tlast          : in  std_logic := '0';
    i_axis_s21_tvalid         : in  std_logic := '0';
    o_axis_s21_tready         : out std_logic;

    i_axis_s22_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s22_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s22_tlast          : in  std_logic := '0';
    i_axis_s22_tvalid         : in  std_logic := '0';
    o_axis_s22_tready         : out std_logic;

    i_axis_s23_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s23_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s23_tlast          : in  std_logic := '0';
    i_axis_s23_tvalid         : in  std_logic := '0';
    o_axis_s23_tready         : out std_logic;

    i_axis_s24_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s24_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s24_tlast          : in  std_logic := '0';
    i_axis_s24_tvalid         : in  std_logic := '0';
    o_axis_s24_tready         : out std_logic;

    i_axis_s25_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s25_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s25_tlast          : in  std_logic := '0';
    i_axis_s25_tvalid         : in  std_logic := '0';
    o_axis_s25_tready         : out std_logic;

    i_axis_s26_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s26_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s26_tlast          : in  std_logic := '0';
    i_axis_s26_tvalid         : in  std_logic := '0';
    o_axis_s26_tready         : out std_logic;

    i_axis_s27_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s27_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s27_tlast          : in  std_logic := '0';
    i_axis_s27_tvalid         : in  std_logic := '0';
    o_axis_s27_tready         : out std_logic;

    i_axis_s28_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s28_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s28_tlast          : in  std_logic := '0';
    i_axis_s28_tvalid         : in  std_logic := '0';
    o_axis_s28_tready         : out std_logic;

    i_axis_s29_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s29_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s29_tlast          : in  std_logic := '0';
    i_axis_s29_tvalid         : in  std_logic := '0';
    o_axis_s29_tready         : out std_logic;

    i_axis_s30_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s30_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s30_tlast          : in  std_logic := '0';
    i_axis_s30_tvalid         : in  std_logic := '0';
    o_axis_s30_tready         : out std_logic;

    i_axis_s31_tdata          : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0) := (others => '0');
    i_axis_s31_tstrb          : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0) := (others => '0');
    i_axis_s31_tlast          : in  std_logic := '0';
    i_axis_s31_tvalid         : in  std_logic := '0';
    o_axis_s31_tready         : out std_logic;

    o_axis_m0_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m0_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m0_tlast           : out std_logic;
    o_axis_m0_tvalid          : out std_logic;
    i_axis_m0_tready          : in  std_logic := '1';

    o_axis_m1_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m1_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m1_tlast           : out std_logic;
    o_axis_m1_tvalid          : out std_logic;
    i_axis_m1_tready          : in  std_logic := '1';

    o_axis_m2_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m2_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m2_tlast           : out std_logic;
    o_axis_m2_tvalid          : out std_logic;
    i_axis_m2_tready          : in  std_logic := '1';

    o_axis_m3_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m3_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m3_tlast           : out std_logic;
    o_axis_m3_tvalid          : out std_logic;
    i_axis_m3_tready          : in  std_logic := '1';

    o_axis_m4_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m4_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m4_tlast           : out std_logic;
    o_axis_m4_tvalid          : out std_logic;
    i_axis_m4_tready          : in  std_logic := '1';

    o_axis_m5_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m5_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m5_tlast           : out std_logic;
    o_axis_m5_tvalid          : out std_logic;
    i_axis_m5_tready          : in  std_logic := '1';

    o_axis_m6_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m6_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m6_tlast           : out std_logic;
    o_axis_m6_tvalid          : out std_logic;
    i_axis_m6_tready          : in  std_logic := '1';

    o_axis_m7_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m7_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m7_tlast           : out std_logic;
    o_axis_m7_tvalid          : out std_logic;
    i_axis_m7_tready          : in  std_logic := '1';

    o_axis_m8_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m8_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m8_tlast           : out std_logic;
    o_axis_m8_tvalid          : out std_logic;
    i_axis_m8_tready          : in  std_logic := '1';

    o_axis_m9_tdata           : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m9_tstrb           : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m9_tlast           : out std_logic;
    o_axis_m9_tvalid          : out std_logic;
    i_axis_m9_tready          : in  std_logic := '1';

    o_axis_m10_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m10_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m10_tlast          : out std_logic;
    o_axis_m10_tvalid         : out std_logic;
    i_axis_m10_tready         : in  std_logic := '1';

    o_axis_m11_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m11_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m11_tlast          : out std_logic;
    o_axis_m11_tvalid         : out std_logic;
    i_axis_m11_tready         : in  std_logic := '1';

    o_axis_m12_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m12_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m12_tlast          : out std_logic;
    o_axis_m12_tvalid         : out std_logic;
    i_axis_m12_tready         : in  std_logic := '1';

    o_axis_m13_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m13_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m13_tlast          : out std_logic;
    o_axis_m13_tvalid         : out std_logic;
    i_axis_m13_tready         : in  std_logic := '1';

    o_axis_m14_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m14_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m14_tlast          : out std_logic;
    o_axis_m14_tvalid         : out std_logic;
    i_axis_m14_tready         : in  std_logic := '1';

    o_axis_m15_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m15_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m15_tlast          : out std_logic;
    o_axis_m15_tvalid         : out std_logic;
    i_axis_m15_tready         : in  std_logic := '1';

    o_axis_m16_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m16_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m16_tlast          : out std_logic;
    o_axis_m16_tvalid         : out std_logic;
    i_axis_m16_tready         : in  std_logic := '1';

    o_axis_m17_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m17_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m17_tlast          : out std_logic;
    o_axis_m17_tvalid         : out std_logic;
    i_axis_m17_tready         : in  std_logic := '1';

    o_axis_m18_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m18_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m18_tlast          : out std_logic;
    o_axis_m18_tvalid         : out std_logic;
    i_axis_m18_tready         : in  std_logic := '1';

    o_axis_m19_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m19_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m19_tlast          : out std_logic;
    o_axis_m19_tvalid         : out std_logic;
    i_axis_m19_tready         : in  std_logic := '1';

    o_axis_m20_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m20_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m20_tlast          : out std_logic;
    o_axis_m20_tvalid         : out std_logic;
    i_axis_m20_tready         : in  std_logic := '1';

    o_axis_m21_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m21_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m21_tlast          : out std_logic;
    o_axis_m21_tvalid         : out std_logic;
    i_axis_m21_tready         : in  std_logic := '1';

    o_axis_m22_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m22_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m22_tlast          : out std_logic;
    o_axis_m22_tvalid         : out std_logic;
    i_axis_m22_tready         : in  std_logic := '1';

    o_axis_m23_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m23_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m23_tlast          : out std_logic;
    o_axis_m23_tvalid         : out std_logic;
    i_axis_m23_tready         : in  std_logic := '1';

    o_axis_m24_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m24_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m24_tlast          : out std_logic;
    o_axis_m24_tvalid         : out std_logic;
    i_axis_m24_tready         : in  std_logic := '1';

    o_axis_m25_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m25_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m25_tlast          : out std_logic;
    o_axis_m25_tvalid         : out std_logic;
    i_axis_m25_tready         : in  std_logic := '1';

    o_axis_m26_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m26_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m26_tlast          : out std_logic;
    o_axis_m26_tvalid         : out std_logic;
    i_axis_m26_tready         : in  std_logic := '1';

    o_axis_m27_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m27_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m27_tlast          : out std_logic;
    o_axis_m27_tvalid         : out std_logic;
    i_axis_m27_tready         : in  std_logic := '1';

    o_axis_m28_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m28_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m28_tlast          : out std_logic;
    o_axis_m28_tvalid         : out std_logic;
    i_axis_m28_tready         : in  std_logic := '1';

    o_axis_m29_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m29_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m29_tlast          : out std_logic;
    o_axis_m29_tvalid         : out std_logic;
    i_axis_m29_tready         : in  std_logic := '1';

    o_axis_m30_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m30_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m30_tlast          : out std_logic;
    o_axis_m30_tvalid         : out std_logic;
    i_axis_m30_tready         : in  std_logic := '1';

    o_axis_m31_tdata          : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_m31_tstrb          : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_m31_tlast          : out std_logic;
    o_axis_m31_tvalid         : out std_logic;
    i_axis_m31_tready         : in  std_logic := '1';

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_HUB_AXI4S;
architecture RTL of IM_HUB_AXI4S is
  component IM_HUB_AXI4S_MPX
  generic (
    G_DAT_WIDTH               : integer
  );
  port (
    i_axis_0_tdata            : in  std_logic_vector;
    i_axis_0_tstrb            : in  std_logic_vector;
    i_axis_0_tlast            : in  std_logic;
    i_axis_0_tvalid           : in  std_logic;
    o_axis_0_tready           : out std_logic;

    i_axis_1_tdata            : in  std_logic_vector;
    i_axis_1_tstrb            : in  std_logic_vector;
    i_axis_1_tlast            : in  std_logic;
    i_axis_1_tvalid           : in  std_logic;
    o_axis_1_tready           : out std_logic;

    i_axis_2_tdata            : in  std_logic_vector;
    i_axis_2_tstrb            : in  std_logic_vector;
    i_axis_2_tlast            : in  std_logic;
    i_axis_2_tvalid           : in  std_logic;
    o_axis_2_tready           : out std_logic;

    i_axis_3_tdata            : in  std_logic_vector;
    i_axis_3_tstrb            : in  std_logic_vector;
    i_axis_3_tlast            : in  std_logic;
    i_axis_3_tvalid           : in  std_logic;
    o_axis_3_tready           : out std_logic;

    i_axis_4_tdata            : in  std_logic_vector;
    i_axis_4_tstrb            : in  std_logic_vector;
    i_axis_4_tlast            : in  std_logic;
    i_axis_4_tvalid           : in  std_logic;
    o_axis_4_tready           : out std_logic;

    i_axis_5_tdata            : in  std_logic_vector;
    i_axis_5_tstrb            : in  std_logic_vector;
    i_axis_5_tlast            : in  std_logic;
    i_axis_5_tvalid           : in  std_logic;
    o_axis_5_tready           : out std_logic;

    i_axis_6_tdata            : in  std_logic_vector;
    i_axis_6_tstrb            : in  std_logic_vector;
    i_axis_6_tlast            : in  std_logic;
    i_axis_6_tvalid           : in  std_logic;
    o_axis_6_tready           : out std_logic;

    i_axis_7_tdata            : in  std_logic_vector;
    i_axis_7_tstrb            : in  std_logic_vector;
    i_axis_7_tlast            : in  std_logic;
    i_axis_7_tvalid           : in  std_logic;
    o_axis_7_tready           : out std_logic;

    i_axis_8_tdata            : in  std_logic_vector;
    i_axis_8_tstrb            : in  std_logic_vector;
    i_axis_8_tlast            : in  std_logic;
    i_axis_8_tvalid           : in  std_logic;
    o_axis_8_tready           : out std_logic;

    i_axis_9_tdata            : in  std_logic_vector;
    i_axis_9_tstrb            : in  std_logic_vector;
    i_axis_9_tlast            : in  std_logic;
    i_axis_9_tvalid           : in  std_logic;
    o_axis_9_tready           : out std_logic;

    i_axis_10_tdata           : in  std_logic_vector;
    i_axis_10_tstrb           : in  std_logic_vector;
    i_axis_10_tlast           : in  std_logic;
    i_axis_10_tvalid          : in  std_logic;
    o_axis_10_tready          : out std_logic;

    i_axis_11_tdata           : in  std_logic_vector;
    i_axis_11_tstrb           : in  std_logic_vector;
    i_axis_11_tlast           : in  std_logic;
    i_axis_11_tvalid          : in  std_logic;
    o_axis_11_tready          : out std_logic;

    i_axis_12_tdata           : in  std_logic_vector;
    i_axis_12_tstrb           : in  std_logic_vector;
    i_axis_12_tlast           : in  std_logic;
    i_axis_12_tvalid          : in  std_logic;
    o_axis_12_tready          : out std_logic;

    i_axis_13_tdata           : in  std_logic_vector;
    i_axis_13_tstrb           : in  std_logic_vector;
    i_axis_13_tlast           : in  std_logic;
    i_axis_13_tvalid          : in  std_logic;
    o_axis_13_tready          : out std_logic;

    i_axis_14_tdata           : in  std_logic_vector;
    i_axis_14_tstrb           : in  std_logic_vector;
    i_axis_14_tlast           : in  std_logic;
    i_axis_14_tvalid          : in  std_logic;
    o_axis_14_tready          : out std_logic;

    i_axis_15_tdata           : in  std_logic_vector;
    i_axis_15_tstrb           : in  std_logic_vector;
    i_axis_15_tlast           : in  std_logic;
    i_axis_15_tvalid          : in  std_logic;
    o_axis_15_tready          : out std_logic;

    i_axis_16_tdata           : in  std_logic_vector;
    i_axis_16_tstrb           : in  std_logic_vector;
    i_axis_16_tlast           : in  std_logic;
    i_axis_16_tvalid          : in  std_logic;
    o_axis_16_tready          : out std_logic;

    i_axis_17_tdata           : in  std_logic_vector;
    i_axis_17_tstrb           : in  std_logic_vector;
    i_axis_17_tlast           : in  std_logic;
    i_axis_17_tvalid          : in  std_logic;
    o_axis_17_tready          : out std_logic;

    i_axis_18_tdata           : in  std_logic_vector;
    i_axis_18_tstrb           : in  std_logic_vector;
    i_axis_18_tlast           : in  std_logic;
    i_axis_18_tvalid          : in  std_logic;
    o_axis_18_tready          : out std_logic;

    i_axis_19_tdata           : in  std_logic_vector;
    i_axis_19_tstrb           : in  std_logic_vector;
    i_axis_19_tlast           : in  std_logic;
    i_axis_19_tvalid          : in  std_logic;
    o_axis_19_tready          : out std_logic;

    i_axis_20_tdata           : in  std_logic_vector;
    i_axis_20_tstrb           : in  std_logic_vector;
    i_axis_20_tlast           : in  std_logic;
    i_axis_20_tvalid          : in  std_logic;
    o_axis_20_tready          : out std_logic;

    i_axis_21_tdata           : in  std_logic_vector;
    i_axis_21_tstrb           : in  std_logic_vector;
    i_axis_21_tlast           : in  std_logic;
    i_axis_21_tvalid          : in  std_logic;
    o_axis_21_tready          : out std_logic;

    i_axis_22_tdata           : in  std_logic_vector;
    i_axis_22_tstrb           : in  std_logic_vector;
    i_axis_22_tlast           : in  std_logic;
    i_axis_22_tvalid          : in  std_logic;
    o_axis_22_tready          : out std_logic;

    i_axis_23_tdata           : in  std_logic_vector;
    i_axis_23_tstrb           : in  std_logic_vector;
    i_axis_23_tlast           : in  std_logic;
    i_axis_23_tvalid          : in  std_logic;
    o_axis_23_tready          : out std_logic;

    i_axis_24_tdata           : in  std_logic_vector;
    i_axis_24_tstrb           : in  std_logic_vector;
    i_axis_24_tlast           : in  std_logic;
    i_axis_24_tvalid          : in  std_logic;
    o_axis_24_tready          : out std_logic;

    i_axis_25_tdata           : in  std_logic_vector;
    i_axis_25_tstrb           : in  std_logic_vector;
    i_axis_25_tlast           : in  std_logic;
    i_axis_25_tvalid          : in  std_logic;
    o_axis_25_tready          : out std_logic;

    i_axis_26_tdata           : in  std_logic_vector;
    i_axis_26_tstrb           : in  std_logic_vector;
    i_axis_26_tlast           : in  std_logic;
    i_axis_26_tvalid          : in  std_logic;
    o_axis_26_tready          : out std_logic;

    i_axis_27_tdata           : in  std_logic_vector;
    i_axis_27_tstrb           : in  std_logic_vector;
    i_axis_27_tlast           : in  std_logic;
    i_axis_27_tvalid          : in  std_logic;
    o_axis_27_tready          : out std_logic;

    i_axis_28_tdata           : in  std_logic_vector;
    i_axis_28_tstrb           : in  std_logic_vector;
    i_axis_28_tlast           : in  std_logic;
    i_axis_28_tvalid          : in  std_logic;
    o_axis_28_tready          : out std_logic;

    i_axis_29_tdata           : in  std_logic_vector;
    i_axis_29_tstrb           : in  std_logic_vector;
    i_axis_29_tlast           : in  std_logic;
    i_axis_29_tvalid          : in  std_logic;
    o_axis_29_tready          : out std_logic;

    i_axis_30_tdata           : in  std_logic_vector;
    i_axis_30_tstrb           : in  std_logic_vector;
    i_axis_30_tlast           : in  std_logic;
    i_axis_30_tvalid          : in  std_logic;
    o_axis_30_tready          : out std_logic;

    i_axis_31_tdata           : in  std_logic_vector;
    i_axis_31_tstrb           : in  std_logic_vector;
    i_axis_31_tlast           : in  std_logic;
    i_axis_31_tvalid          : in  std_logic;
    o_axis_31_tready          : out std_logic;

    o_axis_tdata              : out std_logic_vector;
    o_axis_tstrb              : out std_logic_vector;
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_HUB_AXI4S_DST
  generic (
    G_DAT_WIDTH               : integer
  );
  port (
    i_axis_tdata              : in  std_logic_vector;
    i_axis_tstrb              : in  std_logic_vector;
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    o_axis_0_tdata            : out std_logic_vector;
    o_axis_0_tstrb            : out std_logic_vector;
    o_axis_0_tlast            : out std_logic;
    o_axis_0_tvalid           : out std_logic;
    i_axis_0_tready           : in  std_logic;

    o_axis_1_tdata            : out std_logic_vector;
    o_axis_1_tstrb            : out std_logic_vector;
    o_axis_1_tlast            : out std_logic;
    o_axis_1_tvalid           : out std_logic;
    i_axis_1_tready           : in  std_logic;

    o_axis_2_tdata            : out std_logic_vector;
    o_axis_2_tstrb            : out std_logic_vector;
    o_axis_2_tlast            : out std_logic;
    o_axis_2_tvalid           : out std_logic;
    i_axis_2_tready           : in  std_logic;

    o_axis_3_tdata            : out std_logic_vector;
    o_axis_3_tstrb            : out std_logic_vector;
    o_axis_3_tlast            : out std_logic;
    o_axis_3_tvalid           : out std_logic;
    i_axis_3_tready           : in  std_logic;

    o_axis_4_tdata            : out std_logic_vector;
    o_axis_4_tstrb            : out std_logic_vector;
    o_axis_4_tlast            : out std_logic;
    o_axis_4_tvalid           : out std_logic;
    i_axis_4_tready           : in  std_logic;

    o_axis_5_tdata            : out std_logic_vector;
    o_axis_5_tstrb            : out std_logic_vector;
    o_axis_5_tlast            : out std_logic;
    o_axis_5_tvalid           : out std_logic;
    i_axis_5_tready           : in  std_logic;

    o_axis_6_tdata            : out std_logic_vector;
    o_axis_6_tstrb            : out std_logic_vector;
    o_axis_6_tlast            : out std_logic;
    o_axis_6_tvalid           : out std_logic;
    i_axis_6_tready           : in  std_logic;

    o_axis_7_tdata            : out std_logic_vector;
    o_axis_7_tstrb            : out std_logic_vector;
    o_axis_7_tlast            : out std_logic;
    o_axis_7_tvalid           : out std_logic;
    i_axis_7_tready           : in  std_logic;

    o_axis_8_tdata            : out std_logic_vector;
    o_axis_8_tstrb            : out std_logic_vector;
    o_axis_8_tlast            : out std_logic;
    o_axis_8_tvalid           : out std_logic;
    i_axis_8_tready           : in  std_logic;

    o_axis_9_tdata            : out std_logic_vector;
    o_axis_9_tstrb            : out std_logic_vector;
    o_axis_9_tlast            : out std_logic;
    o_axis_9_tvalid           : out std_logic;
    i_axis_9_tready           : in  std_logic;

    o_axis_10_tdata           : out std_logic_vector;
    o_axis_10_tstrb           : out std_logic_vector;
    o_axis_10_tlast           : out std_logic;
    o_axis_10_tvalid          : out std_logic;
    i_axis_10_tready          : in  std_logic;

    o_axis_11_tdata           : out std_logic_vector;
    o_axis_11_tstrb           : out std_logic_vector;
    o_axis_11_tlast           : out std_logic;
    o_axis_11_tvalid          : out std_logic;
    i_axis_11_tready          : in  std_logic;

    o_axis_12_tdata           : out std_logic_vector;
    o_axis_12_tstrb           : out std_logic_vector;
    o_axis_12_tlast           : out std_logic;
    o_axis_12_tvalid          : out std_logic;
    i_axis_12_tready          : in  std_logic;

    o_axis_13_tdata           : out std_logic_vector;
    o_axis_13_tstrb           : out std_logic_vector;
    o_axis_13_tlast           : out std_logic;
    o_axis_13_tvalid          : out std_logic;
    i_axis_13_tready          : in  std_logic;

    o_axis_14_tdata           : out std_logic_vector;
    o_axis_14_tstrb           : out std_logic_vector;
    o_axis_14_tlast           : out std_logic;
    o_axis_14_tvalid          : out std_logic;
    i_axis_14_tready          : in  std_logic;

    o_axis_15_tdata           : out std_logic_vector;
    o_axis_15_tstrb           : out std_logic_vector;
    o_axis_15_tlast           : out std_logic;
    o_axis_15_tvalid          : out std_logic;
    i_axis_15_tready          : in  std_logic;

    o_axis_16_tdata           : out std_logic_vector;
    o_axis_16_tstrb           : out std_logic_vector;
    o_axis_16_tlast           : out std_logic;
    o_axis_16_tvalid          : out std_logic;
    i_axis_16_tready          : in  std_logic;

    o_axis_17_tdata           : out std_logic_vector;
    o_axis_17_tstrb           : out std_logic_vector;
    o_axis_17_tlast           : out std_logic;
    o_axis_17_tvalid          : out std_logic;
    i_axis_17_tready          : in  std_logic;

    o_axis_18_tdata           : out std_logic_vector;
    o_axis_18_tstrb           : out std_logic_vector;
    o_axis_18_tlast           : out std_logic;
    o_axis_18_tvalid          : out std_logic;
    i_axis_18_tready          : in  std_logic;

    o_axis_19_tdata           : out std_logic_vector;
    o_axis_19_tstrb           : out std_logic_vector;
    o_axis_19_tlast           : out std_logic;
    o_axis_19_tvalid          : out std_logic;
    i_axis_19_tready          : in  std_logic;

    o_axis_20_tdata           : out std_logic_vector;
    o_axis_20_tstrb           : out std_logic_vector;
    o_axis_20_tlast           : out std_logic;
    o_axis_20_tvalid          : out std_logic;
    i_axis_20_tready          : in  std_logic;

    o_axis_21_tdata           : out std_logic_vector;
    o_axis_21_tstrb           : out std_logic_vector;
    o_axis_21_tlast           : out std_logic;
    o_axis_21_tvalid          : out std_logic;
    i_axis_21_tready          : in  std_logic;

    o_axis_22_tdata           : out std_logic_vector;
    o_axis_22_tstrb           : out std_logic_vector;
    o_axis_22_tlast           : out std_logic;
    o_axis_22_tvalid          : out std_logic;
    i_axis_22_tready          : in  std_logic;

    o_axis_23_tdata           : out std_logic_vector;
    o_axis_23_tstrb           : out std_logic_vector;
    o_axis_23_tlast           : out std_logic;
    o_axis_23_tvalid          : out std_logic;
    i_axis_23_tready          : in  std_logic;

    o_axis_24_tdata           : out std_logic_vector;
    o_axis_24_tstrb           : out std_logic_vector;
    o_axis_24_tlast           : out std_logic;
    o_axis_24_tvalid          : out std_logic;
    i_axis_24_tready          : in  std_logic;

    o_axis_25_tdata           : out std_logic_vector;
    o_axis_25_tstrb           : out std_logic_vector;
    o_axis_25_tlast           : out std_logic;
    o_axis_25_tvalid          : out std_logic;
    i_axis_25_tready          : in  std_logic;

    o_axis_26_tdata           : out std_logic_vector;
    o_axis_26_tstrb           : out std_logic_vector;
    o_axis_26_tlast           : out std_logic;
    o_axis_26_tvalid          : out std_logic;
    i_axis_26_tready          : in  std_logic;

    o_axis_27_tdata           : out std_logic_vector;
    o_axis_27_tstrb           : out std_logic_vector;
    o_axis_27_tlast           : out std_logic;
    o_axis_27_tvalid          : out std_logic;
    i_axis_27_tready          : in  std_logic;

    o_axis_28_tdata           : out std_logic_vector;
    o_axis_28_tstrb           : out std_logic_vector;
    o_axis_28_tlast           : out std_logic;
    o_axis_28_tvalid          : out std_logic;
    i_axis_28_tready          : in  std_logic;

    o_axis_29_tdata           : out std_logic_vector;
    o_axis_29_tstrb           : out std_logic_vector;
    o_axis_29_tlast           : out std_logic;
    o_axis_29_tvalid          : out std_logic;
    i_axis_29_tready          : in  std_logic;

    o_axis_30_tdata           : out std_logic_vector;
    o_axis_30_tstrb           : out std_logic_vector;
    o_axis_30_tlast           : out std_logic;
    o_axis_30_tvalid          : out std_logic;
    i_axis_30_tready          : in  std_logic;

    o_axis_31_tdata           : out std_logic_vector;
    o_axis_31_tstrb           : out std_logic_vector;
    o_axis_31_tlast           : out std_logic;
    o_axis_31_tvalid          : out std_logic;
    i_axis_31_tready          : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_FIFO_AXI4S
  generic (
    G_DAT_WIDTH               : integer;
    G_FIFO_WRITE_DEPTH        : integer;
    G_FIFO_MEMORY_TYPE        : string
  );
  port (
    i_axis_tdata              : in  std_logic_vector;
    i_axis_tstrb              : in  std_logic_vector;
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    o_axis_tdata              : out std_logic_vector;
    o_axis_tstrb              : out std_logic_vector;
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  signal mpx_tdata            : std_logic_vector(i_axis_s0_tdata'range) := (others => '0');
  signal mpx_tstrb            : std_logic_vector(i_axis_s0_tstrb'range) := (others => '0');
  signal mpx_tlast            : std_logic := '0';
  signal mpx_tvalid           : std_logic := '0';
  signal mpx_tready           : std_logic := '0';

  signal fifo_tdata           : std_logic_vector(i_axis_s0_tdata'range) := (others => '0');
  signal fifo_tstrb           : std_logic_vector(i_axis_s0_tstrb'range) := (others => '0');
  signal fifo_tlast           : std_logic := '0';
  signal fifo_tvalid          : std_logic := '0';
  signal fifo_tready          : std_logic := '0';
begin
  u_mpx : IM_HUB_AXI4S_MPX
  generic map(
    G_DAT_WIDTH               => G_DAT_WIDTH
  )
  port map(
    i_axis_0_tdata            => i_axis_s0_tdata,
    i_axis_0_tstrb            => i_axis_s0_tstrb,
    i_axis_0_tlast            => i_axis_s0_tlast,
    i_axis_0_tvalid           => i_axis_s0_tvalid,
    o_axis_0_tready           => o_axis_s0_tready,

    i_axis_1_tdata            => i_axis_s1_tdata,
    i_axis_1_tstrb            => i_axis_s1_tstrb,
    i_axis_1_tlast            => i_axis_s1_tlast,
    i_axis_1_tvalid           => i_axis_s1_tvalid,
    o_axis_1_tready           => o_axis_s1_tready,

    i_axis_2_tdata            => i_axis_s2_tdata,
    i_axis_2_tstrb            => i_axis_s2_tstrb,
    i_axis_2_tlast            => i_axis_s2_tlast,
    i_axis_2_tvalid           => i_axis_s2_tvalid,
    o_axis_2_tready           => o_axis_s2_tready,

    i_axis_3_tdata            => i_axis_s3_tdata,
    i_axis_3_tstrb            => i_axis_s3_tstrb,
    i_axis_3_tlast            => i_axis_s3_tlast,
    i_axis_3_tvalid           => i_axis_s3_tvalid,
    o_axis_3_tready           => o_axis_s3_tready,

    i_axis_4_tdata            => i_axis_s4_tdata,
    i_axis_4_tstrb            => i_axis_s4_tstrb,
    i_axis_4_tlast            => i_axis_s4_tlast,
    i_axis_4_tvalid           => i_axis_s4_tvalid,
    o_axis_4_tready           => o_axis_s4_tready,

    i_axis_5_tdata            => i_axis_s5_tdata,
    i_axis_5_tstrb            => i_axis_s5_tstrb,
    i_axis_5_tlast            => i_axis_s5_tlast,
    i_axis_5_tvalid           => i_axis_s5_tvalid,
    o_axis_5_tready           => o_axis_s5_tready,

    i_axis_6_tdata            => i_axis_s6_tdata,
    i_axis_6_tstrb            => i_axis_s6_tstrb,
    i_axis_6_tlast            => i_axis_s6_tlast,
    i_axis_6_tvalid           => i_axis_s6_tvalid,
    o_axis_6_tready           => o_axis_s6_tready,

    i_axis_7_tdata            => i_axis_s7_tdata,
    i_axis_7_tstrb            => i_axis_s7_tstrb,
    i_axis_7_tlast            => i_axis_s7_tlast,
    i_axis_7_tvalid           => i_axis_s7_tvalid,
    o_axis_7_tready           => o_axis_s7_tready,

    i_axis_8_tdata            => i_axis_s8_tdata,
    i_axis_8_tstrb            => i_axis_s8_tstrb,
    i_axis_8_tlast            => i_axis_s8_tlast,
    i_axis_8_tvalid           => i_axis_s8_tvalid,
    o_axis_8_tready           => o_axis_s8_tready,

    i_axis_9_tdata            => i_axis_s9_tdata,
    i_axis_9_tstrb            => i_axis_s9_tstrb,
    i_axis_9_tlast            => i_axis_s9_tlast,
    i_axis_9_tvalid           => i_axis_s9_tvalid,
    o_axis_9_tready           => o_axis_s9_tready,

    i_axis_10_tdata           => i_axis_s10_tdata,
    i_axis_10_tstrb           => i_axis_s10_tstrb,
    i_axis_10_tlast           => i_axis_s10_tlast,
    i_axis_10_tvalid          => i_axis_s10_tvalid,
    o_axis_10_tready          => o_axis_s10_tready,

    i_axis_11_tdata           => i_axis_s11_tdata,
    i_axis_11_tstrb           => i_axis_s11_tstrb,
    i_axis_11_tlast           => i_axis_s11_tlast,
    i_axis_11_tvalid          => i_axis_s11_tvalid,
    o_axis_11_tready          => o_axis_s11_tready,

    i_axis_12_tdata           => i_axis_s12_tdata,
    i_axis_12_tstrb           => i_axis_s12_tstrb,
    i_axis_12_tlast           => i_axis_s12_tlast,
    i_axis_12_tvalid          => i_axis_s12_tvalid,
    o_axis_12_tready          => o_axis_s12_tready,

    i_axis_13_tdata           => i_axis_s13_tdata,
    i_axis_13_tstrb           => i_axis_s13_tstrb,
    i_axis_13_tlast           => i_axis_s13_tlast,
    i_axis_13_tvalid          => i_axis_s13_tvalid,
    o_axis_13_tready          => o_axis_s13_tready,

    i_axis_14_tdata           => i_axis_s14_tdata,
    i_axis_14_tstrb           => i_axis_s14_tstrb,
    i_axis_14_tlast           => i_axis_s14_tlast,
    i_axis_14_tvalid          => i_axis_s14_tvalid,
    o_axis_14_tready          => o_axis_s14_tready,

    i_axis_15_tdata           => i_axis_s15_tdata,
    i_axis_15_tstrb           => i_axis_s15_tstrb,
    i_axis_15_tlast           => i_axis_s15_tlast,
    i_axis_15_tvalid          => i_axis_s15_tvalid,
    o_axis_15_tready          => o_axis_s15_tready,

    i_axis_16_tdata           => i_axis_s16_tdata,
    i_axis_16_tstrb           => i_axis_s16_tstrb,
    i_axis_16_tlast           => i_axis_s16_tlast,
    i_axis_16_tvalid          => i_axis_s16_tvalid,
    o_axis_16_tready          => o_axis_s16_tready,

    i_axis_17_tdata           => i_axis_s17_tdata,
    i_axis_17_tstrb           => i_axis_s17_tstrb,
    i_axis_17_tlast           => i_axis_s17_tlast,
    i_axis_17_tvalid          => i_axis_s17_tvalid,
    o_axis_17_tready          => o_axis_s17_tready,

    i_axis_18_tdata           => i_axis_s18_tdata,
    i_axis_18_tstrb           => i_axis_s18_tstrb,
    i_axis_18_tlast           => i_axis_s18_tlast,
    i_axis_18_tvalid          => i_axis_s18_tvalid,
    o_axis_18_tready          => o_axis_s18_tready,

    i_axis_19_tdata           => i_axis_s19_tdata,
    i_axis_19_tstrb           => i_axis_s19_tstrb,
    i_axis_19_tlast           => i_axis_s19_tlast,
    i_axis_19_tvalid          => i_axis_s19_tvalid,
    o_axis_19_tready          => o_axis_s19_tready,

    i_axis_20_tdata           => i_axis_s20_tdata,
    i_axis_20_tstrb           => i_axis_s20_tstrb,
    i_axis_20_tlast           => i_axis_s20_tlast,
    i_axis_20_tvalid          => i_axis_s20_tvalid,
    o_axis_20_tready          => o_axis_s20_tready,

    i_axis_21_tdata           => i_axis_s21_tdata,
    i_axis_21_tstrb           => i_axis_s21_tstrb,
    i_axis_21_tlast           => i_axis_s21_tlast,
    i_axis_21_tvalid          => i_axis_s21_tvalid,
    o_axis_21_tready          => o_axis_s21_tready,

    i_axis_22_tdata           => i_axis_s22_tdata,
    i_axis_22_tstrb           => i_axis_s22_tstrb,
    i_axis_22_tlast           => i_axis_s22_tlast,
    i_axis_22_tvalid          => i_axis_s22_tvalid,
    o_axis_22_tready          => o_axis_s22_tready,

    i_axis_23_tdata           => i_axis_s23_tdata,
    i_axis_23_tstrb           => i_axis_s23_tstrb,
    i_axis_23_tlast           => i_axis_s23_tlast,
    i_axis_23_tvalid          => i_axis_s23_tvalid,
    o_axis_23_tready          => o_axis_s23_tready,

    i_axis_24_tdata           => i_axis_s24_tdata,
    i_axis_24_tstrb           => i_axis_s24_tstrb,
    i_axis_24_tlast           => i_axis_s24_tlast,
    i_axis_24_tvalid          => i_axis_s24_tvalid,
    o_axis_24_tready          => o_axis_s24_tready,

    i_axis_25_tdata           => i_axis_s25_tdata,
    i_axis_25_tstrb           => i_axis_s25_tstrb,
    i_axis_25_tlast           => i_axis_s25_tlast,
    i_axis_25_tvalid          => i_axis_s25_tvalid,
    o_axis_25_tready          => o_axis_s25_tready,

    i_axis_26_tdata           => i_axis_s26_tdata,
    i_axis_26_tstrb           => i_axis_s26_tstrb,
    i_axis_26_tlast           => i_axis_s26_tlast,
    i_axis_26_tvalid          => i_axis_s26_tvalid,
    o_axis_26_tready          => o_axis_s26_tready,

    i_axis_27_tdata           => i_axis_s27_tdata,
    i_axis_27_tstrb           => i_axis_s27_tstrb,
    i_axis_27_tlast           => i_axis_s27_tlast,
    i_axis_27_tvalid          => i_axis_s27_tvalid,
    o_axis_27_tready          => o_axis_s27_tready,

    i_axis_28_tdata           => i_axis_s28_tdata,
    i_axis_28_tstrb           => i_axis_s28_tstrb,
    i_axis_28_tlast           => i_axis_s28_tlast,
    i_axis_28_tvalid          => i_axis_s28_tvalid,
    o_axis_28_tready          => o_axis_s28_tready,

    i_axis_29_tdata           => i_axis_s29_tdata,
    i_axis_29_tstrb           => i_axis_s29_tstrb,
    i_axis_29_tlast           => i_axis_s29_tlast,
    i_axis_29_tvalid          => i_axis_s29_tvalid,
    o_axis_29_tready          => o_axis_s29_tready,

    i_axis_30_tdata           => i_axis_s30_tdata,
    i_axis_30_tstrb           => i_axis_s30_tstrb,
    i_axis_30_tlast           => i_axis_s30_tlast,
    i_axis_30_tvalid          => i_axis_s30_tvalid,
    o_axis_30_tready          => o_axis_s30_tready,

    i_axis_31_tdata           => i_axis_s31_tdata,
    i_axis_31_tstrb           => i_axis_s31_tstrb,
    i_axis_31_tlast           => i_axis_s31_tlast,
    i_axis_31_tvalid          => i_axis_s31_tvalid,
    o_axis_31_tready          => o_axis_s31_tready,

    o_axis_tdata              => mpx_tdata,
    o_axis_tstrb              => mpx_tstrb,
    o_axis_tlast              => mpx_tlast,
    o_axis_tvalid             => mpx_tvalid,
    i_axis_tready             => mpx_tready,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_fifo : IM_FIFO_AXI4S
  generic map(
    G_DAT_WIDTH               => G_DAT_WIDTH,
    G_FIFO_WRITE_DEPTH        => G_FIFO_WRITE_DEPTH,
    G_FIFO_MEMORY_TYPE        => G_FIFO_MEMORY_TYPE
  )
  port map(
    i_axis_tdata              => mpx_tdata,
    i_axis_tstrb              => mpx_tstrb,
    i_axis_tlast              => mpx_tlast,
    i_axis_tvalid             => mpx_tvalid,
    o_axis_tready             => mpx_tready,

    o_axis_tdata              => fifo_tdata,
    o_axis_tstrb              => fifo_tstrb,
    o_axis_tlast              => fifo_tlast,
    o_axis_tvalid             => fifo_tvalid,
    i_axis_tready             => fifo_tready,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_dst : IM_HUB_AXI4S_DST
  generic map(
    G_DAT_WIDTH               => G_DAT_WIDTH
  )
  port map(
    i_axis_tdata              => fifo_tdata,
    i_axis_tstrb              => fifo_tstrb,
    i_axis_tlast              => fifo_tlast,
    i_axis_tvalid             => fifo_tvalid,
    o_axis_tready             => fifo_tready,

    o_axis_0_tdata            => o_axis_m0_tdata,
    o_axis_0_tstrb            => o_axis_m0_tstrb,
    o_axis_0_tlast            => o_axis_m0_tlast,
    o_axis_0_tvalid           => o_axis_m0_tvalid,
    i_axis_0_tready           => i_axis_m0_tready,

    o_axis_1_tdata            => o_axis_m1_tdata,
    o_axis_1_tstrb            => o_axis_m1_tstrb,
    o_axis_1_tlast            => o_axis_m1_tlast,
    o_axis_1_tvalid           => o_axis_m1_tvalid,
    i_axis_1_tready           => i_axis_m1_tready,

    o_axis_2_tdata            => o_axis_m2_tdata,
    o_axis_2_tstrb            => o_axis_m2_tstrb,
    o_axis_2_tlast            => o_axis_m2_tlast,
    o_axis_2_tvalid           => o_axis_m2_tvalid,
    i_axis_2_tready           => i_axis_m2_tready,

    o_axis_3_tdata            => o_axis_m3_tdata,
    o_axis_3_tstrb            => o_axis_m3_tstrb,
    o_axis_3_tlast            => o_axis_m3_tlast,
    o_axis_3_tvalid           => o_axis_m3_tvalid,
    i_axis_3_tready           => i_axis_m3_tready,

    o_axis_4_tdata            => o_axis_m4_tdata,
    o_axis_4_tstrb            => o_axis_m4_tstrb,
    o_axis_4_tlast            => o_axis_m4_tlast,
    o_axis_4_tvalid           => o_axis_m4_tvalid,
    i_axis_4_tready           => i_axis_m4_tready,

    o_axis_5_tdata            => o_axis_m5_tdata,
    o_axis_5_tstrb            => o_axis_m5_tstrb,
    o_axis_5_tlast            => o_axis_m5_tlast,
    o_axis_5_tvalid           => o_axis_m5_tvalid,
    i_axis_5_tready           => i_axis_m5_tready,

    o_axis_6_tdata            => o_axis_m6_tdata,
    o_axis_6_tstrb            => o_axis_m6_tstrb,
    o_axis_6_tlast            => o_axis_m6_tlast,
    o_axis_6_tvalid           => o_axis_m6_tvalid,
    i_axis_6_tready           => i_axis_m6_tready,

    o_axis_7_tdata            => o_axis_m7_tdata,
    o_axis_7_tstrb            => o_axis_m7_tstrb,
    o_axis_7_tlast            => o_axis_m7_tlast,
    o_axis_7_tvalid           => o_axis_m7_tvalid,
    i_axis_7_tready           => i_axis_m7_tready,

    o_axis_8_tdata            => o_axis_m8_tdata,
    o_axis_8_tstrb            => o_axis_m8_tstrb,
    o_axis_8_tlast            => o_axis_m8_tlast,
    o_axis_8_tvalid           => o_axis_m8_tvalid,
    i_axis_8_tready           => i_axis_m8_tready,

    o_axis_9_tdata            => o_axis_m9_tdata,
    o_axis_9_tstrb            => o_axis_m9_tstrb,
    o_axis_9_tlast            => o_axis_m9_tlast,
    o_axis_9_tvalid           => o_axis_m9_tvalid,
    i_axis_9_tready           => i_axis_m9_tready,

    o_axis_10_tdata           => o_axis_m10_tdata,
    o_axis_10_tstrb           => o_axis_m10_tstrb,
    o_axis_10_tlast           => o_axis_m10_tlast,
    o_axis_10_tvalid          => o_axis_m10_tvalid,
    i_axis_10_tready          => i_axis_m10_tready,

    o_axis_11_tdata           => o_axis_m11_tdata,
    o_axis_11_tstrb           => o_axis_m11_tstrb,
    o_axis_11_tlast           => o_axis_m11_tlast,
    o_axis_11_tvalid          => o_axis_m11_tvalid,
    i_axis_11_tready          => i_axis_m11_tready,

    o_axis_12_tdata           => o_axis_m12_tdata,
    o_axis_12_tstrb           => o_axis_m12_tstrb,
    o_axis_12_tlast           => o_axis_m12_tlast,
    o_axis_12_tvalid          => o_axis_m12_tvalid,
    i_axis_12_tready          => i_axis_m12_tready,

    o_axis_13_tdata           => o_axis_m13_tdata,
    o_axis_13_tstrb           => o_axis_m13_tstrb,
    o_axis_13_tlast           => o_axis_m13_tlast,
    o_axis_13_tvalid          => o_axis_m13_tvalid,
    i_axis_13_tready          => i_axis_m13_tready,

    o_axis_14_tdata           => o_axis_m14_tdata,
    o_axis_14_tstrb           => o_axis_m14_tstrb,
    o_axis_14_tlast           => o_axis_m14_tlast,
    o_axis_14_tvalid          => o_axis_m14_tvalid,
    i_axis_14_tready          => i_axis_m14_tready,

    o_axis_15_tdata           => o_axis_m15_tdata,
    o_axis_15_tstrb           => o_axis_m15_tstrb,
    o_axis_15_tlast           => o_axis_m15_tlast,
    o_axis_15_tvalid          => o_axis_m15_tvalid,
    i_axis_15_tready          => i_axis_m15_tready,

    o_axis_16_tdata           => o_axis_m16_tdata,
    o_axis_16_tstrb           => o_axis_m16_tstrb,
    o_axis_16_tlast           => o_axis_m16_tlast,
    o_axis_16_tvalid          => o_axis_m16_tvalid,
    i_axis_16_tready          => i_axis_m16_tready,

    o_axis_17_tdata           => o_axis_m17_tdata,
    o_axis_17_tstrb           => o_axis_m17_tstrb,
    o_axis_17_tlast           => o_axis_m17_tlast,
    o_axis_17_tvalid          => o_axis_m17_tvalid,
    i_axis_17_tready          => i_axis_m17_tready,

    o_axis_18_tdata           => o_axis_m18_tdata,
    o_axis_18_tstrb           => o_axis_m18_tstrb,
    o_axis_18_tlast           => o_axis_m18_tlast,
    o_axis_18_tvalid          => o_axis_m18_tvalid,
    i_axis_18_tready          => i_axis_m18_tready,

    o_axis_19_tdata           => o_axis_m19_tdata,
    o_axis_19_tstrb           => o_axis_m19_tstrb,
    o_axis_19_tlast           => o_axis_m19_tlast,
    o_axis_19_tvalid          => o_axis_m19_tvalid,
    i_axis_19_tready          => i_axis_m19_tready,

    o_axis_20_tdata           => o_axis_m20_tdata,
    o_axis_20_tstrb           => o_axis_m20_tstrb,
    o_axis_20_tlast           => o_axis_m20_tlast,
    o_axis_20_tvalid          => o_axis_m20_tvalid,
    i_axis_20_tready          => i_axis_m20_tready,

    o_axis_21_tdata           => o_axis_m21_tdata,
    o_axis_21_tstrb           => o_axis_m21_tstrb,
    o_axis_21_tlast           => o_axis_m21_tlast,
    o_axis_21_tvalid          => o_axis_m21_tvalid,
    i_axis_21_tready          => i_axis_m21_tready,

    o_axis_22_tdata           => o_axis_m22_tdata,
    o_axis_22_tstrb           => o_axis_m22_tstrb,
    o_axis_22_tlast           => o_axis_m22_tlast,
    o_axis_22_tvalid          => o_axis_m22_tvalid,
    i_axis_22_tready          => i_axis_m22_tready,

    o_axis_23_tdata           => o_axis_m23_tdata,
    o_axis_23_tstrb           => o_axis_m23_tstrb,
    o_axis_23_tlast           => o_axis_m23_tlast,
    o_axis_23_tvalid          => o_axis_m23_tvalid,
    i_axis_23_tready          => i_axis_m23_tready,

    o_axis_24_tdata           => o_axis_m24_tdata,
    o_axis_24_tstrb           => o_axis_m24_tstrb,
    o_axis_24_tlast           => o_axis_m24_tlast,
    o_axis_24_tvalid          => o_axis_m24_tvalid,
    i_axis_24_tready          => i_axis_m24_tready,

    o_axis_25_tdata           => o_axis_m25_tdata,
    o_axis_25_tstrb           => o_axis_m25_tstrb,
    o_axis_25_tlast           => o_axis_m25_tlast,
    o_axis_25_tvalid          => o_axis_m25_tvalid,
    i_axis_25_tready          => i_axis_m25_tready,

    o_axis_26_tdata           => o_axis_m26_tdata,
    o_axis_26_tstrb           => o_axis_m26_tstrb,
    o_axis_26_tlast           => o_axis_m26_tlast,
    o_axis_26_tvalid          => o_axis_m26_tvalid,
    i_axis_26_tready          => i_axis_m26_tready,

    o_axis_27_tdata           => o_axis_m27_tdata,
    o_axis_27_tstrb           => o_axis_m27_tstrb,
    o_axis_27_tlast           => o_axis_m27_tlast,
    o_axis_27_tvalid          => o_axis_m27_tvalid,
    i_axis_27_tready          => i_axis_m27_tready,

    o_axis_28_tdata           => o_axis_m28_tdata,
    o_axis_28_tstrb           => o_axis_m28_tstrb,
    o_axis_28_tlast           => o_axis_m28_tlast,
    o_axis_28_tvalid          => o_axis_m28_tvalid,
    i_axis_28_tready          => i_axis_m28_tready,

    o_axis_29_tdata           => o_axis_m29_tdata,
    o_axis_29_tstrb           => o_axis_m29_tstrb,
    o_axis_29_tlast           => o_axis_m29_tlast,
    o_axis_29_tvalid          => o_axis_m29_tvalid,
    i_axis_29_tready          => i_axis_m29_tready,

    o_axis_30_tdata           => o_axis_m30_tdata,
    o_axis_30_tstrb           => o_axis_m30_tstrb,
    o_axis_30_tlast           => o_axis_m30_tlast,
    o_axis_30_tvalid          => o_axis_m30_tvalid,
    i_axis_30_tready          => i_axis_m30_tready,

    o_axis_31_tdata           => o_axis_m31_tdata,
    o_axis_31_tstrb           => o_axis_m31_tstrb,
    o_axis_31_tlast           => o_axis_m31_tlast,
    o_axis_31_tvalid          => o_axis_m31_tvalid,
    i_axis_31_tready          => i_axis_m31_tready,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );
end RTL;
