
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.textio.all;             -- For basic I/O


entity tb_bitExtension is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_bitExtension;

architecture mixed of tb_bitExtension is

component bitExtension
	port 
	(	i_SignSel	: in std_logic;
		i_bit16		: in std_logic_vector(15 downto 0);
		o_bit32	        : out std_logic_vector(31 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
--signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_iB16   : std_logic_vector(15 downto 0);
signal s_oB32   : std_logic_vector(31 downto 0);
signal s_SignChoice   : std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: bitExtension
  port map(i_SignSel   => s_SignChoice,
            i_bit16     => s_iB16,
            o_bit32     => s_oB32);


  P_TEST_CASES: process
  begin

    -- Test case 1:
	s_SignChoice <= '0'; 
     	s_iB16 <= x"F00F";

    wait for gCLK_HPER*2;

    -- Test case 2: 
    s_SignChoice <= '1';	
    s_iB16   <= x"F00F";  

    wait for gCLK_HPER*2;

    -- Test case 3: 
    s_SignChoice <= '1';	
    s_iB16   <= x"78CF";  


    wait for gCLK_HPER*2;


  end process;

end mixed;