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

component PC is 
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLK  :in std_logic;
	i_WE        : in std_logic;
	i_RST 	    : in std_logic;
       i_WD         : in std_logic_vector(31 downto 0);	
       o_InsAdd     : out std_logic_vector(31 downto 0));
end component;

component AdderH_n is 
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_X         : in std_logic_vector(N-1 downto 0);
	i_Y		: in std_logic_vector(N-1 downto 0);
	i_C		: in std_logic;
	o_C		: out std_logic;
       o_B          : out std_logic_vector(N-1 downto 0));


component 

--SecondDatapath
component mux2t1_N is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

component FirstDataPath is

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
BITWIDTH: bitExtension port map(
	i_SignSel => i_SignS,
	i_bit16   => i_IMM,
	o_bit32   => s_BITIMM);

REGMUX: mux2t1_5 port map(i_S => i_RegDst,
       i_D0  => i_RT,
       i_D1  => i_RD,
       o_O   => s_REGDST);

FIRSTDATA: FirstDataPath port map(
	i_CLK => i_CLK,
	i_WE  => i_RWE,	
	i_RST => i_RST,
	i_RS  => i_RS,
        i_RT  => i_RT,
	i_RD  => s_REGDST,	
	i_IMM => s_BITIMM,
	i_WD  => s_MEMoRES,
	nAdd_Sub => nAdd_Sub,
        Alu_Src	 => Alu_Src,
	o_RTO => s_RT_B,
	o_Overflow => o_Overflow,
	o_ALUout  => s_ALUR);

MEMOR:  mem port map(
	clk => i_CLK,
	addr => s_ALUR(11 downto 2),
	data => s_RT_B,
	we   => i_MemWriteEn,
	q    => s_MEMREAD);

MEMUX: mux2t1_N port map(i_S => i_MEMtREG,
       i_D0  => s_ALUR,
       i_D1  => s_MEMREAD,
       o_O   => s_MEMoRES);
	
o_WRITEDATA <= s_MEMoRES;

--end second datapath


  end structure;
