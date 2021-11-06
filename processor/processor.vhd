library IEEE;
use IEEE.std_logic_1164.all;


entity processor is
	generic(N : integer := 32;
		J : integer := 5;
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10);

  port( i_CLK                       : in std_logic;
        i_RST                       : in std_logic;
	i_RS 		            : in std_logic_vector(4 downto 0);
        i_RT 		            : in std_logic_vector(4 downto 0);
	i_RD			    : in std_logic_vector(4 downto 0);	
	i_IMM			    : in std_logic_vector(15 downto 0);
        nAdd_Sub	            : in std_logic;
        Alu_Src			    : in std_logic;
        i_SignS			    : in std_logic;
	i_RegDst		    : in std_logic;
	i_MEMtREG 		    : in std_logic;
	i_MemWriteEn		    : in std_logic;
	i_RWE			    : in std_logic;
	o_WRITEDATA		    : out std_logic_vector(N-1 downto 0);	
	o_Overflow	            : out std_logic);

end processor;

architecture structure of SecondDataPath is

component control
  port(iOP      : in std_logic_vector(5 downto 0);
       iFunc    : in std_logic_vector(5 downto 0);
       oRegDst  : out std_logic;
       oBranch  : out std_logic;
       oMemtoReg: out std_logic;
       oALUOp   : out std_logic_vector(3 downto 0);
       oMemWrite: out std_logic;
       oALUSrc  : out std_logic;
       oRegWrite: out std_logic);
end component;



component AdderH_n is 
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_X         : in std_logic_vector(N-1 downto 0);
	i_Y		: in std_logic_vector(N-1 downto 0);
	i_C		: in std_logic;
	o_C		: out std_logic;
       o_B          : out std_logic_vector(N-1 downto 0));
end component 

--SecondDatapath
component mux2t1_N is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

component FetchLogic is
	generic(N : integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

  port( i_CLK                       : in std_logic;
	i_IMWE			    : in std_logic;	
        i_RST                       : in std_logic;
	o_Instr			    : out std_logic_vector(N-1 downto 0);
	o_PCADD			    : out std_logic_vector(N-1 downto 0));
end component

component regData is
  generic(N : integer := 32;
	  J : integer := 5;
	  DATA_WIDTH : natural := 32;
	  ADDR_WIDTH : natural := 10);
  port( 
        i_CLK                       : in std_logic;
        i_RST                       : in std_logic;
	i_RS 		            : in std_logic_vector(4 downto 0);
        i_RT 		            : in std_logic_vector(4 downto 0);
	i_RD			    : in std_logic_vector(4 downto 0);	
	i_IMM			    : in std_logic_vector(15 downto 0);
        Alu_Ctrl	            : in std_logic_vector(4 downto 0);
        Alu_Src			    : in std_logic;
        i_SignS			    : in std_logic;
	i_RegDst		    : in std_logic;
	i_MEMtREG 		    : in std_logic;
	i_MemWriteEn		    : in std_logic;
	i_RWE			    : in std_logic;
	o_WRITEDATA		    : out std_logic_vector(N-1 downto 0);	
	o_Overflow	            : out std_logic);
end component;

component mux2t1_5 is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(J-1 downto 0);
       i_D1         : in std_logic_vector(J-1 downto 0);
       o_O          : out std_logic_vector(J-1 downto 0));

end component;

component bitExtension is
	port(  i_SignSel	: in std_logic;
		i_bit16		: in std_logic_vector(15 downto 0);
		o_bit32	        : out std_logic_vector(31 downto 0));
end component;

component mem is
	port 
	(
	clk		: in std_logic;
	addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
	data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
	we		: in std_logic := '1';
	q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end component;

--end SecondDatapath components 


signal s_ALUR, s_BITIMM : std_logic_vector(31 downto 0);
signal s_MEMREAD, s_RT_B, s_MEMoRES : std_logic_vector(31 downto 0);
signal s_REGDST : std_logic_vector(4 downto 0);
signal s_oC : std_logic;

begin
--second datapath


--end second datapath


  end structure;
