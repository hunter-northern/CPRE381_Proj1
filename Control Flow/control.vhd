-------------------------------------------------------------------------
-- Bridget Schmitt
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- OnesComp.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
-- vsim -voptargs=+acc tb_Decode_n
-- vcom -2008 -work work *.vhd
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library ieee;
use IEEE.std_logic_1164.all;
use work.bit32Array.array32;

entity control is
  port(iCLK     : in std_logic;
       iRST     : in std_logic;
       iWE      : in std_logic;
       iOP      : in std_logic_vector(5 downto 0);
       iFunc    : in std_logic_vector(5 downto 0);
       oRegDst  : out std_logic;
       oBranch  : out std_logic;
       oMemtoReg: out std_logic;
       oALUOp   : out std_logic_vector(3 downto 0);
       oMemWrite: out std_logic;
       oALUSrc  : out std_logic;
       oRegWrite: out std_logic;

end control;

architecture structural of control is

with iOP select
     oRegDst <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '0' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '0' when "101011", --sw
                '0' when "001110", --xori
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010"; --j
                '0' when "000011"; --jal

with iFunc select
     oRegDst <= '0' when "100000", --add
                '0' when "100001", --addu
                '0' when "100100", --and
                '0' when "100111", --nor
                '0' when "100110", --xor
                '0' when "100101", --or
                '0' when "101010", --slt
                '0' when "000000", --sll
                '0' when "000010", --srl
                '0' when "000011", --sra
                '0' when "100010", --sub
                '0' when "100011", --subu
                '0' when "001000"; --jr

with iOP select
     oBranch <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '0' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '0' when "101011", --sw
                '0' when "001110", --xori
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010"; --j
                '0' when "000011"; --jal

with iFunc select
     oBranch <= '0' when "100000", --add
                '0' when "100001", --addu
                '0' when "100100", --and
                '0' when "100111", --nor
                '0' when "100110", --xor
                '0' when "100101", --or
                '0' when "101010", --slt
                '0' when "000000", --sll
                '0' when "000010", --srl
                '0' when "000011", --sra
                '0' when "100010", --sub
                '0' when "100011", --subu
                '0' when "001000"; --jr

with iOP select
     oMemtoReg <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '0' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '0' when "101011", --sw
                '0' when "001110", --xori
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010"; --j
                '0' when "000011"; --jal

with iFunc select
     oMemtoReg <= '0' when "100000", --add
                '0' when "100001", --addu
                '0' when "100100", --and
                '0' when "100111", --nor
                '0' when "100110", --xor
                '0' when "100101", --or
                '0' when "101010", --slt
                '0' when "000000", --sll
                '0' when "000010", --srl
                '0' when "000011", --sra
                '0' when "100010", --sub
                '0' when "100011", --subu
                '0' when "001000"; --jr

with iOP select
     oALUOp <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '0' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '0' when "101011", --sw
                '0' when "001110", --xori
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010"; --j
                '0' when "000011"; --jal

with iFunc select
     oALUOp <= '0' when "100000", --add
                '0' when "100001", --addu
                '0' when "100100", --and
                '0' when "100111", --nor
                '0' when "100110", --xor
                '0' when "100101", --or
                '0' when "101010", --slt
                '0' when "000000", --sll
                '0' when "000010", --srl
                '0' when "000011", --sra
                '0' when "100010", --sub
                '0' when "100011", --subu
                '0' when "001000"; --jr

end structural;