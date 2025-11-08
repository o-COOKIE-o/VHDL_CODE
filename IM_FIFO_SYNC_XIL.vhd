--Last Update 2025.11.08 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
Library xpm;
use xpm.vcomponents.all;

entity IM_FIFO_SYNC is
  generic (
    WRITE_DATA_WIDTH          : integer range  1 to    4096;
    FIFO_WRITE_DEPTH          : integer range 16 to 4194304;
    PROG_FULL_THRESH          : integer range  3 to 4194301 := 5;
    READ_DATA_WIDTH           : integer range  1 to    4096;
    PROG_EMPTY_THRESH         : integer range  3 to 4194304 := 5;
    FIFO_MEMORY_TYPE          : string := "auto";--"auto", "block", "distributed", "ultra"
    READ_MODE                 : string := "std"--"std", "fwft"
  );
  port (
    wr_en                     : in  std_logic;
    din                       : in  std_logic_vector(WRITE_DATA_WIDTH - 1 downto 0);
    full                      : out std_logic;
    prog_full                 : out std_logic;
    wr_rst_busy               : out std_logic;

    valid                     : out std_logic;
    dout                      : out std_logic_vector(READ_DATA_WIDTH - 1 downto 0);
    rd_en                     : in  std_logic;
    empty                     : out std_logic;
    prog_empty                : out std_logic;
    rd_rst_busy               : out std_logic;

    rst                       : in std_logic;
    clk                       : in std_logic
  );
end IM_FIFO_SYNC;
architecture RTL of IM_FIFO_SYNC is
  function fnc_read_latency (read_mode : string) return integer is
  begin
    if (read_mode = "fwft") then
      return 0;
    else
      return 1;
    end if;
  end function;
begin
  --Refer to UG953 "XPM_FIFO_SYNC"
  u_fifo : xpm_fifo_sync
  generic map (
    DOUT_RESET_VALUE          => "0",
    ECC_MODE                  => "no_ecc",
    FIFO_MEMORY_TYPE          => FIFO_MEMORY_TYPE,
    FIFO_READ_LATENCY         => fnc_read_latency(READ_MODE),
    FIFO_WRITE_DEPTH          => FIFO_WRITE_DEPTH,
    FULL_RESET_VALUE          => 0,
    PROG_EMPTY_THRESH         => PROG_EMPTY_THRESH,
    PROG_FULL_THRESH          => PROG_FULL_THRESH,
    RD_DATA_COUNT_WIDTH       => 1,
    READ_DATA_WIDTH           => READ_DATA_WIDTH,
    READ_MODE                 => READ_MODE,
    SIM_ASSERT_CHK            => 0,
    USE_ADV_FEATURES          => "1202",--prog_full, prog_empty, data_valid:Enable  Others:Disable
    WAKEUP_TIME               => 0,
    WRITE_DATA_WIDTH          => WRITE_DATA_WIDTH,
    WR_DATA_COUNT_WIDTH       => 1
  )
  port map (
    almost_empty              => open,
    almost_full               => open,
    data_valid                => valid,
    dbiterr                   => open,
    dout                      => dout,
    empty                     => empty,
    full                      => full,
    overflow                  => open,
    prog_empty                => prog_empty,
    prog_full                 => prog_full,
    rd_data_count             => open,
    rd_rst_busy               => rd_rst_busy,
    sbiterr                   => open,
    underflow                 => open,
    wr_ack                    => open,
    wr_data_count             => open,
    wr_rst_busy               => wr_rst_busy,
    din                       => din,
    injectdbiterr             => '0',
    injectsbiterr             => '0',
    rd_en                     => rd_en,
    rst                       => rst,
    sleep                     => '0',
    wr_clk                    => clk,
    wr_en                     => wr_en
  );
end RTL;
