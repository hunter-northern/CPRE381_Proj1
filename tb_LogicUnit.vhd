library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.textio.all;             -- For basic I/O


entity tb_LogicUnit is
  generic(gCLK_HPER   : time := 10 ns;
		N : integer := 32);   -- Generic for half of the clock cycle period
end tb_LogicUnit;

architecture mixed of tb_LogicUnit is

component LogicUnit
	port 
	(i_PA         : in std_logic_vector(N-1 downto 0);
       	i_PB         : in std_logic_vector(N-1 downto 0);
       	o_AND 		            : out std_logic_vector(N-1 downto 0);
	o_OR 		            : out std_logic_vector(N-1 downto 0);
	o_NOR 		            : out std_logic_vector(N-1 downto 0);
	o_XOR 		            : out std_logic_vector(N-1 downto 0));
end component;

-- TODO: change input and output signals as needed.
signal s_iA   : std_logic_vector(N-1 downto 0);
signal s_iB   : std_logic_vector(N-1 downto 0);
signal s_AND, s_OR, s_XOR, s_NOR   : std_logic_vector(N-1 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: LogicUnit
  port map(i_PA   => s_iA,
            i_PB     => s_iB,
	   o_XOR => s_XOR,
	   o_NOR => s_NOR,
	   o_OR  => s_OR,
           o_AND     => s_AND);


  P_TEST_CASES: process
  begin

    -- Test case 1:
	s_iA <= x"FFFF8000"; 
     	s_iB <= x"0000FFFF";

    wait for gCLK_HPER*2;

    -- Test case 2: 
	s_iA <= x"FFFFFFFF"; 
     	s_iB <= x"FFFFFFFF";

    wait for gCLK_HPER*2;
  
  -- Test case 3: 
   s_iA <= x"FFFFFFFF"; 
   s_iB <= x"00000000";  


    wait for gCLK_HPER*2;

   s_iA <= x"00000001"; 
   s_iB <= x"00000000";  


    wait for gCLK_HPER*2;


  end process;

end mixed;