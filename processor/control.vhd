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

entity control is
  port(iOP      : in std_logic_vector(5 downto 0);
       iFunc    : in std_logic_vector(5 downto 0);
       oRegDst  : out std_logic;
       oBranch  : out std_logic;
       oMemtoReg: out std_logic;
       oALUOp   : out std_logic_vector(3 downto 0);
       oMemWrite: out std_logic;
       oALUSrc  : out std_logic;
       oRegWrite: out std_logic);

end control;


architecture structural of control is

signal s1RegDst  : std_logic;
signal s1Branch  : std_logic;
signal s1MemtoReg: std_logic;
signal s1ALUOp   : std_logic_vector(3 downto 0);
signal s1MemWrite: std_logic;
signal s1ALUSrc  : std_logic;
signal s1RegWrite: std_logic;
signal s2RegDst  : std_logic;
signal s2Branch  : std_logic;
signal s2MemtoReg: std_logic;
signal s2ALUOp   : std_logic_vector(3 downto 0);
signal s2MemWrite: std_logic;
signal s2ALUSrc  : std_logic;
signal s2RegWrite: std_logic;

begin

with iFunc select
     s1RegDst <= '1' when "100000", --add
                '1' when "100001", --addu
                '1' when "100100", --and
                '1' when "100111", --nor
                '1' when "100110", --xor
                '1' when "100101", --or
                '1' when "101010", --slt
                '1' when "000000", --sll
                '1' when "000010", --srl
                '1' when "000011", --sra
                '1' when "100010", --sub
                '1' when "100011", --subu
                '1' when "001000", --jr
                '0' when others;

with iFunc select
     s1Branch <= '0' when "100000", --add
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
                '1' when "001000", --jr
                '0' when others;

with iFunc select
     s1MemtoReg <= '0' when "100000", --add
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
                '0' when "001000", --jr
                '0' when others;

with iFunc select
     s1ALUOp <= "0110" when "100000", --add
                "0110" when "100001", --addu
                "0000" when "100100", --and
                "0011" when "100111", --nor
                "0010" when "100110", --xor
                "0001" when "100101", --or
                "1111" when "101010", --slt
                "0000" when "000000", --sll
                "0000" when "000010", --srl
                "0000" when "000011", --sra
                "1110" when "100010", --sub
                "1110" when "100011", --subu
                "0000" when "001000", --jr
                "0000" when others;

with iFunc select
     s1MemWrite <= '0' when "100000", --add
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
                '0' when "001000", --jr
                '0' when others;

with iFunc select
     s1ALUSrc <= '0' when "100000", --add
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
                '0' when "001000", --jr
                '0' when others;

with iFunc select
     s1RegWrite <= '1' when "100000", --add
                '1' when "100001", --addu
                '1' when "100100", --and
                '1' when "100111", --nor
                '1' when "100110", --xor
                '1' when "100101", --or
                '1' when "101010", --slt
                '1' when "000000", --sll
                '1' when "000010", --srl
                '1' when "000011", --sra
                '1' when "100010", --sub
                '1' when "100011", --subu
                '1' when "001000", --jr
                '0' when others;

with iOP select
     s2RegDst <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '0' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '0' when "101011", --sw
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010", --j
                '0' when "000011", --jal
                '0' when "011111", --repl.qb
                '0' when others;

with iOP select
     s2Branch <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '0' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '0' when "101011", --sw
                '1' when "000100", --beq
                '1' when "000101", --bne
                '1' when "000010", --j
                '1' when "000011", --jal
                '0' when "011111", --repl.qb
                '0' when others;

with iOP select
     s2MemtoReg <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '1' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '0' when "101011", --sw
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010", --j
                '1' when "000011", --jal
                '0' when "011111", --repl.qb
                '0' when others;

with iOP select
     s2ALUOp <= "0110" when "001000", --addi
                "0110" when "001001", --addiu
                "0000" when "001100", --andi
                "0000" when "001111", --lui
                "0000" when "100011", --lw
                "0010" when "001110", --xori
                "0001" when "001101", --ori
                "0000" when "001010", --slti
                "0000" when "101011", --sw
                "0000" when "000100", --beq
                "0000" when "000101", --bne
                "0000" when "000010", --j
                "0000" when "000011", --jal
                "0000" when "011111", --repl.qb
                "0000" when others;

with iOP select
     s2MemWrite <= '0' when "001000", --addi
                '0' when "001001", --addiu
                '0' when "001100", --andi
                '0' when "001111", --lui
                '0' when "100011", --lw
                '0' when "001110", --xori
                '0' when "001101", --ori
                '0' when "001010", --slti
                '1' when "101011", --sw
                '1' when "000100", --beq
                '1' when "000101", --bne
                '1' when "000010", --j
                '0' when "000011", --jal
                '0' when "011111", --repl.qb
                '0' when others;

with iOP select
     s2ALUSrc <= '1' when "001000", --addi
                '1' when "001001", --addiu
                '1' when "001100", --andi
                '1' when "001111", --lui
                '0' when "100011", --lw
                '1' when "001110", --xori
                '1' when "001101", --ori
                '1' when "001010", --slti
                '0' when "101011", --sw
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010", --j
                '0' when "000011", --jal
                '0' when "011111", --repl.qb
                '0' when others;

with iOP select
     s2RegWrite <= '1' when "001000", --addi
                '1' when "001001", --addiu
                '1' when "001100", --andi
                '1' when "001111", --lui
                '0' when "100011", --lw
                '1' when "001110", --xori
                '1' when "001101", --ori
                '1' when "001010", --slti
                '0' when "101011", --sw
                '0' when "000100", --beq
                '0' when "000101", --bne
                '0' when "000010", --j
                '0' when "000011", --jal
                '1' when "011111", --repl.qb
                '0' when others;

Process (iOP, s1RegDst, s1Branch, s1MemtoReg, s1ALUOp, s1MemWrite, s1ALUSrc, s1RegWrite, s2RegDst, s2Branch, s2MemtoReg, s2ALUOp, s2MemWrite, s2ALUSrc, s2RegWrite)
begin
if iOP = "000000" then
       oRegDst <= s1RegDst; 
       oBranch <= s1Branch; 
       oMemtoReg <= s1MemtoReg;
       oALUOp <= s1ALUOp;  
       oMemWrite <= s1MemWrite;
       oALUSrc <= s1ALUSrc;
       oRegWrite <= s1RegWrite;
else
       oRegDst <= s2RegDst; 
       oBranch <= s2Branch; 
       oMemtoReg <= s2MemtoReg;
       oALUOp <= s2ALUOp; 
       oMemWrite <= s2MemWrite;
       oALUSrc <= s2ALUSrc;
       oRegWrite <= s2RegWrite;
end if;
end Process;

end structural;
