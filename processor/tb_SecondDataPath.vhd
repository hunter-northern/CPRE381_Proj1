library IEEE;
use IEEE.std_logic_1164.all;

entity tb_SecondDataPath is
  generic(gCLK_HPER   : time := 50 ns;
	        N : integer := 32;
		J : integer := 5;
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10); 
end tb_SecondDataPath;

-- vsim -voptargs="+acc" tb_SecondDataPath

architecture behavior of tb_SecondDataPath is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


component SecondDataPath is
  port( i_CLK                       : in std_logic;
	i_RWE			    : in std_logic;
	i_RS 		            : in std_logic_vector(4 downto 0);
        i_RT 		            : in std_logic_vector(4 downto 0);
	i_RD			    : in std_logic_vector(4 downto 0);	
	i_IMM			    : in std_logic_vector(15 downto 0);
        i_RST                       : in std_logic;
        nAdd_Sub	            : in std_logic;
        Alu_Src			    : in std_logic;
        i_SignS			    : in std_logic;
	i_RegDst		    : in std_logic;
	i_MEMtREG 		    : in std_logic;
	i_MemWriteEn		    : in std_logic;
	o_WRITEDATA		    : out std_logic_vector(N-1 downto 0);	
	o_Overflow	            : out std_logic);

end component;

signal s_CLK, snAdd_Sub, sAlu_Src, s_RST, s_SignS, s_RegDst, s_MEMtREG, s_MemWriteEn : std_logic;
signal s_RD, s_RT, s_RS : std_logic_vector(4 downto 0);
signal s_IMM : std_logic_vector(15 downto 0);
signal s_Over, s_RWE : std_logic;
signal s_WRITEDATA : std_logic_vector(N-1 downto 0);

begin

  DUT_SecondDataPath: SecondDataPath
  port map(i_CLK => s_CLK, 
	   i_RWE => s_RWE,
           i_RS => s_RS,
	   i_RST => s_RST,	
           i_RT  => s_RT,
	   i_IMM => s_IMM,
	   i_RD => s_RD,
	   nAdd_Sub => snAdd_Sub,
	   Alu_Src => sAlu_Src,
	   i_SignS => s_SignS,
	   i_RegDst  => s_RegDst,
	   i_MEMtREG  => s_MEMtREG,
	   i_MemWriteEn => s_MemWriteEn,
	   o_WRITEDATA  =>  s_WRITEDATA,
	   o_Overflow => s_Over);

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
	wait for cClk_PER;
	s_RST <= '0';
		
	s_SignS <= '1';
	s_RWE <= '1';
	
-- addi $25, $0, 0

	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"11001";
	s_IMM <= x"0000";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;

-- addi $26, $0, 256

	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"11010";
	s_IMM <= x"0400";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;

-- lw $1, 0($25)

	s_RS <= "11001";
	s_RT <= "00001";
	s_RD <=	"11001";
	s_IMM <= x"0000";
	s_RegDst <= '0';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

-- lw $2, 4($25)

	s_RS <= "11001";
	s_RT <= "00010";
	s_RD <=	"11010";
	s_IMM <= x"0004";
	s_RegDst <= '0';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

-- add $1, $1, $2

	s_RS <= "00001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0004";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

wait for cClk_PER;

-- sw $1, 0($26)

	s_RWE <= '0';
	s_RS <= "11010";
	s_RT <= "00001";
	s_RD <=	"00001";
	s_IMM <= x"0000";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '1';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

-- lw $2, 8($25)

	s_RWE <= '1';
	s_RS <= "11001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0008";
	s_RegDst <= '0';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

--add $1, $1, $2

	s_RS <= "00001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0004";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

wait for cClk_PER;

-- sw $1, 4($26)
	s_RWE <= '0';
	s_RS <= "11010";
	s_RT <= "00001";
	s_RD <=	"00001";
	s_IMM <= x"0004";
	s_RegDst <= '1';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '1';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

-- lw $2, 12($25)
	s_RWE <= '1';
	s_RS <= "11001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"000C";
	s_RegDst <= '0';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

--add $1, $1, $2

	s_RS <= "00001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0004";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

wait for cClk_PER;

-- sw $1, 8($26)
	s_RWE <= '0';
	s_RS <= "11010";
	s_RT <= "00001";
	s_RD <=	"00001";
	s_IMM <= x"0008";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '1';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

-- lw $2, 16($25)
	s_RWE <= '1';
	s_RS <= "11001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0010";
	s_RegDst <= '0';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

--add $1, $1, $2

	s_RS <= "00001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0004";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

wait for cClk_PER;

-- sw $1, 12($26)
	s_RWE <= '0';
	s_RS <= "11010";
	s_RT <= "00001";
	s_RD <=	"00001";
	s_IMM <= x"000C";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '1';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

-- lw $2, 20($25)
	s_RWE <= '1';
	s_RS <= "11001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0014";
	s_RegDst <= '0';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

--add $1, $1, $2

	s_RS <= "00001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0004";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

wait for cClk_PER;

-- sw $1, 16($26)
	s_RWE <= '0';
	s_RS <= "11010";
	s_RT <= "00001";
	s_RD <=	"00001";
	s_IMM <= x"0010";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '1';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

-- lw $2, 24($25)
	s_RWE <= '1';
	s_RS <= "11001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0018";
	s_RegDst <= '0';
	s_MEMtREG <= '1';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

--add $1, $1, $2

	s_RS <= "00001";
	s_RT <= "00010";
	s_RD <=	"00001";
	s_IMM <= x"0004";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

wait for cClk_PER;

-- addi $27, $0, 512

	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"11011";
	s_IMM <= x"0800";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '0';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;

-- sw $1, -4($27)
	s_RWE <= '0';
	s_RS <= "11011";
	s_RT <= "00001";
	s_RD <=	"00001";
	s_IMM <= x"FFFC";
	s_RegDst <= '1';
	s_MEMtREG <= '0';
	s_MemWriteEn <= '1';
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

wait for cClk_PER;

    wait;
  end process;
  
end behavior;