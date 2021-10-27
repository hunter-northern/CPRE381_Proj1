
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux32t1 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_mux32t1;

architecture behavior of tb_mux32t1 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component mux32t1
    port(i_S   	: in std_logic_vector(4 downto 0);
	i_R00 : in std_logic_vector(31 downto 0);
	i_R01 : in std_logic_vector(31 downto 0);
	i_R02 : in std_logic_vector(31 downto 0);
	i_R03 : in std_logic_vector(31 downto 0);
	i_R04 : in std_logic_vector(31 downto 0);
	i_R05 : in std_logic_vector(31 downto 0);
	i_R06 : in std_logic_vector(31 downto 0);
	i_R07 : in std_logic_vector(31 downto 0);
	i_R08 : in std_logic_vector(31 downto 0);
	i_R09 : in std_logic_vector(31 downto 0);
	i_R0A : in std_logic_vector(31 downto 0);
	i_R0B : in std_logic_vector(31 downto 0);
	i_R0C : in std_logic_vector(31 downto 0);
	i_R0D : in std_logic_vector(31 downto 0);
	i_R0E : in std_logic_vector(31 downto 0);
	i_R0F : in std_logic_vector(31 downto 0);
	i_R10 : in std_logic_vector(31 downto 0);
	i_R11 : in std_logic_vector(31 downto 0);
	i_R12 : in std_logic_vector(31 downto 0);
	i_R13 : in std_logic_vector(31 downto 0);
	i_R14 : in std_logic_vector(31 downto 0);
	i_R15 : in std_logic_vector(31 downto 0);
	i_R16 : in std_logic_vector(31 downto 0);
	i_R17 : in std_logic_vector(31 downto 0);
	i_R18 : in std_logic_vector(31 downto 0);
	i_R19 : in std_logic_vector(31 downto 0);
	i_R1A : in std_logic_vector(31 downto 0);
	i_R1B : in std_logic_vector(31 downto 0);
	i_R1C : in std_logic_vector(31 downto 0);
	i_R1D : in std_logic_vector(31 downto 0);
	i_R1E : in std_logic_vector(31 downto 0);
	i_R1F : in std_logic_vector(31 downto 0);
         o_Y       : out std_logic_vector(31 downto 0));   -- Data value output
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK  : std_logic;
  signal s_R00, s_R01, s_R02, s_R03, s_R04, s_R05, s_R06, s_R07, s_R08 : std_logic_vector(31 downto 0);
  signal s_R09, s_R0A, s_R0B, s_R0C, s_R0D, s_R0E, s_R0F, s_R10, s_R11 : std_logic_vector(31 downto 0);
  signal s_R12, s_R13, s_R14, s_R15, s_R16, s_R17, s_R18, s_R19, s_R1A : std_logic_vector(31 downto 0);
  signal s_R1B, s_R1C, s_R1D, s_R1E, s_R1F : std_logic_vector(31 downto 0);
  signal s_S    : std_logic_vector(4 downto 0);
  signal s_Q : std_logic_vector(31 downto 0);

begin

  DUT0: mux32t1 
  port map(i_S => s_S,
	   i_R00 => s_R00,
	i_R01 => s_R01,
	i_R02 => s_R02,
	i_R03 => s_R03,
	i_R04 => s_R04,
	i_R05 => s_R05,
	i_R06 => s_R06,
	i_R07 => s_R07,
	i_R08 => s_R08,
	i_R09 => s_R09,
	i_R0A => s_R0A,
	i_R0B => s_R0B,
	i_R0C => s_R0C,
	i_R0D => s_R0D,
	i_R0E => s_R0E,
	i_R0F => s_R0F,
	i_R10 => s_R10,
	i_R11 => s_R11,
	i_R12 => s_R12,
	i_R13 => s_R13,
	i_R14 => s_R14,
	i_R15 => s_R15,
	i_R16 => s_R16,
	i_R17 => s_R17,
	i_R18 => s_R18,
	i_R19 => s_R19,
	i_R1A => s_R1A,
	i_R1B => s_R1B,
	i_R1C => s_R1C,
	i_R1D => s_R1D,
	i_R1E => s_R1E,
	i_R1F => s_R1F,	
        o_Y   => s_Q);

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
    s_R0B <= x"AABBCCDD";
    s_R0C <= x"DDCCBBAA";
    s_R0A <= x"CCDDAABB";		
    s_S <= "01011"; --should select bit 11 or B
    wait for cCLK_PER;  
    
    s_R12 <= x"11BB33DD";
    s_R13 <= x"DD33BB11";
    s_R14 <= x"33DD11BB";	
    s_S <= "10011"; --should select bit 19 
    wait for cCLK_PER;  

    s_R00 <= x"AA22CC44";
    s_R01 <= x"44CC22AA";
    s_R02 <= x"CC44AA22";	
    s_S <= "00001"; --should select bit 1 
    wait for cCLK_PER;  

    s_R1F <= x"AABBCCDD";
    s_R00 <= x"DDCCBBAA";
    s_R01 <= x"CCDDAABB";	
    s_S <= "00000"; --should select bit 0 / lowest bit 
    wait for cCLK_PER;  

    s_R1F <= x"AA2233DD";
    s_R00 <= x"DD3322AA";
    s_R1E <= x"33DDAA22";
	
    s_S <= "11111"; --should select bit 31 / highest bit 
    wait for cCLK_PER;  

    wait;
  end process;
  
end behavior;