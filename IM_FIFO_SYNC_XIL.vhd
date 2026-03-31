--Last Update 2026.03.31 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
Library xpm;
use xpm.vcomponents.all;

entity IM_FIFO_SYNC is
  generic (
    G_WR_DAT_WIDTH            : integer range  1 to    4096;
    G_WR_DPT                  : integer range 16 to 4194304;
    G_WR_PFL_TH               : integer range  3 to 4194301 := 5;
    G_RD_DAT_WIDTH            : integer range  1 to    4096;
    G_RD_PEM_TH               : integer range  3 to 4194304 := 5;
    G_MEM_TYP                 : integer := 0;--0:"auto", 1:"block", 2:"distributed", 3:"ultra"
    G_RD_FWFT                 : boolean := TRUE
  );
  port (
    i_wr_vld                  : in  std_logic;
    i_wr_dat                  : in  std_logic_vector(G_WR_DAT_WIDTH - 1 downto 0);
    o_wr_ful                  : out std_logic;
    o_wr_pfl                  : out std_logic;
    o_wr_rdy                  : out std_logic;

    o_rd_vld                  : out std_logic;
    o_rd_dat                  : out std_logic_vector(G_RD_DAT_WIDTH - 1 downto 0);
    i_rd_rdy                  : in  std_logic;
    o_rd_emp                  : out std_logic;
    o_rd_pem                  : out std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_FIFO_SYNC;
architecture RTL of IM_FIFO_SYNC is
  function fnc_mem_mode (sel : integer) return string is
  begin
    if    (sel = 1) then
      return "block";
    elsif (sel = 2) then
      return "distributed";
    elsif (sel = 3) then
      return "ultra";
    else
      return "auto";
    end if;
  end function;

  function fnc_rd_ltc (sel : boolean) return integer is
  begin
    if (sel) then
      return 0;
    else
      return 1;
    end if;
  end function;

  function fnc_rd_mode (sel : boolean) return string is
  begin
    if (sel) then
      return "fwft";
    else
      return "std";
    end if;
  end function;

  constant FIFO_MEMORY_TYPE   : string  := fnc_mem_mode(G_MEM_TYP);
  constant FIFO_READ_LATENCY  : integer := fnc_rd_ltc  (G_RD_FWFT);
  constant READ_MODE          : string  := fnc_rd_mode (G_RD_FWFT);

  signal full                 : std_logic := '0';
  signal wr_rst_busy          : std_logic := '0';
begin
  o_wr_ful                    <= full;
  o_wr_rdy                    <= '0' when (wr_rst_busy = '1' or full = '1') else '1';

  --Refer to UG953 "XPM_FIFO_SYNC"
  u_fifo : xpm_fifo_sync
  generic map (
    DOUT_RESET_VALUE          => "0",
    ECC_MODE                  => "no_ecc",
    FIFO_MEMORY_TYPE          => FIFO_MEMORY_TYPE,
    FIFO_READ_LATENCY         => FIFO_READ_LATENCY,
    FIFO_WRITE_DEPTH          => G_WR_DPT,
    FULL_RESET_VALUE          => 0,
    PROG_EMPTY_THRESH         => G_RD_PEM_TH,
    PROG_FULL_THRESH          => G_WR_PFL_TH,
    RD_DATA_COUNT_WIDTH       => 1,
    READ_DATA_WIDTH           => G_RD_DAT_WIDTH,
    READ_MODE                 => READ_MODE,
    SIM_ASSERT_CHK            => 0,
    USE_ADV_FEATURES          => "1202",--prog_full, prog_empty, data_valid:Enable  Others:Disable
    WAKEUP_TIME               => 0,
    WRITE_DATA_WIDTH          => G_WR_DAT_WIDTH,
    WR_DATA_COUNT_WIDTH       => 1
  )
  port map (
    almost_empty              => open,
    almost_full               => open,
    data_valid                => o_rd_vld,
    dbiterr                   => open,
    dout                      => o_rd_dat,
    empty                     => o_rd_emp,
    full                      => full,
    overflow                  => open,
    prog_empty                => o_rd_pem,
    prog_full                 => o_wr_pfl,
    rd_data_count             => open,
    rd_rst_busy               => open,
    sbiterr                   => open,
    underflow                 => open,
    wr_ack                    => open,
    wr_data_count             => open,
    wr_rst_busy               => wr_rst_busy,
    din                       => i_wr_dat,
    injectdbiterr             => '0',
    injectsbiterr             => '0',
    rd_en                     => i_rd_rdy,
    rst                       => i_rst,
    sleep                     => '0',
    wr_clk                    => i_clk,
    wr_en                     => i_wr_vld
  );
end RTL;
