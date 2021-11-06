library IEEE;
use IEEE.std_logic_1164.all;


entity ALUDatapath is
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
        i_AluCtl  	            : in std_logic_vector(2 downto 0);
        i_nAddSub	            : in std_logic;
	--alu
        i_Shft		            : in std_logic;
	i_LogicCtrl		    : in std_logic_vector(1 downto 0);
	i_ShftDIR		    : in std_logic;
	i_SHAMT			    : in std_logic_vector(4 downto 0);
	i_Unsign		    : in std_logic;
	o_ZERO			    : out std_logic;
        --end alu
	o_RTO			    : out std_logic_vector(N-1 downto 0);
	o_Overflow	            : out std_logic;
	o_AluOut		    : out std_logic_vector(N-1 downto 0));

end ALUDatapath;

architecture structure of ALUdatapath is

component ALU
  port(i_PA 		            : in std_logic_vector(N-1 downto 0);
       i_PBoIMM		            : in std_logic_vector(N-1 downto 0);
	i_SHAMT			    : in std_logic_vector(4 downto 0);
	i_ALUOP			    : in std_logic_vector(2 downto 0);
	i_ShftDIR		    : in std_logic;
	i_LogicCtrl		    : in std_logic_vector(1 downto 0);
	i_AddSub		    : in std_logic;
	i_ShftTYP		    : in std_logic;
	i_Unsign		    : in std_logic;
        o_ALURES 		    : out std_logic_vector(N-1 downto 0);
	o_OvrFlw 	            : out std_logic;
	o_ZERO 		            : out std_logic);
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

signal s_ALURES, s_RT_I : std_logic_vector(31 downto 0);
signal s_RS_A, s_RT_B : std_logic_vector(31 downto 0);
signal s_oC : std_logic;

begin

ALUI: ALU 
    port map(
	i_PA        => s_RS_A,
	i_PBoIMM    => s_RT_I,
	i_SHAMT     => i_SHAMT,
	i_ALUOP     => i_ALUCtrl, --something needs to change, two different sizes
	i_ShftDIR   => i_ShftDIR,
	i_LogicCtrl => i_LogicCtrl,
	i_AddSub    => i_nAddSub,
	i_ShftTYP   => i_Shft,
	i_Unsign    => i_Unsign,
        o_ALURES    => o_AluOut,
	o_OvrFlw    => o_Overflow,
	o_ZERO      => o_ZERO);


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
	o_O  => s_RT_I);


  end structure;
