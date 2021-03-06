library IEEE;
use IEEE.std_logic_1164.all;


entity FirstDataPath is
	generic(N : integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

  port( i_CLK                       : in std_logic;
	i_WE			    : in std_logic;	
	i_RS 		            : in std_logic_vector(4 downto 0);
        i_RST                       : in std_logic;
        i_RT 		            : in std_logic_vector(4 downto 0);
	i_RD			    : in std_logic_vector(4 downto 0);	
	i_IMM			    : in std_logic_vector(N-1 downto 0);
	i_WD			    : in std_logic_vector(N-1 downto 0);
        nAdd_Sub	            : in std_logic;
        Alu_Src			    : in std_logic;
	o_RTO			    : out std_logic_vector(N-1 downto 0);
	o_Overflow	            : out std_logic;
	o_ALUout		    : out std_logic_vector(N-1 downto 0));

end FirstDataPath;

architecture structure of FirstDataPath is

component AdderSub_N
  port(i_X 		            :in std_logic_vector(N-1 downto 0);
       i_Y 		            :in std_logic_vector(N-1 downto 0);
     --  i_C 		            : in std_logic;
       Add_Sub	 		    : in std_logic;
       o_C 		            : out std_logic;
       o_B 		            : out std_logic_vector(N-1 downto 0));
	end component;

component RegFile is
  port(i_CLK 	: in std_logic;
       i_WE         : in std_logic;
       i_WRN        : in std_logic_vector(4 downto 0);
       i_RST        : in std_logic;
       i_WD         : in std_logic_vector(31 downto 0);	
       i_RPA	    : in std_logic_vector(4 downto 0);
       i_RPB	    : in std_logic_vector(4 downto 0);
       o_RPA	    : out std_logic_vector(31 downto 0);
       o_RPB 	    : out std_logic_vector(31 downto 0));

end component;

component mux2t1_N is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

signal s_ALURES, S_RT_I : std_logic_vector(31 downto 0);
signal s_RS_A, s_RT_B : std_logic_vector(31 downto 0);
signal s_oC : std_logic;

begin



REGFI: RegFile port map(i_CLK => i_CLK,
	i_WE => i_WE,
       i_WRN  =>  i_RD,
	i_RST =>  i_RST,
       i_WD   =>  i_WD,	
       i_RPA  =>  i_RS,
       i_RPB  =>  i_RT,
       o_RPA  =>  s_RS_A,
       o_RPB  =>  s_RT_B);
	
o_RTO <= s_RT_B;

MUXRTI: mux2t1_N port map(
	i_S => Alu_Src,
	i_D0 => s_RT_B,
	i_D1 => i_IMM,
	o_O  => S_RT_I);

ALUSRC: AdderSub_N port map(
       i_X =>  S_RS_A,
       i_Y =>  S_RT_I,		            		            
       Add_Sub	=> nAdd_Sub, 		   
       o_C 	=> o_Overflow,	            
       o_B 	=> o_ALUout);


  end structure;