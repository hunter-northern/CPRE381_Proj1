-------------------------------------------------------------------------
-- Bridget Schmitt 
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_TPU_MV_Element.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the TPU MAC unit.
--              
-- 01/03/2020 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O


entity tb_barrelShifter is
  generic(gCLK_HPER   : time := 10 ns);  
end tb_barrelShifter;

architecture mixed of tb_barrelShifter is

constant cCLK_PER  : time := gCLK_HPER * 2;


component barrelShifter is
  port(i_X : in std_logic_vector(31 downto 0);
       i_shamt : in std_logic_vector(4 downto 0);
       i_type : in std_logic; -- 0 for logical, 1 for arithmetic
       i_dir : in std_logic; -- 0 for right, 1 for left
       o_Y : out std_logic_vector(31 downto 0));
end component;

signal i_X      : std_logic_vector(31 downto 0):= x"00000000";
signal i_shamt  : std_logic_vector(4 downto 0):= "00000";
signal i_type   : std_logic; -- 0 for logical, 1 for arithmetic
signal i_dir    : std_logic; -- 0 for right, 1 for left
signal o_Y      : std_logic_vector(31 downto 0);

begin


  DUT0: barrelShifter
  port map(i_X => i_X,
           i_shamt => i_shamt,
           i_type => i_type,
           i_dir => i_dir,
           o_Y => o_Y);

 

  P_TEST_CASES: process
  begin

    -- Test case 1:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00001";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 2:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 3: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00010";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 4: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 5: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00100";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 6:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 7: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "01000";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 8: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 9: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "10000";
    i_type <= '0';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 10:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00001";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 11:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 12: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00010";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 13: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 14: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00100";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 15:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 16: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "01000";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 17: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00000";
    i_type <= '0';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 18: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "10000";
    i_type <= '1';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 19:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00001";
    i_type <= '1';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 20: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00010";
    i_type <= '1';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 21: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00100";
    i_type <= '1';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 22: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "01000";
    i_type <= '1';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 23: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "10000";
    i_type <= '1';
    i_dir <= '0';
    wait for gCLK_HPER*2;

    -- Test case 24:
    i_X <= x"FFFFFFFF";
    i_shamt <= "00001";
    i_type <= '1';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 25: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00010";
    i_type <= '1';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 26: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "00100";
    i_type <= '1';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 27: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "01000";
    i_type <= '1';
    i_dir <= '1';
    wait for gCLK_HPER*2;

    -- Test case 28: 
    i_X <= x"FFFFFFFF";
    i_shamt <= "10000";
    i_type <= '1';
    i_dir <= '1';
    wait for gCLK_HPER*2;




  end process;

end mixed;
