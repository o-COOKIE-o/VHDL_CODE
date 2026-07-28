--Last Update 2026.07.29 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_I2CM is
  generic (
    G_CLK_FREQ                : real;--i_clk Frequency(MHz)
    G_SCL_FREQ                : real;--o_i2c_scl Frequency(kHz)
    G_BUF_DPT                 : integer;--Command FIFO Depth
    G_BUF_FULL                : integer;
    G_ADR_BASE                : std_logic_vector(31 downto 0)--Aligned 8Byte
  );
  port (
    --I2C PORT
    b_i2c_scl                 : inout std_logic;
    b_i2c_sda                 : inout std_logic;
    --Read Return
    o_axis_tdata              : out std_logic_vector(31 downto 0);
    o_axis_tstrb              : out std_logic_vector( 3 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;
    --Write Access and Read Request
    i_axis_tdata              : in  std_logic_vector(31 downto 0);
    i_axis_tstrb              : in  std_logic_vector( 3 downto 0);
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BRG_I2CM;
architecture RTL of IM_BRG_I2CM is
  component IM_BRG_AXI4S_GPIO
  generic (
    G_DAT_WIDTH               : integer;
    G_ADR_WIDTH               : integer
  );
  port (
    --Address Control
    i_adr_base_gpi            : in  std_logic_vector;
    i_adr_mask_gpi            : in  std_logic_vector;

    i_adr_base_gpo            : in  std_logic_vector;
    i_adr_mask_gpo            : in  std_logic_vector;
    --Read Return
    o_axis_tdata              : out std_logic_vector;
    o_axis_tstrb              : out std_logic_vector;
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;
    --Write Access and Read Request
    i_axis_tdata              : in  std_logic_vector;
    i_axis_tstrb              : in  std_logic_vector;
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;
    --Read address and data port
    o_gpi_vld                 : out std_logic;
    o_gpi_adr                 : out std_logic_vector;
    i_gpi_dat                 : in  std_logic_vector;
    i_gpi_rdy                 : in  std_logic;
    --Write address and data port
    o_gpo_vld                 : out std_logic;
    o_gpo_adr                 : out std_logic_vector;
    o_gpo_dat                 : out std_logic_vector;
    o_gpo_stb                 : out std_logic_vector;
    i_gpo_rdy                 : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_FIFO_SYNC
  generic (
    G_WR_DAT_WIDTH            : integer;
    G_WR_DPT                  : integer;
    G_WR_PFL_TH               : integer;
    G_RD_DAT_WIDTH            : integer
  );
  port (
    i_wr_vld                  : in  std_logic;
    i_wr_dat                  : in  std_logic_vector;
    o_wr_pfl                  : out std_logic;

    o_rd_vld                  : out std_logic;
    o_rd_dat                  : out std_logic_vector;
    i_rd_rdy                  : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_BRG_I2CM_TX
  generic (
    G_CLK_FREQ                : real--i_clk Frequency(MHz)
  );
  port (
    --COMMAND IF
    i_cmd_vld                 : in  std_logic;
    i_cmd_cod                 : in  std_logic_vector( 2 downto 0);
    -- 0:NOP
    -- 1:BUS CLEAR
    -- 2:START
    -- 3:STOP
    -- 4:WRITE
    -- 5:READ WITH ACK
    -- 6:READ WITH NACK
    -- 7:WAIT Xms
    i_cmd_dat                 : in  std_logic_vector( 7 downto 0);
    o_cmd_rdy                 : out std_logic;
    --To IO Module
    o_tx_vld                  : out std_logic;
    o_tx_scl                  : out std_logic;
    o_tx_sda                  : out std_logic;
    i_tx_rdy                  : in  std_logic;
    i_tx_prerdy               : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_BRG_I2CM_IO
  generic (
    G_CLK_FREQ                : real;--i_clk Frequency(MHz)
    G_SCL_FREQ                : real --o_rx_scl Frequency(kHz)
  );
  port (
    --I2C PORT
    b_i2c_scl                 : inout std_logic;
    b_i2c_sda                 : inout std_logic;
    --COMMAND IF
    i_tx_vld                  : in  std_logic;
    i_tx_scl                  : in  std_logic;
    i_tx_sda                  : in  std_logic;
    o_tx_rdy                  : out std_logic;
    o_tx_prerdy               : out std_logic;--o_tx_rdyより1CLK早くアサート
    --BUFFERD OUT
    o_rx_scl                  : out std_logic;
    o_rx_sda                  : out std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_BRG_I2CM_RX
  port (
    --COMMAND IF
    i_cmd_vld                 : in  std_logic;
    i_cmd_tag                 : in  std_logic_vector( 7 downto 0);
    i_cmd_cod                 : in  std_logic_vector( 2 downto 0);
    i_cmd_dat                 : in  std_logic_vector( 7 downto 0);
    i_cmd_rdy                 : in  std_logic;
    --BUFFERD IN
    i_rx_scl                  : in  std_logic;
    i_rx_sda                  : in  std_logic;
    --STATUS
    o_sta_vld                 : out std_logic;--1CLK PULSE
    o_sta_tag                 : out std_logic_vector( 7 downto 0);
    o_sta_cod                 : out std_logic_vector( 2 downto 0);
    o_sta_dat                 : out std_logic_vector( 7 downto 0);--Readback Data(Write) / Read Data(Read)
    o_sta_ack                 : out std_logic;--'0':Ack '1':Nack(Write only)
    o_sta_com                 : out std_logic;--'0':NoError '1':Compair Error(Write only)

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  constant ADR_BASE_GPI       : std_logic_vector(31 downto 0) := G_ADR_BASE + X"0000_0008";
  constant ADR_MASK_GPI       : std_logic_vector(31 downto 0) := X"FFFF_FFF8";

  constant ADR_BASE_GPO       : std_logic_vector(31 downto 0) := G_ADR_BASE + X"0000_0004";
  constant ADR_MASK_GPO       : std_logic_vector(31 downto 0) := X"FFFF_FFFC";

  signal rreg_8               : std_logic_vector(31 downto 0) := (others => '0');
  signal rreg_C               : std_logic_vector(31 downto 0) := (others => '0');

  signal gpi_vld              : std_logic := '0';
  signal gpi_adr              : std_logic_vector(31 downto 0) := (others => '0');
  signal gpi_dat              : std_logic_vector(31 downto 0) := (others => '0');

  signal gpo_vld              : std_logic := '0';
  signal gpo_adr              : std_logic_vector(31 downto 0) := (others => '0');
  signal gpo_dat              : std_logic_vector(31 downto 0) := (others => '0');
  signal gpo_stb              : std_logic_vector( 3 downto 0) := (others => '0');

  signal txfifo_wvld          : std_logic := '0';
  signal txfifo_wdat          : std_logic_vector(18 downto 0) := (others => '0');
  signal txfifo_wful          : std_logic := '0';
  signal txfifo_rvld          : std_logic := '0';
  signal txfifo_rdat          : std_logic_vector(18 downto 0) := (others => '0');
  signal txfifo_rrdy          : std_logic := '0';

  signal io_tx_vld            : std_logic := '0';
  signal io_tx_scl            : std_logic := '0';
  signal io_tx_sda            : std_logic := '0';
  signal io_tx_rdy            : std_logic := '0';
  signal io_tx_prerdy         : std_logic := '0';
  signal io_rx_scl            : std_logic := '0';
  signal io_rx_sda            : std_logic := '0';

  signal rx_sta_vld           : std_logic := '0';
  signal rx_sta_tag           : std_logic_vector( 7 downto 0) := (others => '0');
  signal rx_sta_cod           : std_logic_vector( 2 downto 0) := (others => '0');
  signal rx_sta_dat           : std_logic_vector( 7 downto 0) := (others => '0');
  signal rx_sta_ack           : std_logic := '0';
  signal rx_sta_com           : std_logic := '0';

  signal rxfifo_wvld          : std_logic := '0';
  signal rxfifo_wdat          : std_logic_vector(20 downto 0) := (others => '0');
  signal rxfifo_rvld          : std_logic := '0';
  signal rxfifo_rdat          : std_logic_vector(20 downto 0) := (others => '0');
  signal rxfifo_rrdy          : std_logic := '0';
begin
  txfifo_wvld                 <= gpo_vld when (gpo_stb(1 downto 0) = "11") else '0';
  txfifo_wdat                 <= gpo_dat(18 downto 0);

  rxfifo_wvld                 <= rx_sta_vld;
  rxfifo_wdat(20)             <= rx_sta_com;
  rxfifo_wdat(19)             <= rx_sta_ack;
  rxfifo_wdat(18 downto 16)   <= rx_sta_cod;
  rxfifo_wdat(15 downto  8)   <= rx_sta_tag;
  rxfifo_wdat( 7 downto  0)   <= rx_sta_dat;
  rxfifo_rrdy                 <= gpi_vld when (gpi_adr(2) = '1') else '0';

  gpi_dat                     <= rreg_C  when (gpi_adr(2) = '1') else rreg_8;

  rreg_8(0)                   <= txfifo_wful;

  rreg_C(20 downto 0)         <= rxfifo_rdat;
  rreg_C(23)                  <= rxfifo_rvld;

  u_gpio : IM_BRG_AXI4S_GPIO
  generic map(
    G_DAT_WIDTH               => 32,
    G_ADR_WIDTH               => 32
  )
  port map(
    i_adr_base_gpi            => ADR_BASE_GPI,
    i_adr_mask_gpi            => ADR_MASK_GPI,

    i_adr_base_gpo            => ADR_BASE_GPO,
    i_adr_mask_gpo            => ADR_MASK_GPO,

    o_axis_tdata              => o_axis_tdata,
    o_axis_tstrb              => o_axis_tstrb,
    o_axis_tlast              => o_axis_tlast,
    o_axis_tvalid             => o_axis_tvalid,
    i_axis_tready             => i_axis_tready,

    i_axis_tdata              => i_axis_tdata,
    i_axis_tstrb              => i_axis_tstrb,
    i_axis_tlast              => i_axis_tlast,
    i_axis_tvalid             => i_axis_tvalid,
    o_axis_tready             => o_axis_tready,

    o_gpi_vld                 => gpi_vld,
    o_gpi_adr                 => gpi_adr,
    i_gpi_dat                 => gpi_dat,
    i_gpi_rdy                 => '1',

    o_gpo_vld                 => gpo_vld,
    o_gpo_adr                 => gpo_adr,
    o_gpo_dat                 => gpo_dat,
    o_gpo_stb                 => gpo_stb,
    i_gpo_rdy                 => '1',

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_txfifo : IM_FIFO_SYNC
  generic map(
    G_WR_DAT_WIDTH            => txfifo_wdat'length,
    G_WR_DPT                  => G_BUF_DPT,
    G_WR_PFL_TH               => G_BUF_FULL,
    G_RD_DAT_WIDTH            => txfifo_rdat'length
  )
  port map(
    i_wr_vld                  => txfifo_wvld,
    i_wr_dat                  => txfifo_wdat,
    o_wr_pfl                  => txfifo_wful,

    o_rd_vld                  => txfifo_rvld,
    o_rd_dat                  => txfifo_rdat,
    i_rd_rdy                  => txfifo_rrdy,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_tx : IM_BRG_I2CM_TX
  generic map(
    G_CLK_FREQ                => G_CLK_FREQ
  )
  port map(
    i_cmd_vld                 => txfifo_rvld,
    i_cmd_cod                 => txfifo_rdat(18 downto 16),
    i_cmd_dat                 => txfifo_rdat( 7 downto  0),
    o_cmd_rdy                 => txfifo_rrdy,

    o_tx_vld                  => io_tx_vld,
    o_tx_scl                  => io_tx_scl,
    o_tx_sda                  => io_tx_sda,
    i_tx_rdy                  => io_tx_rdy,
    i_tx_prerdy               => io_tx_prerdy,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_io : IM_BRG_I2CM_IO
  generic map(
    G_CLK_FREQ                => G_CLK_FREQ,
    G_SCL_FREQ                => G_SCL_FREQ
  )
  port map(
    b_i2c_scl                 => b_i2c_scl,
    b_i2c_sda                 => b_i2c_sda,

    i_tx_vld                  => io_tx_vld,
    i_tx_scl                  => io_tx_scl,
    i_tx_sda                  => io_tx_sda,
    o_tx_rdy                  => io_tx_rdy,
    o_tx_prerdy               => io_tx_prerdy,

    o_rx_scl                  => io_rx_scl,
    o_rx_sda                  => io_rx_sda,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_rx : IM_BRG_I2CM_RX
  port map(
    i_cmd_vld                 => txfifo_rvld,
    i_cmd_tag                 => txfifo_rdat(15 downto  8),
    i_cmd_cod                 => txfifo_rdat(18 downto 16),
    i_cmd_dat                 => txfifo_rdat( 7 downto  0),
    i_cmd_rdy                 => txfifo_rrdy,

    i_rx_scl                  => io_rx_scl,
    i_rx_sda                  => io_rx_sda,

    o_sta_vld                 => rx_sta_vld,
    o_sta_tag                 => rx_sta_tag,
    o_sta_cod                 => rx_sta_cod,
    o_sta_dat                 => rx_sta_dat,
    o_sta_ack                 => rx_sta_ack,
    o_sta_com                 => rx_sta_com,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_rxfifo : IM_FIFO_SYNC
  generic map(
    G_WR_DAT_WIDTH            => rxfifo_wdat'length,
    G_WR_DPT                  => G_BUF_DPT,
    G_WR_PFL_TH               => G_BUF_FULL,
    G_RD_DAT_WIDTH            => rxfifo_rdat'length
  )
  port map(
    i_wr_vld                  => rxfifo_wvld,
    i_wr_dat                  => rxfifo_wdat,
    o_wr_pfl                  => open,

    o_rd_vld                  => rxfifo_rvld,
    o_rd_dat                  => rxfifo_rdat,
    i_rd_rdy                  => rxfifo_rrdy,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );
end RTL;
