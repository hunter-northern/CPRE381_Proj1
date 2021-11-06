library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.textio.all;             -- For basic I/O

--vsim -voptargs="+acc" tb_mux2t1_N

entity tb_control is
  generic(gCLK_HPER   : time := 10 ns;
		N : integer := 32);   -- Generic for half of the clock cycle period
end tb_control;

architecture mixed of tb_control is

component control
  port(iOP      : in std_logic_vector(5 downto 0);
       iFunc    : in std_logic_vector(5 downto 0);

       oRegDst  : out std_logic;
       oBranch  : out std_logic;
	oJ 	: out std_logic;
       oMemtoReg: out std_logic;
       oALUOp   : out std_logic_vector(2 downto 0);
       oMemWrite: out std_logic;
       oALUSrc  : out std_logic;
	o_ADDSUB : out std_logic;
	o_SHFTDIR : out std_logic;
	o_SHFTTYPE : out std_logic;
	o_LogicChoice : out std_logic_vector(1 downto 0);
	o_Unsigned	: out std_logic; 
       oJr	: out std_logic;
       oJal     : out std_logic;
       oBNE     : out std_logic;
       oRegWrite: out std_logic);
end component;

-- TODO: change input and output signals as needed.

signal s_iOP, s_iFunc : std_logic_vector( 5 downto 0);

signal s_oALUOp   : std_logic_vector(2 downto 0);
signal s_oLogicChoice   : std_logic_vector(1 downto 0);

signal s_oRegDst, s_oBranch, s_oMemtoReg, s_oMemWrite, s_oALUSrc, s_oADDSUB, s_oSHFTDIR : std_logic;
signal s_oSHFTTYPE, s_oJr, s_oJal, s_oBNE, s_oRegWrite, s_Unsigned, sJ : std_logic; 


begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: control
  port map(iOP => s_iOP,
       iFunc	=> s_iFunc,
	
	oRegDst	=> s_oRegDst,
	oBranch	=> s_oBranch,
	oJ	=> sJ,
	oMemtoReg => s_oMemtoReg,
	oMemWrite => s_oMemWrite,
	oALUSrc => s_oALUSrc,
	o_ADDSUB => s_oADDSUB,
	o_SHFTDIR => s_oSHFTDIR,
        o_SHFTTYPE => s_oSHFTTYPE,
	o_Unsigned => s_Unsigned,
	oJr => s_oJr,
	oJal => s_oJal,
	oBNE => s_oBNE,
	oRegWrite => s_oRegWrite,
	oALUOp  => s_oALUOp,
	o_LogicChoice => s_oLogicChoice);


  P_TEST_CASES: process
  begin

    -- Test case 1: Expected ADDI

      	s_iOP <= "001000";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 2: Expected Add

      	s_iOP <= "000000";
      	s_iFunc <= "100000";

    wait for gCLK_HPER*2;

-- Test case 3: Expected Addiu

      	s_iOP <= "001001";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 4: Expected Addu

      	s_iOP <= "000000";
      	s_iFunc <= "100001";

    wait for gCLK_HPER*2;

-- Test case 5: Expected And

      	s_iOP <= "000000";
      	s_iFunc <= "100100";

    wait for gCLK_HPER*2;

-- Test case 6: Expected Andi

      	s_iOP   <= "001100";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 7: Expected Lui

      	s_iOP   <= "001111";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 8: Expected Lw

      	s_iOP   <= "100011";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 9: Expected Nor

      	s_iOP   <= "000000";
      	s_iFunc <= "100111";

    wait for gCLK_HPER*2;

-- Test case 10: Expected Xor

      	s_iOP   <= "000000";
      	s_iFunc <= "100110";

    wait for gCLK_HPER*2;

-- Test case 11: Expected Xori

      	s_iOP   <= "001110";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 12: Expected Or

      	s_iOP   <= "000000";
      	s_iFunc <= "100101";

    wait for gCLK_HPER*2;

-- Test case 13: Expected Ori

      	s_iOP   <= "001101";
      	s_iFunc <= "100101";

    wait for gCLK_HPER*2;


-- Test case 14: Expected slt

      	s_iOP   <= "000000";
      	s_iFunc <= "101010";

    wait for gCLK_HPER*2;

-- Test case 15: Expected slti

      	s_iOP   <= "001010";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 16: Expected sll

      	s_iOP   <= "000000";
      	s_iFunc <= "000000";

    wait for gCLK_HPER*2;

-- Test case 17: Expected srl

      	s_iOP   <= "000000";
      	s_iFunc <= "000010";

    wait for gCLK_HPER*2;

-- Test case 18: Expected sra

      	s_iOP   <= "000000";
      	s_iFunc <= "000011";

    wait for gCLK_HPER*2;

-- Test case 19: Expected sw

      	s_iOP   <= "101011";
      	s_iFunc <= "000011";

    wait for gCLK_HPER*2;

-- Test case 20: Expected sub

      	s_iOP   <= "000000";
      	s_iFunc <= "100010";

    wait for gCLK_HPER*2;

-- Test case 21: Expected subu

      	s_iOP   <= "000000";
      	s_iFunc <= "100011";

    wait for gCLK_HPER*2;

-- Test case 22: Expected beq

      	s_iOP   <= "000100";
      	s_iFunc <= "100010";

    wait for gCLK_HPER*2;

-- Test case 23: Expected bne

      	s_iOP   <= "000101";
      	s_iFunc <= "100010";

    wait for gCLK_HPER*2;

-- Test case 24: Expected j

      	s_iOP   <= "000010";
      	s_iFunc <= "100010";

    wait for gCLK_HPER*2;

-- Test case 25: Expected jal

      	s_iOP   <= "000011";
      	s_iFunc <= "100010";

    wait for gCLK_HPER*2;

-- Test case 26: Expected jal

      	s_iOP   <= "000000";
      	s_iFunc <= "001000";

    wait for gCLK_HPER*2;

-- Test case 27: Expected repl.qb

      	s_iOP   <= "011111";
      	s_iFunc <= "001000";

    wait for gCLK_HPER*2;

  end process;

end mixed;