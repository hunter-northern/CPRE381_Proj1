library IEEE;
use IEEE.std_logic_1164.all;


entity MIPSProcessor is
	generic(N : integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10;
	J : integer := 5);

  port( i_CLK            : in std_logic;
	i_IMWE            : in std_logic;
	i_RST		 : in std_logic;
	o_OverFlow	: out std_logic);

end MIPSProcessor;

architecture structure of MIPSProcessor is

component control is
  port(iOP      : in std_logic_vector(5 downto 0);
       iFunc    : in std_logic_vector(5 downto 0);
       oRegDst  : out std_logic; --done
	oJ	: out std_logic; -- done
       oBranch  : out std_logic; --done
       oMemtoReg: out std_logic; --done
       oALUOp   : out std_logic_vector(2 downto 0); --done
       oMemWrite: out std_logic; --done 
       oALUSrc  : out std_logic; --done
	o_ADDSUB : out std_logic; --done
	o_SHFTDIR : out std_logic; --done
	o_SHFTTYPE : out std_logic; --done
	o_LogicChoice : out std_logic_vector(1 downto 0); --done
	o_Unsigned : out std_logic;
       oJr	: out std_logic; --done
       oJal     : out std_logic; --done
       oBNE     : out std_logic; --done
       oRegWrite: out std_logic); --done

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

component ALU is
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


component mux2t1_N is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
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

component mux2t1_5 is
  -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(J-1 downto 0);
       i_D1         : in std_logic_vector(J-1 downto 0);
       o_O          : out std_logic_vector(J-1 downto 0));

end component;

component FetchLogic is
port( i_CLK                       : in std_logic;
	i_IMWE			    : in std_logic;	
        i_RST                       : in std_logic;
	i_Branch		    : in std_logic;
	i_BNE			    : in std_logic;
	i_Jal			    : in std_logic;
	i_ZERO			    : in std_logic;
	i_Jr			    : in std_logic;
	i_J			    : in std_logic;
	i_WRITEDST		    : in std_logic_vector(4 downto 0);
	i_JumpAddr		    : in std_logic_vector(25 downto 0);
	i_BranchImmAddr		    : in std_logic_vector(31 downto 0);
	i_WriteData		    : in std_logic_vector(31 downto 0);
	i_RS			    : in std_logic_vector(31 downto 0);
	o_WRITEDST		    : out std_logic_vector(4 downto 0);
	o_JaloDataWrite		    : out std_logic_vector(31 downto 0);
	o_InstrAddr			: out std_logic_vector(N-1 downto 0));

end component;


signal s_ALURES, S_RT_I : std_logic_vector(31 downto 0);
signal s_RS_A, s_RT_B, s_IMM : std_logic_vector(31 downto 0);
signal s_oC, s_Branch, s_BNE, s_J, s_Jal, s_ZERO, s_Jr, s_RegDst, s_oMemtoReg, s_oMemWriteE, s_ALUSrc : std_logic;
signal s_ADDSUB, s_SHFTDIR, s_SHFTTYPE, s_Unsigned, s_RegWrEn : std_logic;

signal s_iWRITEDST, s_oWRITEDST, s_RToRD : std_logic_vector(4 downto 0);
signal s_iJumpAddr : std_logic_vector(25 downto 0);
signal s_ALUWriteData, s_JaloALUWrite, s_InstrAddr, s_MEMOUT : std_logic_vector(31 downto 0); 
signal s_ALUOp : std_logic_vector(2 downto 0);
signal s_LogicChoice : std_logic_vector(1 downto 0);
begin

FETCH1: FetchLogic
port map( i_CLK   => i_CLK,       
	i_IMWE	=> i_IMWE,
        i_RST   => i_RST,    
	i_Branch => s_Branch,
	i_BNE	=> s_BNE,	
	i_Jal	=> s_Jal,	
	i_ZERO	=> s_ZERO,	
	i_Jr	=> s_Jr,	
	i_J	=> s_J,
	i_WRITEDST => s_RToRD,	
	i_JumpAddr => s_Instruction(25 downto 0),
	i_BranchImmAddr	=> s_Imm,	
	i_WriteData => s_ALUWriteData,	
	i_RS	=> s_RS_A,	
	o_WRITEDST => s_oWRITEDST,	
	o_JaloDataWrite	=> s_JaloALUWrite,
	o_InstrAddr =>   s_InstrAddr);

CONTROL1: control port map(
	iOP  => s_Instruction(31 downto 26),
       iFunc => s_Instruction(5 downto 0),
       oRegDst => s_RegDst,
	oJ    => s_J,
       oBranch => s_Branch,
       oMemtoReg => s_oMemtoReg,
       oALUOp  => s_ALUOp,
       oMemWrite => s_oMemWriteE, 
       oALUSrc => s_ALUSrc,
	o_ADDSUB => s_ADDSUB,
	o_SHFTDIR => s_SHFTDIR, 
	o_SHFTTYPE => s_SHFTTYPE,
	o_LogicChoice => s_LogicChoice,
	o_Unsigned => s_Unsigned,
       oJr => s_Jr,
       oJal  => s_Jal,
       oBNE  => s_BNE,
       oRegWrite => s_RegWrEn);

MUXRD: mux2t1_N port map(
	i_S => s_RegDst,
	i_D0 => s_Instruction(20 downto 16),
	i_D1 => s_Instruction(15 downto 11),
	o_O  => s_RToRD);

REGFI: RegFile port map(i_CLK => i_CLK,
	i_WE => s_RegWrEn,
       i_WRN  =>  s_oWRITEDST,
	i_RST =>  i_RST,
       i_WD   =>  s_JaloALUWrite,	
       i_RPA  =>  s_Instruction(25 downto 21),
       i_RPB  =>  s_Instruction(20 downto 16),
       o_RPA  =>  s_RS_A,
       o_RPB  =>  s_RT_B);

BITIMM: bitExtension
 port map(i_SignSel => '1',
	i_bit16	=> s_Instruction(15 downto 0),
	o_bit32	=> s_IMM);	

MUXRTI: mux2t1_N port map(
	i_S => s_ALUSrc,
	i_D0 => s_RT_B,
	i_D1 => s_IMM,
	o_O  => S_RT_I);

ALU1 : ALU port map(i_PA => s_RS_A,
       i_PBoIMM	 => s_RT_I,
	i_SHAMT	 => s_Instruction(10 downto 6),
	i_ALUOP	 => s_ALUOp,
	i_ShftDIR => s_SHFTDIR,
	i_LogicCtrl => s_LogicChoice,
	i_AddSub => s_ADDSUB,
	i_ShftTYP => s_SHFTTYPE,
	i_Unsign => s_Unsigned,
        o_ALURES => s_ALURES,
	o_OvrFlw => o_OverFlow,
	o_ZERO 	 => s_ZERO);

DATAMEM1: mem port map(
	clk => i_CLK,
	addr => s_ALURES,
	data => s_RT_B,
	we => s_oMemWriteE,
	q => s_MEMOUT);

MUXMEMOALU: mux2t1_N port map(
	i_S => s_oMemtoReg,
	i_D0 => s_ALURES,
	i_D1 => s_MEMOUT,
	o_O  => S_ALUWriteData);

  end structure;