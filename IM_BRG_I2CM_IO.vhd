--Last Update 2026.04.03 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_I2CM_IO is
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
end IM_BRG_I2CM_IO;
architecture RTL of IM_BRG_I2CM_IO is
  constant CLKCYC             : integer := integer(G_CLK_FREQ * 1000.0 / G_SCL_FREQ);
  constant CLKCYC_CLKRISE     : integer := integer(G_CLK_FREQ * 1000.0 / G_SCL_FREQ * 0.60);
  constant CLKCYC_CLKFALL     : integer := integer(G_CLK_FREQ * 1000.0 / G_SCL_FREQ * 0.24);
  constant CLKCYC_CNT         : integer := CLKCYC - 1;

  constant UNGLITCH_LEN       : integer := integer(G_CLK_FREQ * 0.05);--50ns

  signal i_i2c_scl            : std_logic := '1';
  signal i_i2c_sda            : std_logic := '1';
  signal i_rx_scl_iob         : std_logic := '1';
  signal i_rx_sda_iob         : std_logic := '1';
  signal rx_scl_sr            : std_logic_vector(UNGLITCH_LEN downto 0) := (others => '1');
  signal rx_sda_sr            : std_logic_vector(UNGLITCH_LEN downto 0) := (others => '1');
  signal rx_scl               : std_logic := '1';
  signal rx_sda               : std_logic := '1';
  signal tx_tsf               : boolean := FALSE;
  signal clkcyc_dec           : boolean := FALSE;
  signal tx_scl_sr            : std_logic_vector(rx_scl_sr'length + 2 downto 0) := (others => '1');
  signal tx_scl_nxt           : std_logic := '1';
  signal tx_scl               : std_logic := '1';
  signal tx_sda               : std_logic := '1';
  signal clkcyc_cntr          : integer range 0 to CLKCYC_CNT := 0;
  signal o_i2c_scl_t          : std_logic := '1';
  signal o_i2c_sda_t          : std_logic := '1';
  signal o_tx_rdy_buf         : std_logic := '0';
  signal o_tx_prerdy_buf      : std_logic := '0';

  attribute IOB                         : string;
  attribute IOB of i_rx_scl_iob         : signal is "true";
  attribute IOB of i_rx_sda_iob         : signal is "true";
  attribute IOB of o_i2c_scl_t          : signal is "true";
  attribute IOB of o_i2c_sda_t          : signal is "true";
begin
  i_i2c_scl                   <= '0' when (b_i2c_scl = '0') else '1';
  i_i2c_sda                   <= '0' when (b_i2c_sda = '0') else '1';

  tx_tsf                      <= i_tx_vld = '1' and o_tx_rdy_buf = '1';

  clkcyc_dec                  <= clkcyc_cntr /= 0 and (rx_scl = '1' or tx_scl_sr(0) = '0');

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    -- INPUT BUFFER
    i_rx_scl_iob              <= i_i2c_scl;
    i_rx_sda_iob              <= i_i2c_sda;

    -- UNGLITCH
    rx_scl_sr                 <= rx_scl_sr(rx_scl_sr'high - 1 downto 0) & i_rx_scl_iob;
    rx_sda_sr                 <= rx_sda_sr(rx_sda_sr'high - 1 downto 0) & i_rx_sda_iob;

    if    (rx_scl_sr = 0) then
      rx_scl                  <= '0';
    elsif ((not rx_scl_sr) = 0) then
      rx_scl                  <= '1';
    end if;

    if    (rx_sda_sr = 0) then
      rx_sda                  <= '0';
    elsif ((not rx_sda_sr) = 0) then
      rx_sda                  <= '1';
    end if;

    -- TX PROCESS
    if    (clkcyc_cntr = CLKCYC_CLKRISE) then
      tx_scl                  <= '1';
    end if;

    if    (clkcyc_cntr = CLKCYC_CLKFALL) then
      tx_scl                  <= tx_scl_nxt;
    end if;

    if    (clkcyc_dec) then
      clkcyc_cntr             <= clkcyc_cntr - 1;
    end if;

    if    (tx_tsf) then
      clkcyc_cntr             <= CLKCYC_CNT;
      tx_scl_nxt              <= i_tx_scl;
      tx_sda                  <= i_tx_sda;
    end if;

    tx_scl_sr                 <= tx_scl & tx_scl_sr(tx_scl_sr'high downto 1);
    o_i2c_scl_t               <= tx_scl;
    o_i2c_sda_t               <= tx_sda;

    if    (i_rst = '1') then
      rx_scl                  <= '1';
      rx_sda                  <= '1';
      clkcyc_cntr             <=  0;
      tx_scl_sr               <= (others => '1');
      tx_scl                  <= '1';
      tx_sda                  <= '1';
      o_i2c_scl_t             <= '1';
      o_i2c_sda_t             <= '1';
    end if;
  end if;
  end process;
  o_tx_rdy_buf                <= '1' when (clkcyc_cntr = 0) else '0';
  o_tx_prerdy_buf             <= '1' when (o_tx_rdy_buf = '1' or (clkcyc_cntr = 1 and clkcyc_dec)) else '0';

  b_i2c_scl                   <= 'Z' when (o_i2c_scl_t = '1') else '0';
  b_i2c_sda                   <= 'Z' when (o_i2c_sda_t = '1') else '0';
  o_tx_rdy                    <= o_tx_rdy_buf;
  o_tx_prerdy                 <= o_tx_prerdy_buf;
  o_rx_scl                    <= rx_scl;
  o_rx_sda                    <= rx_sda;
end RTL;
