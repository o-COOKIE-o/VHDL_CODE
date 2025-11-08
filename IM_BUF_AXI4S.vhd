--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BUF_AXI4S is
  generic (
    G_DAT_WIDTH               : integer;
    G_FULLMODE                : boolean := FALSE
  );
  port (
    i_axis_tdata              : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_axis_tstrb              : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    o_axis_tdata              : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_tstrb              : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BUF_AXI4S;
architecture RTL of IM_BUF_AXI4S is
  signal i_axis_tdata_buf     : std_logic_vector(i_axis_tdata'range) := (others => '0');
  signal i_axis_tstrb_buf     : std_logic_vector(i_axis_tstrb'range) := (others => '0');
  signal i_axis_tlast_buf     : std_logic := '0';
  signal i_axis_tvalid_buf    : std_logic := '0';
  signal o_axis_tready_buf    : std_logic := '1';
  signal o_axis_tdata_buf     : std_logic_vector(o_axis_tdata'range) := (others => '0');
  signal o_axis_tstrb_buf     : std_logic_vector(o_axis_tstrb'range) := (others => '0');
  signal o_axis_tlast_buf     : std_logic := '0';
  signal o_axis_tvalid_buf    : std_logic := '0';
begin
  g_full : if (G_FULLMODE) generate
    process (i_clk)
    begin
    if (i_clk'event and i_clk = '1') then
      if    (i_axis_tready = '0' and o_axis_tvalid_buf = '1') then
        if    (o_axis_tready_buf = '1') then
          i_axis_tdata_buf    <= i_axis_tdata;
          i_axis_tstrb_buf    <= i_axis_tstrb;
          i_axis_tlast_buf    <= i_axis_tlast;
          i_axis_tvalid_buf   <= i_axis_tvalid;
          o_axis_tready_buf   <= not i_axis_tvalid;
        end if;
      else
        i_axis_tvalid_buf     <= '0';
        o_axis_tready_buf     <= '1';
        o_axis_tdata_buf      <= i_axis_tdata;
        o_axis_tstrb_buf      <= i_axis_tstrb;
        o_axis_tlast_buf      <= i_axis_tlast;
        o_axis_tvalid_buf     <= i_axis_tvalid;
        if    (i_axis_tvalid_buf = '1') then
          o_axis_tdata_buf    <= i_axis_tdata_buf;
          o_axis_tstrb_buf    <= i_axis_tstrb_buf;
          o_axis_tlast_buf    <= i_axis_tlast_buf;
          o_axis_tvalid_buf   <= '1';
        end if;
      end if;

      if    (i_rst = '1') then
        i_axis_tvalid_buf     <= '0';
        o_axis_tready_buf     <= '1';
        o_axis_tvalid_buf     <= '0';
      end if;
    end if;
    end process;
  end generate;

  g_half : if (not G_FULLMODE) generate
    process (i_clk)
    begin
    if (i_clk'event and i_clk = '1') then
      if    (i_axis_tready = '1') then
        o_axis_tready_buf     <= '1';
        o_axis_tvalid_buf     <= '0';
      end if;

      if    (o_axis_tready_buf = '1') then
        o_axis_tready_buf     <= not i_axis_tvalid;
        o_axis_tdata_buf      <= i_axis_tdata;
        o_axis_tstrb_buf      <= i_axis_tstrb;
        o_axis_tlast_buf      <= i_axis_tlast;
        o_axis_tvalid_buf     <= i_axis_tvalid;
      end if;

      if    (i_rst = '1') then
        o_axis_tready_buf     <= '1';
        o_axis_tvalid_buf     <= '0';
      end if;
    end if;
    end process;
  end generate;

  o_axis_tready               <= o_axis_tready_buf;
  o_axis_tdata                <= o_axis_tdata_buf;
  o_axis_tstrb                <= o_axis_tstrb_buf;
  o_axis_tlast                <= o_axis_tlast_buf;
  o_axis_tvalid               <= o_axis_tvalid_buf;
end RTL;
