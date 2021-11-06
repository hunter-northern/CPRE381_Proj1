library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.textio.all;             -- For basic I/O


entity tb_ALU is
  generic(gCLK_HPER   : time := 10 ns;
		N : integer := 32);   -- Generic for half of the clock cycle period
end tb_ALU;

architecture mixed of tb_ALU is

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

-- TODO: change input and output signals as needed.
signal s_iPA   : std_logic_vector(N-1 downto 0);
signal s_iPBoIMM, s_oALURES   : std_logic_vector(N-1 downto 0);
signal s_iAddSub, s_iShftTYP, s_iShftDIR, s_iUnsign, s_oOvrFlw, s_oZERO : std_logic;
signal s_iSHAMT : std_logic_vector( 4 downto 0);
signal s_iALUOP : std_logic_vector(2 downto 0);
signal s_iLogicCtrl : std_logic_vector(1 downto 0); 


begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: ALU
  port map(i_PA => s_iPA,
       i_PBoIMM	=> s_iPBoIMM,
	i_SHAMT	=> s_iSHAMT,
	i_ALUOP	=> s_iALUOP,
	i_ShftDIR => s_iShftDIR,
	i_LogicCtrl => s_iLogicCtrl,
	i_AddSub => s_iAddSub,
	i_ShftTYP => s_iShftTYP,
	i_Unsign => s_iUnsign,
        o_ALURES => s_oALURES,
	o_OvrFlw => s_oOvrFlw,
	o_ZERO 	=> s_oZERO);


  P_TEST_CASES: process
  begin

    -- Test case 1: Expected Shift PB1 Left 3 bits

      	s_iPA <= x"00FFFFFF";
      	s_iPBoIMM <= x"000C8421";
	s_iSHAMT <= "00011";
	s_iALUOP <= "000";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

-- Test case 2: Expected Shift PB1 Right 3 bits Logically

      	s_iPA <= x"00FFFFFF";
      	s_iPBoIMM <= x"80FC8421";
	s_iSHAMT <= "00011";
	s_iALUOP <= "000";
	s_iShftDIR <= '0';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 3: Expected Shift PB1 Right 3 bits Arithmetically

      	s_iPA <= x"00FFFFFF";
      	s_iPBoIMM <= x"8F0C8421";
	s_iSHAMT <= "00011";
	s_iALUOP <= "000";
	s_iShftDIR <= '0';
	s_iShftTYP <= '1';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 4: Expected SLT TRUE so 0x00000001

      	s_iPA <= x"0000FFFF";
      	s_iPBoIMM <= x"000C8421";
	s_iSHAMT <= "00011";
	s_iALUOP <= "001";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 5: Expected SLT FALSE so 0x00000000

      	s_iPA <= x"000FFFFF";
      	s_iPBoIMM <= x"000C8421";
	s_iSHAMT <= "00011";
	s_iALUOP <= "001";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;


    -- Test case 6: Expected SLT FALSE so 0x00000000

      	s_iPA <= x"FFFFFFFE";
      	s_iPBoIMM <= x"00000001";
	s_iSHAMT <= "00011";
	s_iALUOP <= "001";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 7: Expected ADD with overflow / signed

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"00000001";
	s_iSHAMT <= "00011";
	s_iALUOP <= "010";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '0';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 8: Expected ADD with no overflow / unsigned

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"00000001";
	s_iSHAMT <= "00011";
	s_iALUOP <= "010";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '0';
	s_iUnsign <= '1';

    wait for gCLK_HPER*2;


    -- Test case 9: Expected SUB

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"01111111";
	s_iSHAMT <= "00011";
	s_iALUOP <= "010";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 10: Expected AND

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"01111111";
	s_iSHAMT <= "00011";
	s_iALUOP <= "011";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "00";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 11: Expected OR

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"01111111";
	s_iSHAMT <= "00011";
	s_iALUOP <= "011";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "01";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 12: Expected NOR

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"01111111";
	s_iSHAMT <= "00011";
	s_iALUOP <= "011";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "10";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;


    -- Test case 13: Expected XOR

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"01111111";
	s_iSHAMT <= "00011";
	s_iALUOP <= "011";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "11";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 14: Expected LUI

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"0111ABCD";
	s_iSHAMT <= "00011";
	s_iALUOP <= "100";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "11";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;

    -- Test case 15: Expected REPLQB

      	s_iPA <= x"7FFFFFFF";
      	s_iPBoIMM <= x"0111ABCD";
	s_iSHAMT <= "00011";
	s_iALUOP <= "101";
	s_iShftDIR <= '1';
	s_iShftTYP <= '0';
	s_iLogicCtrl <= "11";
	s_iAddSub <= '1';
	s_iUnsign <= '0';

    wait for gCLK_HPER*2;


  end process;

end mixed;