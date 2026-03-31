--Last Update 2026.03.31 by COOKIE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity IM_BRG_AXI4S_GPIO is
  generic (
    G_DAT_WIDTH               : integer;
    G_ADR_WIDTH               : integer
  );
  port (
    --Address Control
    i_adr_base_gpi            : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_adr_mask_gpi            : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);

    i_adr_base_gpo            : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_adr_mask_gpo            : in  std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    --Read Return
    o_axis_tdata              : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_axis_tstrb              : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;
    --Write Access and Read Request
    i_axis_tdata              : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_axis_tstrb              : in  std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);--UnUsed
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;
    --Read address and data port
    o_gpi_vld                 : out std_logic;
    o_gpi_adr                 : out std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    i_gpi_dat                 : in  std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    i_gpi_rdy                 : in  std_logic;
    --Write address and data port
    o_gpo_vld                 : out std_logic;
    o_gpo_adr                 : out std_logic_vector(G_ADR_WIDTH - 1 downto 0);
    o_gpo_dat                 : out std_logic_vector(G_DAT_WIDTH - 1 downto 0);
    o_gpo_stb                 : out std_logic_vector((G_DAT_WIDTH - 1) / 8 downto 0);
    i_gpo_rdy                 : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_BRG_AXI4S_GPIO;
architecture RTL of IM_BRG_AXI4S_GPIO is
  component IM_BRG_AXI4S_GPI
  generic (
    G_DAT_WIDTH               : integer;
    G_ADR_WIDTH               : integer
  );
  port (
    --Address Control
    i_adr_base                : in  std_logic_vector;
    i_adr_mask                : in  std_logic_vector;
    --Read Return
    o_axis_tdata              : out std_logic_vector;
    o_axis_tstrb              : out std_logic_vector;
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;
    --Read Request
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

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
  end component;

  component IM_BRG_AXI4S_GPO
  generic (
    G_DAT_WIDTH               : integer;
    G_ADR_WIDTH               : integer
  );
  port (
    --Address Control
    i_adr_base                : in  std_logic_vector;
    i_adr_mask                : in  std_logic_vector;
    --Write Access
    i_axis_tdata              : in  std_logic_vector;
    i_axis_tstrb              : in  std_logic_vector;
    i_axis_tlast              : in  std_logic;
    i_axis_tvalid             : in  std_logic;
    o_axis_tready             : out std_logic;
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

  signal o_axis_tready_buf    : std_logic := '0';
  signal tvalid               : std_logic := '0';
  signal gpi_tready           : std_logic := '0';
  signal gpo_tready           : std_logic := '0';
begin
  o_axis_tready_buf           <= gpi_tready and gpo_tready;
  o_axis_tready               <= o_axis_tready_buf;

  tvalid                      <= i_axis_tvalid and o_axis_tready_buf;

  u_gpi : IM_BRG_AXI4S_GPI
  generic map(
    G_DAT_WIDTH               => G_DAT_WIDTH,
    G_ADR_WIDTH               => G_ADR_WIDTH
  )
  port map(
    i_adr_base                => i_adr_base_gpi,
    i_adr_mask                => i_adr_mask_gpi,

    o_axis_tdata              => o_axis_tdata,
    o_axis_tstrb              => o_axis_tstrb,
    o_axis_tlast              => o_axis_tlast,
    o_axis_tvalid             => o_axis_tvalid,
    i_axis_tready             => i_axis_tready,

    i_axis_tdata              => i_axis_tdata,
    i_axis_tstrb              => i_axis_tstrb,
    i_axis_tlast              => i_axis_tlast,
    i_axis_tvalid             => tvalid,
    o_axis_tready             => gpi_tready,

    o_gpi_vld                 => o_gpi_vld,
    o_gpi_adr                 => o_gpi_adr,
    i_gpi_dat                 => i_gpi_dat,
    i_gpi_rdy                 => i_gpi_rdy,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );

  u_gpo : IM_BRG_AXI4S_GPO
  generic map(
    G_DAT_WIDTH               => G_DAT_WIDTH,
    G_ADR_WIDTH               => G_ADR_WIDTH
  )
  port map(
    i_adr_base                => i_adr_base_gpo,
    i_adr_mask                => i_adr_mask_gpo,

    i_axis_tdata              => i_axis_tdata,
    i_axis_tstrb              => i_axis_tstrb,
    i_axis_tlast              => i_axis_tlast,
    i_axis_tvalid             => tvalid,
    o_axis_tready             => gpo_tready,

    o_gpo_vld                 => o_gpo_vld,
    o_gpo_adr                 => o_gpo_adr,
    o_gpo_dat                 => o_gpo_dat,
    o_gpo_stb                 => o_gpo_stb,
    i_gpo_rdy                 => i_gpo_rdy,

    i_rst                     => i_rst,
    i_clk                     => i_clk
  );
end RTL;
