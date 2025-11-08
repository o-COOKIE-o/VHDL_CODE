--Last Update 2025.11.08 by COOKIE
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
library IM_LIB;
use IM_LIB.typ.all;

entity IM_HUB_AXI4S32_MPX is
  generic (
    G_CH                      : integer
  );
  port (
    i_axis_tdata              : in  slv32_vector    (G_CH - 1 downto 0);
    i_axis_tstrb              : in  slv4_vector     (G_CH - 1 downto 0);
    i_axis_tlast              : in  std_logic_vector(G_CH - 1 downto 0);
    i_axis_tvalid             : in  std_logic_vector(G_CH - 1 downto 0);
    o_axis_tready             : out std_logic_vector(G_CH - 1 downto 0);

    o_axis_tdata              : out std_logic_vector(31 downto 0);
    o_axis_tstrb              : out std_logic_vector( 3 downto 0);
    o_axis_tlast              : out std_logic;
    o_axis_tvalid             : out std_logic;
    i_axis_tready             : in  std_logic;

    i_rst                     : in  std_logic;
    i_clk                     : in  std_logic
  );
end IM_HUB_AXI4S32_MPX;
architecture RTL of IM_HUB_AXI4S32_MPX is
  constant ARR_CNT            : integer := G_CH - 1;

  signal trs_out              : boolean := FALSE;
  signal mpx_sel              : integer range 0 to ARR_CNT := 0;
  signal mpx_sel_lat          : integer range 0 to ARR_CNT := ARR_CNT;
  signal mpx_sel_unlock       : boolean := TRUE;
  signal o_axis_tready_buf    : std_logic_vector(ARR_CNT downto 0) := (others => '0');
  signal o_axis_tdata_buf     : std_logic_vector(o_axis_tdata'range) := (others => '0');
  signal o_axis_tstrb_buf     : std_logic_vector(o_axis_tstrb'range) := (others => '0');
  signal o_axis_tlast_buf     : std_logic := '0';
  signal o_axis_tvalid_buf    : std_logic := '0';
begin
  o_axis_tready               <= o_axis_tready_buf;

  g_tready : for L in o_axis_tready_buf'range generate
    o_axis_tready_buf(L)      <= i_axis_tready when (mpx_sel = L) else '0';
  end generate;

  trs_out                     <= o_axis_tvalid_buf = '1' and i_axis_tready = '1';

  process (i_axis_tvalid, mpx_sel_lat, mpx_sel_unlock)
  begin
    mpx_sel                   <= mpx_sel_lat;
    if    (mpx_sel_unlock) then
      for L in ARR_CNT downto 0 loop
        if    (i_axis_tvalid(L) = '1') then
          mpx_sel             <= L;
        end if;
      end loop;

      for L in ARR_CNT downto 0 loop
        if (L > mpx_sel_lat) then
          if    (i_axis_tvalid(L) = '1') then
            mpx_sel           <= L;
          end if;
        end if;
      end loop;
    end if;
  end process;

  process (i_clk)
  begin
  if (i_clk'event and i_clk = '1') then
    if    (trs_out) then
      if    (o_axis_tlast_buf = '0') then
        mpx_sel_lat           <= mpx_sel;
        mpx_sel_unlock        <= FALSE;
      else
        if    (mpx_sel_unlock) then
          mpx_sel_lat         <= mpx_sel;
        end if;
        mpx_sel_unlock        <= TRUE;
      end if;
    end if;

    if    (i_rst = '1') then
      mpx_sel_lat             <= ARR_CNT;
      mpx_sel_unlock          <= TRUE;
    end if;
  end if;
  end process;
  o_axis_tdata_buf            <= i_axis_tdata (mpx_sel);
  o_axis_tstrb_buf            <= i_axis_tstrb (mpx_sel);
  o_axis_tlast_buf            <= i_axis_tlast (mpx_sel);
  o_axis_tvalid_buf           <= i_axis_tvalid(mpx_sel);

  o_axis_tdata                <= o_axis_tdata_buf;
  o_axis_tstrb                <= o_axis_tstrb_buf;
  o_axis_tlast                <= o_axis_tlast_buf;
  o_axis_tvalid               <= o_axis_tvalid_buf;
end RTL;
