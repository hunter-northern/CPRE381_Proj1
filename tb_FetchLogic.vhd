library IEEE;
use IEEE.std_logic_1164.all;

entity tb_FetchLogic is
  generic(gCLK_HPER   : time := 50 ns;
	N : integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);
end tb_FetchLogic;

-- vsim -voptargs="+acc" tb_FetchLogic
architecture behavior of tb_FetchLogic is
  
  constant cCLK_PER  : time := gCLK_HPER * 2;

  component FetchLogic is
  port( i_CLK                       : in std_logic;
	i_IMWE			    : in std_logic;	
        i_RST                       : in std_logic;
	i_Branch		    : in std_logic;
	i_BNE			    : in std_logic;
	i_Jal			    : in std_logic;
	i_ZERO			    : in std_logic;
	i_Jr			    : in std_logic;
	i_J			    : in std_logic;
	i_WRITEDST		    : in std_logic_vector(4 downto 0);
	i_JumpAddr		    : in std_logic_vector(25 downto 0);
	i_BranchImmAddr		    : in std_logic_vector(31 downto 0);
	i_WriteData		    : in std_logic_vector(31 downto 0);
	i_RS			    : in std_logic_vector(31 downto 0);
	o_WRITEDST		    : out std_logic_vector(4 downto 0);
	o_JaloDataWrite		    : out std_logic_vector(31 downto 0);
	o_Instr			    : out std_logic_vector(N-1 downto 0));
end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_IMWE, s_RST, s_Branch, s_BNE, s_Jal, s_ZERO, s_Jr, s_J : std_logic;
  signal s_BranchImmAddr, s_WriteData, s_RS, s_JaloDataWrite : std_logic_vector(31 downto 0);
signal s_JumpAddr : std_logic_vector(25 downto 0);
  signal s_oWriteDST, s_iWriteDST : std_logic_vector(4 downto 0);
  signal s_INSTR   : std_logic_vector((DATA_WIDTH-1) downto 0);


begin

  FETCH: FetchLogic port map(i_CLK => s_CLK,
           	i_IMWE => s_IMWE,
           	i_RST  => s_RST,
		i_Branch => s_Branch,
		i_BNE	=> s_BNE,
		i_Jal	=> s_Jal,
		i_ZERO	=> s_ZERO,
		i_Jr	=> s_Jr,
		i_J  	=> s_J,
		i_WRITEDST => s_iWriteDST,
		i_JumpAddr => s_JumpAddr,
		i_BranchImmAddr	=> s_BranchImmAddr,
		i_WriteData => s_WriteData,
		i_RS	=> s_RS,
		o_WRITEDST => s_oWriteDST,
		o_JaloDataWrite	 => s_JaloDataWrite,
           	o_Instr   => s_INSTR);

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
	wait for gCLK_HPER;
	s_RST <= '0';	
    s_IMWE  <= '0';

--Test 1 normal Instruction increment

	s_Branch <= '0';
	s_BNE <= '0';
	s_Jal <= '0';
	s_ZERO <= '0';
	s_Jr <= '0';
	s_J <= '0';
	s_iWriteDST <= "00001";
	s_JumpAddr <= "00000000000000000000000000";
	s_BranchImmAddr <= x"00000008";
	s_WriteData <= x"00000000";
	s_RS <= x"00000000";

    wait for gCLK_HPER*2;

--Test 1 normal Instruction increment

	s_Branch <= '0';
	s_BNE <= '0';
	s_Jal <= '0';
	s_ZERO <= '0';
	s_Jr <= '0';
	s_J <= '0';
	s_iWriteDST <= "00001";
	s_JumpAddr <= "00000000000000000000000000";
	s_BranchImmAddr <= x"00000008";
	s_WriteData <= x"00000000";
	s_RS <= x"00000000";

    wait for gCLK_HPER*2;

--Test 2 Branch EQ Expecting instruction output 0x06

	s_Branch <= '1';
	s_BNE <= '0';
	s_Jal <= '0';
	s_ZERO <= '1';
	s_Jr <= '0';
	s_J <= '0';
	s_iWriteDST <= "00001";
	s_JumpAddr <= "00000000000000000000000000";
	s_BranchImmAddr <= x"00000002";
	s_WriteData <= x"00000000";
	s_RS <= x"00000000";

    wait for gCLK_HPER*2;

--Test 3 BNE Expecting instruction output -8

	s_Branch <= '1';
	s_BNE <= '0';
	s_Jal <= '0';
	s_ZERO <= '1';
	s_Jr <= '0';
	s_J <= '0';
	s_iWriteDST <= "00001";
	s_JumpAddr <= "00000000000000000000000000";
	s_BranchImmAddr <= x"00000001";
	s_WriteData <= x"00000000";
	s_RS <= x"00000000";

    wait for gCLK_HPER*2;

--Test 4 Jump Expecting output -1 inst 0

	s_Branch <= '0';
	s_BNE <= '0';
	s_Jal <= '0';
	s_ZERO <= '1';
	s_Jr <= '0';
	s_J <= '1';
	s_iWriteDST <= "00001";
	s_JumpAddr <= "00000000000000000000000000";
	s_BranchImmAddr <= x"00000004";
	s_WriteData <= x"00000000";
	s_RS <= x"00000000";

    wait for gCLK_HPER*2;

--Test 5 JAL expecting 4 with WriteDST 31 and Write Data of 0x00100004

	s_Branch <= '0';
	s_BNE <= '0';
	s_Jal <= '1';
	s_ZERO <= '1';
	s_Jr <= '0';
	s_J <= '1';
	s_iWriteDST <= "00001";
	s_JumpAddr <= "00000000000000000000000011";
	s_BranchImmAddr <= x"00000004";
	s_WriteData <= x"00000000";
	s_RS <= x"00000000";

    wait for gCLK_HPER*2;

--Test 5 JR expecting output of 2

	s_Branch <= '0';
	s_BNE <= '0';
	s_Jal <= '0';
	s_ZERO <= '0';
	s_Jr <= '1';
	s_J <= '0';
	s_iWriteDST <= "00001";
	s_JumpAddr <= "00000000000000000000001100";
	s_BranchImmAddr <= x"00000004";
	s_WriteData <= x"00000000";
	s_RS <= x"00100004";

    wait for gCLK_HPER*2;

    wait;
  end process;
  
end behavior;