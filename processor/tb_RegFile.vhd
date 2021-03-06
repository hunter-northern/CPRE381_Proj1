
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_RegFile is
  generic(gCLK_HPER   : time := 50 ns;
	    N : integer := 32); 
end tb_RegFile;

-- vsim -voptargs="+acc" tb_mux2t1_N

architecture behavior of tb_RegFile is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


component RegFile is
  port(i_WE        : in std_logic;
       i_WRN        : in std_logic_vector(4 downto 0);
       i_WD         : in std_logic_vector(31 downto 0);	
       i_RPA	    : in std_logic_vector(4 downto 0);
       i_RPB	    : in std_logic_vector(4 downto 0);
       o_RPA	    : out std_logic_vector(31 downto 0);
       o_RPB 	    : out std_logic_vector(31 downto 0));

end component;

  -- Temporary signals to connect to the dff component.
  signal s_WE, s_CLK : std_logic;
signal s_WRN, s_sRPA, s_sRPB : std_logic_vector(4 downto 0);
signal s_RPA, s_RPB, s_WD : std_logic_vector(N-1 downto 0);


begin

  DUT_REGFILE: RegFile
  port map(i_WE => s_WE, 
           i_WRN => s_WRN,
           i_WD  => s_WD,
	   i_RPA => s_sRPA,
	   i_RPB => s_sRPB,
	   o_RPA => s_RPA,
	   o_RPB => s_RPB);

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
    	s_WE <= '1';
	s_WRN <= "00001";
	s_WD <= x"0F0F0F01";
	s_sRPA <= "00000";
	s_SRPB <= "00000";

    wait for cCLK_PER;

	s_WE <= '1';
	s_WRN <= "00010";
	s_WD <= x"0E0E0E02";
	s_sRPA <= "00001";
	s_SRPB <= "00000";

    wait for cCLK_PER;

	s_WE <= '0';
	s_WRN <= "00011";
	s_WD <= x"0D0D0D03";
	s_sRPA <= "00001";
	s_SRPB <= "00010";

    wait for cCLK_PER;
        s_WE <= '1';
	s_WRN <= "11111";
	s_WD <= x"0101010F";
	s_sRPA <= "00011";
	s_SRPB <= "11111";

    wait for cCLK_PER;

      s_WE <= '1';
	s_WRN <= "00000";
	s_WD <= x"01111111";
	s_sRPA <= "10101";
	s_sRPB <= "11111";

   wait for cCLK_PER;

       s_WE <= '1';
	s_WRN <= "00000";
	s_WD <= x"0D0D0D03";
	s_sRPA <= "00000";
	s_SRPB <= "11111";

    wait for cCLK_PER;
 

 
    wait;
  end process;
  
end behavior;