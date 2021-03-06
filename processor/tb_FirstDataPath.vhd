library IEEE;
use IEEE.std_logic_1164.all;

entity tb_FirstData is
  generic(gCLK_HPER   : time := 50 ns;
	    N : integer := 32); 
end tb_FirstData;

-- vsim -voptargs="+acc" tb_mux2t1_N

architecture behavior of tb_FirstData is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


component FirstDataPath is
  port( i_CLK                        : in std_logic;
	i_WE   		 	 : in std_logic;
	i_RS 		            : in std_logic_vector(4 downto 0);
        i_RT 		            : in std_logic_vector(4 downto 0);
	i_RD			    : in std_logic_vector(4 downto 0);	
	i_RST			    : in std_logic;
	i_IMM			    : in std_logic_vector(N-1 downto 0);
	i_WD			    : in std_logic_vector(N-1 downto 0);
        nAdd_Sub	            : in std_logic;
        Alu_Src			    : in std_logic;
	o_RTO			    : out std_logic_vector(N-1 downto 0);
	o_Overflow	            : out std_logic;
	o_ALUout		    : out std_logic_vector(N-1 downto 0));

end component;

signal s_CLK, snAdd_Sub, sAlu_Src, s_RST : std_logic;
signal s_RD, s_RT, s_RS : std_logic_vector(4 downto 0);
signal s_IMM : std_logic_vector(N-1 downto 0);
signal s_ALUout : std_logic_vector(N-1 downto 0);
signal s_Over, s_WE : std_logic;
signal s_RTO : std_logic_vector(N-1 downto 0);

begin

  DUT_FirstData: FirstDataPath
  port map(i_CLK => s_CLK, 
	   i_WE => s_WE,
           i_RS => s_RS,
	   i_RST => s_RST,	
           i_RT  => s_RT,
	   i_IMM => s_IMM,
	   i_RD => s_RD,
	   i_WD => s_ALUout,
	   nAdd_Sub => snAdd_Sub,
	   Alu_Src => sAlu_Src,
	   o_RTO  =>  s_RTO,
	   o_Overflow => s_Over,
	   o_ALUout => s_ALUout);

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
		
	s_WE <= '1';
	
	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00001";
	s_IMM <= x"00000001";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00010";
	s_IMM <= x"00000002";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00011";
	s_IMM <= x"00000003";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00100";
	s_IMM <= x"00000004";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00101";
	s_IMM <= x"00000005";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00101";
	s_IMM <= x"00000005";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;

  
	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00101";
	s_IMM <= x"00000005";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00110";
	s_IMM <= x"00000006";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"00111";
	s_IMM <= x"00000007";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"01000";
	s_IMM <= x"00000008";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"01001";
	s_IMM <= x"00000009";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00000";
	s_RT <= "XXXXX";
	s_RD <=	"01010";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;


	s_RS <= "00001";
	s_RT <= "00010";
	s_RD <=	"01011";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

    wait for cClk_PER;


	s_RS <= "01011";
	s_RT <= "00011";
	s_RD <=	"01100";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '1';
	sAlu_Src <= '0';

    wait for cClk_PER;


	s_RS <= "01100";
	s_RT <= "00100";
	s_RD <=	"01101";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

    wait for cClk_PER;


	s_RS <= "01100";
	s_RT <= "00100";
	s_RD <=	"01101";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

    wait for cClk_PER;


	s_RS <= "01101";
	s_RT <= "00101";
	s_RD <=	"01110";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '1';
	sAlu_Src <= '0';

    wait for cClk_PER;


	s_RS <= "01110";
	s_RT <= "00110";
	s_RD <=	"01111";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

    wait for cClk_PER; 


	s_RS <= "01111";
	s_RT <= "00111";
	s_RD <=	"10000";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '1';
	sAlu_Src <= '0';

    wait for cClk_PER; 

	s_RS <= "10000";
	s_RT <= "01000";
	s_RD <=	"10001";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

    wait for cClk_PER;


	s_RS <= "10001";
	s_RT <= "01001";
	s_RD <=	"10010";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '1';
	sAlu_Src <= '0';

    wait for cClk_PER;

	s_RS <= "10010";
	s_RT <= "01010";
	s_RD <=	"10011";
	s_IMM <= x"0000000A";
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

    wait for cClk_PER;



	s_RS <= "00000";
	s_RT <= "01000";
	s_RD <=	"10100";
	s_IMM <= x"FFFFFFDD";
	snAdd_Sub <= '0';
	sAlu_Src <= '1';

    wait for cClk_PER;

 
	s_RS <= "10011";
	s_RT <= "10100";
	s_RD <=	"10101";
	s_IMM <= x"FFFFFFDD";
	snAdd_Sub <= '0';
	sAlu_Src <= '0';

    wait for cClk_PER;


    wait;
  end process;
  
end behavior;