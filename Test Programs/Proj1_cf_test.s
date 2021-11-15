	.text

	.globl main

main:
	addi $a0, $0, 10	# set n = 10
	jal recursive
	addi $t9, $0, 55
	bne $v0, $t9, failure
	j exit

recursive:
	addi $sp, $sp, -8	# space for two words
	sw $ra, 4($sp)		# save return address
	sw $a0, 0($sp)		# temporary variable to hold n
	li $v0, 1
	slti $t0, $a0, 1
	bne $t0, $0, recexit
	addi $a0, $a0, -1
	jal recursive
	lw $a0, 0($sp)		# retrieve original n
	add $v0, $v0, $a0	# n + ((n - 1) + (n - 2) + ... (n - n))

recexit:
	lw $ra 4($sp)		# restore $ra
	addi $sp, $sp, 8	# restore $sp
	jr $ra			# back to caller

failure:
	addi $t8, $0, 1
	j exit

exit:
	li $v0, 10
	syscall
