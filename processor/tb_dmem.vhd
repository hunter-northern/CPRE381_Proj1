library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dmem is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component mem

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK  : std_logic;
  signal s_addr  : std_logic_vector((10-1) downto 0);
  signal s_data   : std_logic_vector((32-1) downto 0);
  signal s_we     : std_logic := '1';
  signal s_q      : std_logic_vector((32 -1) downto 0);

begin

  DMEM: mem 
  port map(clk => s_CLK,
           addr => s_addr,
           data  => s_data,
           we   => s_we,
           q   => s_q);

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
    s_addr   <= "0000000000";
    s_we     <= '0';
    s_data   <= x"0000FFFF"; -- Data should not matter since it should be reading memory from file

    wait for cCLK_PER;

    s_addr   <= "0000000001";

    wait for cCLK_PER;

    s_addr   <= "0000000010";

    wait for cCLK_PER;

    s_addr   <= "0000000011";

    wait for cCLK_PER;

    s_addr   <= "0000000100";

    wait for cCLK_PER;

    s_addr   <= "0000000101";

    wait for cCLK_PER;

    s_addr   <= "0000000110";

    wait for cCLK_PER;

    s_addr   <= "0000000111";

    wait for cCLK_PER;

    s_addr   <= "0000001000";

    wait for cCLK_PER;

    s_addr   <= "0000001001";

    wait for cCLK_PER;

    s_addr   <= "0100000000";
    s_data   <= x"FFFFFFFF";
    s_we     <= '1';
 
    wait for cCLK_PER;

    s_addr   <= "0100000001";
    s_data   <= x"00000002";
 
    wait for cCLK_PER;

    s_addr   <= "0100000010";
    s_data   <= x"FFFFFFFD";
 
    wait for cCLK_PER;

    s_addr   <= "0100000011";
    s_data   <= x"00000004";
 
    wait for cCLK_PER;

    s_addr   <= "0100000100";
    s_data   <= x"00000005";
 
    wait for cCLK_PER;

    s_addr   <= "0100000101";
    s_data   <= x"00000006";
 
    wait for cCLK_PER;

    s_addr   <= "0100000110";
    s_data   <= x"FFFFFFF9";
 
    wait for cCLK_PER;

    s_addr   <= "0100000111";
    s_data   <= x"FFFFFFF8";
 
    wait for cCLK_PER;

    s_addr   <= "0100001000";
    s_data   <= x"00000009";
 
    wait for cCLK_PER;

    s_addr   <= "0100001001";
    s_data   <= x"FFFFFFF6";
 
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;
