library IEEE;
use IEEE.std_logic_1164.all;


entity FetchLogic is
	generic(N : integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

  port( i_CLK                       : in std_logic;
	i_IMWE			    : in std_logic;	
        i_RST                       : in std_logic;
	o_Instr			    : out std_logic_vector(N-1 downto 0);
	o_PCADD			    : out std_logic_vector(N-1 downto 0));

end FetchLogic;

architecture structure of FetchLogic is

component AdderH_n is
 -- generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_X         	: in std_logic_vector(N-1 downto 0);
	i_Y		: in std_logic_vector(N-1 downto 0);
	i_C		: in std_logic;
	o_C	    	: out std_logic;
       	o_B          	: out std_logic_vector(N-1 downto 0));

end component;

component mem is
	port 
	(	clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

component PC is
  port(	i_CLK  :in std_logic;
	i_WE        : in std_logic;
	i_RST 	    : in std_logic;
       	i_WD         : in std_logic_vector(31 downto 0);	
       	o_InsAdd     : out std_logic_vector(31 downto 0));

end component;

signal s_PCADD, S_READDR, s_MEMDATA : std_logic_vector(31 downto 0);
--signal s_RS_A,  : std_logic_vector(31 downto 0);
signal s_oC : std_logic;


begin



PC1: PC port map(
	i_CLK  => i_CLK,
	i_WE   => '1',
	i_RST  => i_RST,
       	i_WD   => s_PCADD,	
       	o_InsAdd => s_READDR);
	

PCADD1: AdderH_N port map(
	i_X  => s_READDR,
	i_Y  => x"00000004",
	i_C  => '0',
	o_C  => s_oC, 
       	o_B  => s_PCADD);

INSTMEM1: mem port map(
		clk => i_CLK,
		addr => s_READDR(11 downto 2),
		data => x"00000000",
		we  => i_IMWE,
		q  => o_Instr
);
o_PCADD <= s_PCADD;


  end structure;