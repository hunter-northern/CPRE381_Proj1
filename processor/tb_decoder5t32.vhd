
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_decoder5t32 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_decoder5t32;

architecture behavior of tb_decoder5t32 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component decoder5t32
    port(i_S   		: in std_logic_vector(4 downto 0);
         o_Y          : out std_logic_vector(31 downto 0));   -- Data value output
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK  : std_logic;
  signal s_S    : std_logic_vector(4 downto 0);
  signal s_Q : std_logic_vector(31 downto 0);

begin

  DUT0: decoder5t32 
  port map(i_S => s_S,
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
    s_S <= "01011"; --should select bit 11 or B
    wait for cCLK_PER;  

    s_S <= "10011"; --should select bit 19 
    wait for cCLK_PER;  

    s_S <= "00001"; --should select bit 1 
    wait for cCLK_PER;  

    s_S <= "00000"; --should select bit 0 / lowest bit 
    wait for cCLK_PER;  

    s_S <= "11111"; --should select bit 31 / highest bit 
    wait for cCLK_PER;  

    wait;
  end process;
  
end behavior;