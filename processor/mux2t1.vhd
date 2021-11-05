-------------------------------------------------------------------------
-- Jeremy Noesen
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1
-- mux using structural VHDL.
--
--
-- NOTES:
-- 9/1/21 Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
  port(i_S: in std_logic;
       i_D0: in std_logic;
       i_D1: in std_logic;
       o_O: out std_logic);
end mux2t1;

architecture structural of mux2t1 is

  component andg2
    port(i_A: in std_logic;
         i_B: in std_logic;
         o_F: out std_logic);
  end component;

  component org2
    port(i_A: in std_logic;
         i_B: in std_logic;
         o_F: out std_logic);
  end component;

  component invg
    port(i_A: in std_logic;
         o_F: out std_logic);
  end component;

  signal i_Sn: std_logic;
  signal i_D0Sn: std_logic;
  signal i_D1S: std_logic;

begin

  -- Invert i_S
  g_inv: invg
    port MAP(i_A => i_S,
             o_F => i_Sn);
  
  -- AND i_Sn and i_D0
  g_and_0: andg2
    port MAP(i_A => i_D0,
             i_B => i_Sn,
             o_F => i_D0Sn);

  -- AND i_S and i_D1
  g_and_1: andg2
    port MAP(i_A => i_D1,
             i_B => i_S,
             o_F => i_D1S);

  -- OR i_D0Sn and i_D1S
  g_or: org2
    port MAP(i_A => i_D0Sn,
             i_B => i_D1S,
             o_F => o_O);
  
end structural;
