--Last Update 2025.11.10 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
library IM_LIB;
use IM_LIB.typ.all;

entity IM_HUB_AXI4S32 is
  generic (
    G_S_CH                    : integer;
    G_M_CH                    : integer;
    G_FIFO_WRITE_DEPTH        : integer range 16 to 4194304;
    G_FIFO_MEMORY_TYPE        : string := "auto" --"auto", "block", "distributed", "ultra"
  );
  port (
    i_axis_s_tdata            : in  slv32_vector    (G_S_CH - 1 downto 0);
    i_axis_s_tstrb            : in  slv4_vector     (G_S_CH - 1 downto 0);
    i_axis_s_tlast            : in  std_logic_vector(G_S_CH - 1 downto 0);
    i_axis_s_tvalid           : in  std_logic_vector(G_S_CH - 1 downto 0);
    o_axis_s_tready           : out std_logic_vector(G_S_CH - 1 downto 0);

    o_axis_m_tdata            : out slv32_vector    (G_M_CH - 1 downto 0);
    o_axis_m_tstrb            : out slv4_vector     (G_M_CH - 1 downto 0);
    o_axis_m_tlast            : out std_logic_vector(G_M_CH - 1 downto 0);
    o_axis_m_tvalid           : out std_logic_vector(G_M_CH - 1 downto 0);
    i_axis_m_tready           : in  std_logic_vector(G_M_CH - 1 downto 0) := (others => '1');

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_HUB_AXI4S32;
architecture RTL of IM_HUB_AXI4S32 is
  component IM_HUB_AXI4S32_MPX
  generic (
    G_CH                      : integer
  );
  port (
    i_axis_tdata              : in  slv32_vector;
    i_axis_tstrb              : in  slv4_vector;
    i_axis_tlast              : in  std_logic_vector;
    i_axis_tvalid             : in  std_logic_vector;
    o_axis_tready             : out std_logic_vector;

    o_axis_tdata              : out std_logic_vector(31 downto 0);
    o_axis_tstrb              : out std_logic_vector( 3 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_HUB_AXI4S32_DST
  generic (
    G_CH                      : integer
  );
  port (
    i_axis_tdata              : in  std_logic_vector(31 downto 0);
    i_axis_tstrb              : in  std_logic_vector( 3 downto 0);
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    o_axis_tdata              : out slv32_vector;
    o_axis_tstrb              : out slv4_vector;
    o_axis_tlast              : out std_logic_vector;
    o_axis_tvalid             : out std_logic_vector;
    i_axis_tready             : in  std_logic_vector;

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

  signal mpx_tdata            : std_logic_vector(31 downto 0) := (others => '0');
  signal mpx_tstrb            : std_logic_vector( 3 downto 0) := (others => '0');
  signal mpx_tlast            : std_logic := '0';
  signal mpx_tvalid           : std_logic := '0';
  signal mpx_tready           : std_logic := '0';

  signal fifo_tdata           : std_logic_vector(31 downto 0) := (others => '0');
  signal fifo_tstrb           : std_logic_vector( 3 downto 0) := (others => '0');
  signal fifo_tlast           : std_logic := '0';
  signal fifo_tvalid          : std_logic := '0';
  signal fifo_tready          : std_logic := '0';
begin
  u_mpx : IM_HUB_AXI4S32_MPX
  generic map(
    G_CH                      => G_S_CH
  )
  port map(
    i_axis_tdata              => i_axis_s_tdata,
    i_axis_tstrb              => i_axis_s_tstrb,
    i_axis_tlast              => i_axis_s_tlast,
    i_axis_tvalid             => i_axis_s_tvalid,
    o_axis_tready             => o_axis_s_tready,

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
    G_DAT_WIDTH               => 32,
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

  u_dst : IM_HUB_AXI4S32_DST
  generic map(
    G_CH                      => G_M_CH
  )
  port map(
    i_axis_tdata              => fifo_tdata,
    i_axis_tstrb              => fifo_tstrb,
    i_axis_tlast              => fifo_tlast,
    i_axis_tvalid             => fifo_tvalid,
    o_axis_tready             => fifo_tready,

    o_axis_tdata              => o_axis_m_tdata,
    o_axis_tstrb              => o_axis_m_tstrb,
    o_axis_tlast              => o_axis_m_tlast,
    o_axis_tvalid             => o_axis_m_tvalid,
    i_axis_tready             => i_axis_m_tready,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );
end RTL;
