-- AdderH.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2 to 1 multiplexor
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

--vsim -voptargs="+acc" tb_mux2t1_N
entity AdderSub_N is
	generic(N : integer := 32);

  port(i_X 		            :in std_logic_vector(N-1 downto 0);
       i_Y 		            :in std_logic_vector(N-1 downto 0);
       Add_Sub	 		    : in std_logic;
       o_C 		            : out std_logic;
       o_B 		            : out std_logic_vector(N-1 downto 0));

end AdderSub_N;

architecture structure of AdderSub_N is
  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).

component AdderH 
  --generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_X         : in std_logic;
	i_Y		: in std_logic;
	i_C		: in std_logic;
	o_C		: out std_logic;
       o_B          : out std_logic);

end component;

component AdderH_N
  --generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_X         : in std_logic_vector(N-1 downto 0);
	i_Y		: in std_logic_vector(N-1 downto 0);
	i_C		: in std_logic;
	o_C		: out std_logic;
       o_B          : out std_logic_vector(N-1 downto 0));

end component;

component mux2t1_N 
--generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

component OnesComp 
 --generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A         : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;



  -- Signal to carry stored or input from mux 0 value

  signal notY       : std_logic_vector(N-1 downto 0);
  signal MuxVal       : std_logic_vector(N-1 downto 0);
signal carry :  std_logic_vector(N-1 downto 0);


begin
--OC structural
   OnesCompY: OnesComp port map(i_A => i_Y,
				o_F => notY);

MUX2T1N: mux2t1_N port map(
	i_S => Add_Sub,
       i_D0 => i_Y,
       i_D1 => notY, 
       o_O => MuxVal);

ADDH: AdderH_N port map(i_X     => i_X,  -- ith instance's data 1 input hooked up to ith data 1 input.
              		i_Y     => MuxVal,
			i_C     => Add_Sub,
			o_B     => o_B,
                       o_C      => o_C);  -- ith instance's data output hooked up to ith data output.
-- ith instance's data output hooked up to ith data output.

  end structure;
















