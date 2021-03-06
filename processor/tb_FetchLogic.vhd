library IEEE;
use IEEE.std_logic_1164.all;

entity tb_FetchLogic is
  generic(gCLK_HPER   : time := 50 ns;
	N : integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);
end tb_FetchLogic;

architecture behavior of tb_FetchLogic is
  
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component FetchLogic is
  port( i_CLK                       : in std_logic;
	i_IMWE			    : in std_logic;	
        i_RST                       : in std_logic;
	o_Instr			    : out std_logic_vector(N-1 downto 0);
	o_PCADD			    : out std_logic_vector(N-1 downto 0));
end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK  : std_logic;
  signal s_PCADD  : std_logic_vector((32-1) downto 0);
  signal s_INSTR   : std_logic_vector((DATA_WIDTH-1) downto 0);
  signal s_IMWE     : std_logic;
  signal s_RST	  : std_logic;

begin

  FETCH: FetchLogic port map(i_CLK => s_CLK,
           	i_IMWE => s_IMWE,
           	i_RST  => s_RST,
           	o_Instr   => s_INSTR,
           	o_PCADD   => s_PCADD);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
	s_RST <= '1';
	wait for gCLK_HPER;
	s_RST <= '0';	
    s_IMWE     <= '0';

    wait;
  end process;
  
end behavior;