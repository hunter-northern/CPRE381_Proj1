	.data

Arr:	.word	1,3,2,5,4,0,7,6

	.text

	.globl main

main:
	li $t1, 8		# get size of array

mainloop:
	subi $a1, $t1, 1	# count for current pass
	blez $a1, mainend	# check if complete

	la $a0, Arr		# get array address
	li $t2, 0		# clear swap flag

	jal passloop		# single sort pass

	beqz $t2, mainend	# if no swaps occur, sort is done

	subi $t1, $t1, 1	# decrement remaining pass count
	j mainloop

mainend:
	j end			# program complete

passloop:
	lw $s1, 0($a0)		# load first element in $s1
	lw $s2, 4($a0)		# load second element in $s2
	bgt $s1, $s2, passswap	# if $s1 > $s2 swap elements

passnext:
	addiu $a0, $a0, 4	# move to next element
	subiu $a1, $a1, 1	# decrement number of loops remaining
	bgtz $a1, passloop	# swap pass done? if no, loop
	jr $ra			# yes, return

passswap:
	sw $s1, 4($a0)		# put value of [i+1] in s1
	sw $s2, 0($a0)		# put value of [i] in s2
	li $t2, 1		# tell main loop that we did a swap
	j passnext

end:
	li $v0, 10
	syscall
