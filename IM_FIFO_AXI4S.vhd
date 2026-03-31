--Last Update 2026.03.31 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_FIFO_AXI4S is
  generic (
    G_DAT_WIDTH               : integer;
    G_FIFO_DPT                : integer range 16 to 4194304;
    G_MEM_TYP                 : integer := 0--0:"auto", 1:"block", 2:"distributed", 3:"ultra"
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
    G_WR_DAT_WIDTH            : integer;
    G_WR_DPT                  : integer;
    G_RD_DAT_WIDTH            : integer;
    G_MEM_TYP                 : integer
  );
  port (
    i_wr_vld                  : in  std_logic;
    i_wr_dat                  : in  std_logic_vector;
    o_wr_rdy                  : out std_logic;

    o_rd_vld                  : out std_logic;
    o_rd_dat                  : out std_logic_vector;
    i_rd_rdy                  : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  signal fifo_wr_dat          : std_logic_vector(i_axis_tdata'length + i_axis_tstrb'length downto 0) := (others => '0');
  signal fifo_rd_dat          : std_logic_vector(fifo_wr_dat'range) := (others => '0');
begin
  o_axis_tdata                <= fifo_rd_dat(o_axis_tdata'range);
  o_axis_tstrb                <= fifo_rd_dat(fifo_rd_dat'high - 1 downto G_DAT_WIDTH);
  o_axis_tlast                <= fifo_rd_dat(fifo_rd_dat'high);

  fifo_wr_dat                 <= i_axis_tlast & i_axis_tstrb & i_axis_tdata;

  u_fifo : IM_FIFO_SYNC
  generic map(
    G_WR_DAT_WIDTH            => fifo_wr_dat'length,
    G_WR_DPT                  => G_FIFO_DPT,
    G_RD_DAT_WIDTH            => fifo_rd_dat'length,
    G_MEM_TYP                 => G_MEM_TYP
  )
  port map(
    i_wr_vld                  => i_axis_tvalid,
    i_wr_dat                  => fifo_wr_dat,
    o_wr_rdy                  => o_axis_tready,

    o_rd_vld                  => o_axis_tvalid,
    o_rd_dat                  => fifo_rd_dat,
    i_rd_rdy                  => i_axis_tready,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );
end RTL;
