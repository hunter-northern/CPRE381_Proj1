-- AdderH.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2 to 1 multiplexor
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity AdderH is

  port(i_X 		            : in std_logic;
       i_Y 		            : in std_logic;
       i_C 		            : in std_logic;
       o_C 		            : out std_logic;
       o_B 		            : out std_logic);

end AdderH;

architecture structure of AdderH is
  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).

component andg2 
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component org2 
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component xorg2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;



  -- Signal to carry stored or input from mux 0 value
  signal xor_0        : std_logic;
  signal or_0        : std_logic;
  -- Signal to carry stored or input from mux 1 value
  signal xor_1       : std_logic;
  signal and_1       : std_logic;
  signal and_2       : std_logic;
  signal and_3       : std_logic;
  signal and_4       : std_logic;
  signal and_5       : std_logic;



begin
--OC structural
 g_And0: andg2
 port MAP(i_A => i_X,
	  i_B => i_Y,
	  o_F => and_1);

 g_And1: andg2
 port MAP(i_A => i_X,
	  i_B => i_C,
	  o_F => and_2);

 g_And2: andg2
 port MAP(i_A => i_Y,
	  i_B => i_C,
	  o_F => and_3);

g_Or0: org2
 port MAP(i_A => and_1,
	  i_B => and_2,
	  o_F => or_0);

g_Or1: org2
 port MAP(i_A => or_0,
	  i_B => and_3,
	  o_F => o_C);

-- OB Structural
 g_And3: andg2
 port MAP(i_A => i_X,
	  i_B => i_Y,
	  o_F => and_4);

 g_And4: andg2
 port MAP(i_A => and_4,
	  i_B => i_C,
	  o_F => and_5);

g_Xor0: xorg2
 port MAP(i_A => i_X,
	  i_B => i_Y,
	  o_F => xor_0);

g_Xor1: xorg2
 port MAP(i_A => xor_0,
	  i_B => i_C,
	  o_F => xor_1);

g_OrOut: org2
port MAP(i_A => and_5,
	 i_B => xor_1,
	 o_F => o_B);	

  end structure;