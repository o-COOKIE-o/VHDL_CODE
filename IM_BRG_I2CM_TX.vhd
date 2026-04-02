--Last Update 2026.04.03 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_I2CM_TX is
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
end IM_BRG_I2CM_TX;
architecture RTL of IM_BRG_I2CM_TX is
  signal cmd_tsf              : boolean := FALSE;
  signal tx_vld_sr            : std_logic_vector(11 downto 0) := (others => '0');
  signal tx_scl_sr            : std_logic_vector(11 downto 0) := (others => '0');
  signal tx_sda_sr            : std_logic_vector(11 downto 0) := (others => '0');
  signal o_cmd_rdy_buf        : std_logic := '0';
begin
  cmd_tsf                     <= i_cmd_vld = '1' and o_cmd_rdy_buf = '1';

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    if    (i_tx_rdy = '1') then
      tx_vld_sr               <= tx_vld_sr(tx_vld_sr'high - 1 downto 0) & '0';
      tx_scl_sr               <= tx_scl_sr(tx_scl_sr'high - 1 downto 0) & '0';
      tx_sda_sr               <= tx_sda_sr(tx_sda_sr'high - 1 downto 0) & '0';
    end if;

    if    (cmd_tsf) then
      if    (i_cmd_cod = 1) then
        -- 1:BUS CLEAR
        tx_vld_sr             <= "111111111111";
        tx_scl_sr             <= "000000000011";
        tx_sda_sr             <= "111111111101";
      elsif (i_cmd_cod = 2) then
        -- 2:START
        tx_vld_sr             <= "110000000000";
        tx_scl_sr             <= "100000000000";
        tx_sda_sr             <= "100000000000";
      elsif (i_cmd_cod = 3) then
        -- 3:STOP
        tx_vld_sr             <= "110000000000";
        tx_scl_sr             <= "110000000000";
        tx_sda_sr             <= "010000000000";
      elsif (i_cmd_cod = 4) then
        -- 4:WRITE
        tx_vld_sr             <= "111111111000";
        tx_scl_sr             <= "000000000000";
        tx_sda_sr         <= i_cmd_dat & "1000";
      elsif (i_cmd_cod = 5) then
        -- 5:READ WITH ACK
        tx_vld_sr             <= "111111111000";
        tx_scl_sr             <= "000000000000";
        tx_sda_sr             <= "111111110000";
      elsif (i_cmd_cod = 6) then
        -- 6:READ WITH NACK
        tx_vld_sr             <= "111111111000";
        tx_scl_sr             <= "000000000000";
        tx_sda_sr             <= "111111111000";
      end if;
    end if;

    if    (i_rst = '1') then
      tx_vld_sr               <= (others => '0');
    end if;
  end if;
  end process;
  o_cmd_rdy_buf               <= '1' when (tx_vld_sr(tx_vld_sr'high) = '0' and i_tx_prerdy = '1') else '0';

  o_cmd_rdy                   <= o_cmd_rdy_buf;
  o_tx_vld                    <= tx_vld_sr(tx_vld_sr'high);
  o_tx_scl                    <= tx_scl_sr(tx_scl_sr'high);
  o_tx_sda                    <= tx_sda_sr(tx_sda_sr'high);
end RTL;
