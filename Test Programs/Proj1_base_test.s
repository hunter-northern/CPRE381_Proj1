.text

# add and sub instructions
addi $t0, $0, -24       # put -24 in $t0
addiu $t1, $0, -43      # put 43 in $t1
add $t2, $t0, $t1       # put -24 + 43 = 19 into $t2
addu $t3, $t0, $t1      # put 24 + 43 = 67 into $t3
sub $t1, $t3, $t2       # put 67 - 19 = 48 into $t1
subu $t0, $t1, $t3      # put 24 - 48 = -24 into $t0


# boolean logic instructions
andi $t0, $t0, 0        # clear value from $t0
and $t1, $t1, $0        # clear value from $t1
ori $t0, $t0, 7         # put 7 into $t0
or $t1, $t1, $t2        # put 19 into $t1
xor $t4, $t3, $t2       # 0x00000013 xor 0x00000043, $t4 set to 0x00000050 (80)
xori $t5, $t4, 80       # 0x00000050 xor 0x00000050, $t5 set to 0
nor $t6, $t5, $t3       # 0x00000000 nor 0x00000013, $t6 set to 0xFFFFFFEC (4294967276)


# shifting instructions
sll $t7, $t6, 16        # $t7 becomes 0xFFEC0000
sra $t8, $t7, 4         # $t8 becomes 0xFFFEC000
srl $t9, $t8, 8         # $t9 becomes 0x00FFFEC0


# load and store instructions
sw $t0, 1005($s0)           # store value of $t0 into $s0
lw $t0, 0($0)            # clear value of $t0
sw $t1, 0($s1)           # store value of $t1 into $s1
lw $t1, 0($0)            # clear value of $t1
sw $t2, 0($s2)           # store value of $t2 into $s2
lw $t2, 0($0)            # clear value of $t2
sw $t3, 0($s3)           # store value of $t3 into $s3
lw $t3, 0($0)            # clear value of $t3
sw $t4, 0($s4)           # store value of $t4 into $s4
lw $t4, 0($0)            # clear value of $t4
sw $t5, 0($s5)           # store value of $t5 into $s5
lw $t5, 0($0)            # clear value of $t5
sw $t6, 0($s6)           # store value of $t6 into $s6
lw $t6, 0($0)            # clear value of $t6
sw $t7, 0($s7)           # store value of $t7 into $s7
lw $t7, 0($0)            # clear value of $t7
lw $t8, 0($0)            # clear value of $t8
lw $t9, 0($0)            # clear value of $t9

lui $t0, 15              # set $t0 to 0xF0000000
lui $t1, 255             # set $t1 to 0xFF000000
lw $t2, 0($s1)           # set $t2 to 19
lw $t3, 0($s6)           # set $t3 to 0xFFFFFFEC


# replicate quad bits
repl.qb $t4, 2        # set $t4 to 0x02020202
repl.qb $t5, 4       # set $t5 to 0x04040404


# set less than
slt $t6, $t4, $t5       # set $t6 to 1 since 0x02020202 < 0x04040404
slt $t7, $t5, $t2       # set $t7 to 0 since 0x04040404 > 19
slti $t8, $t6, 1        # set $t8 to 0 since 1 = 1
slti $t9, $t5, 1        # set $t9 to 1 since 0 < 1







