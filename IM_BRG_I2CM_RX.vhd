--Last Update 2026.04.03 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_I2CM_RX is
  port (
    --COMMAND IF
    i_cmd_vld                 : in  std_logic;
    i_cmd_cod                 : in  std_logic_vector( 2 downto 0);
    i_cmd_rdy                 : in  std_logic;
    --BUFFERD IN
    i_rx_scl                  : in  std_logic;
    i_rx_sda                  : in  std_logic;
    --STATUS
    o_sta_vld                 : out std_logic;--1CLK PULSE
    o_sta_rw                  : out std_logic;--'0':Write '1':Read
    o_sta_ack                 : out std_logic;--'0':Ack '1':Nack(Write only)
    o_sta_dat                 : out std_logic_vector( 7 downto 0);--Readback Data(Write) / Read Data(Read)

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BRG_I2CM_RX;
architecture RTL of IM_BRG_I2CM_RX is
  signal scl_rise             : boolean := FALSE;
  signal scl_rise_d           : boolean := FALSE;
  signal i_rx_scl_d           : std_logic := '1';
  signal sda_sr               : std_logic_vector( 8 downto 0) := (others => '0');
  signal bit_cntr             : integer range 0 to 9 := 0;
  signal cmd_cod              : std_logic_vector( 2 downto 0) := (others => '0');
  signal o_sta_vld_buf        : std_logic := '0';
  signal o_sta_rw_buf         : std_logic := '0';
  signal o_sta_ack_buf        : std_logic := '0';
  signal o_sta_dat_buf        : std_logic_vector( 7 downto 0) := (others => '0');
begin
  scl_rise                    <= i_rx_scl_d = '0' and i_rx_scl = '1';

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    i_rx_scl_d                <= i_rx_scl;

    if    (scl_rise) then
      sda_sr                  <= sda_sr(sda_sr'high - 1 downto 0) & i_rx_sda;
    end if;
    scl_rise_d                <= scl_rise;

    o_sta_vld_buf             <= '0';
    if    (scl_rise_d) then
      if    (bit_cntr /= 0) then
        bit_cntr              <= bit_cntr - 1;
      end if;

      if    (bit_cntr = 1) then
        if    (cmd_cod = 4) then--Write
          o_sta_vld_buf       <= '1';
          o_sta_rw_buf        <= '0';
          o_sta_ack_buf       <= sda_sr(0);
          o_sta_dat_buf       <= sda_sr(8 downto 1);
        end if;

        if    (cmd_cod = 5 or cmd_cod = 6) then--Read
          o_sta_vld_buf       <= '1';
          o_sta_rw_buf        <= '1';
          o_sta_ack_buf       <= '0';
          o_sta_dat_buf       <= sda_sr(8 downto 1);
        end if;
      end if;
    end if;

    if    (i_cmd_vld = '1' and i_cmd_rdy = '1') then
      cmd_cod                 <= i_cmd_cod;
      bit_cntr                <= 9;
    end if;

    if    (i_rst = '1') then
      scl_rise_d              <= FALSE;
      bit_cntr                <=  0;
      o_sta_vld_buf           <= '0';
    end if;
  end if;
  end process;
  o_sta_vld                   <= o_sta_vld_buf;
  o_sta_rw                    <= o_sta_rw_buf;
  o_sta_ack                   <= o_sta_ack_buf;
  o_sta_dat                   <= o_sta_dat_buf;
end RTL;
