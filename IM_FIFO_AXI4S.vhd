--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_FIFO_AXI4S is
  generic (
    G_DAT_WIDTH               : integer;
    G_FIFO_WRITE_DEPTH        : integer range 16 to 4194304;
    G_FIFO_MEMORY_TYPE        : string := "auto" --"auto", "block", "distributed", "ultra"
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
end IM_FIFO_AXI4S;
architecture RTL of IM_FIFO_AXI4S is
  component IM_FIFO_SYNC
  generic (
    WRITE_DATA_WIDTH          : integer;
    FIFO_WRITE_DEPTH          : integer;
    READ_DATA_WIDTH           : integer;
    FIFO_MEMORY_TYPE          : string;
    READ_MODE                 : string
  );
  port (
    wr_en                     : in  std_logic;
    din                       : in  std_logic_vector;
    full                      : out std_logic;
    wr_rst_busy               : out std_logic;

    valid                     : out std_logic;
    dout                      : out std_logic_vector;
    rd_en                     : in  std_logic;

    rst                       : in std_logic;
    clk                       : in std_logic
  );
  end component;

  signal fifo_wr_en           : std_logic := '0';
  signal fifo_din             : std_logic_vector(i_axis_tdata'length + i_axis_tstrb'length downto 0) := (others => '0');
  signal fifo_full            : std_logic := '0';
  signal fifo_wr_rst_busy     : std_logic := '0';
  signal fifo_valid           : std_logic := '0';
  signal fifo_dout            : std_logic_vector(fifo_din'range) := (others => '0');
  signal fifo_rd_en           : std_logic := '0';
begin
  fifo_wr_en                  <= i_axis_tvalid;
  fifo_din                    <= i_axis_tlast & i_axis_tstrb & i_axis_tdata;
  o_axis_tready               <= '0' when (fifo_wr_rst_busy = '1' or fifo_full = '1') else '1';

  o_axis_tdata                <= fifo_dout(o_axis_tdata'range);
  o_axis_tstrb                <= fifo_dout(fifo_dout'high - 1 downto G_DAT_WIDTH);
  o_axis_tlast                <= fifo_dout(fifo_dout'high);
  o_axis_tvalid               <= fifo_valid;
  fifo_rd_en                  <= i_axis_tready;

  u_fifo : IM_FIFO_SYNC
  generic map(
    WRITE_DATA_WIDTH          => fifo_din'length,
    FIFO_WRITE_DEPTH          => G_FIFO_WRITE_DEPTH,
    READ_DATA_WIDTH           => fifo_dout'length,
    FIFO_MEMORY_TYPE          => G_FIFO_MEMORY_TYPE,
    READ_MODE                 => "fwft"
  )
  port map(
    wr_en                     => fifo_wr_en,
    din                       => fifo_din,
    full                      => fifo_full,
    wr_rst_busy               => fifo_wr_rst_busy,

    valid                     => fifo_valid,
    dout                      => fifo_dout,
    rd_en                     => fifo_rd_en,

    rst                       => i_rst,
    clk                       => i_clk
  );
end RTL;
