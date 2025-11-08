--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
library IM_LIB;
use IM_LIB.typ.all;

entity IM_HUB_AXI4S32_DST is
  generic (
    G_CH                      : integer
  );
  port (
    i_axis_tdata              : in  std_logic_vector(31 downto 0);
    i_axis_tstrb              : in  std_logic_vector( 3 downto 0);
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    o_axis_tdata              : out slv32_vector    (G_CH - 1 downto 0);
    o_axis_tstrb              : out slv4_vector     (G_CH - 1 downto 0);
    o_axis_tlast              : out std_logic_vector(G_CH - 1 downto 0);
    o_axis_tvalid             : out std_logic_vector(G_CH - 1 downto 0);
    i_axis_tready             : in  std_logic_vector(G_CH - 1 downto 0) := (others => '1');

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_HUB_AXI4S32_DST;
architecture RTL of IM_HUB_AXI4S32_DST is
  constant ARR_CNT            : integer := G_CH - 1;

  signal trs_in               : boolean := FALSE;
  signal tready_n             : std_logic_vector(ARR_CNT downto 0) := (others => '0');
  signal tvalid               : std_logic_vector(ARR_CNT downto 0) := (others => '1');
  signal o_axis_tready_buf    : std_logic := '0';
  signal o_axis_tvalid_buf    : std_logic_vector(ARR_CNT downto 0) := (others => '0');
begin
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
  o_axis_tdata                <= (others => i_axis_tdata);
  o_axis_tstrb                <= (others => i_axis_tstrb);
  o_axis_tlast                <= (others => i_axis_tlast);
  o_axis_tvalid               <= o_axis_tvalid_buf;
end RTL;
