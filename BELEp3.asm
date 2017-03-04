.text

main:
	li $v0, 5	# read integer n into a0
	syscall
	move $a0, $v0
	
	li $v0, 5	# read integer k into a1
	syscall
	move $a1, $v0	
	
	jal cfunc
	
	add $a0, $v0, $zero
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
cfunc:
	addi $sp, $sp, -16	# push the stack back
	sw   $ra, 0($sp)	# store the return address
	sw   $s0, 4($sp)	# store s0 into next byte on stack
	sw   $s1, 8($sp)	# store s1 into next byte on stack
	sw   $s2, 12($sp)	# store s2 into next byte on stack
	
	add  $s0, $a0, $zero	# set s0 to the current val of n
	add  $s1, $a1, $zero	# set s1 to the current val of k
	
	beq  $s1, $s0, ELSE	# if k = n go to ELSE
	add  $t2, $s1, $s0	# add k + n to compare sum to n
	beq  $t2, $s0, ELSE   	# if n + k = n then n = 0, so go to ELSE
	
	# now move on to recurrence relation non-trivial cases
	# C(n − 1, k − 1) + C(n − 1, k)
										
	addi $a0, $s0, -1	# n - 1
	addi $a1, $s1, -1	# k - 1
	
	jal cfunc		# C(n - 1, k - 1)
	
	add  $s2, $zero, $v0 	# store return val in s1
	addi $a0, $s0, -1	# n - 1
	addi $a1, $s1, 0	# k
	
	jal  cfunc		# C(n - 1, k)
	
	add $v0, $v0, $s2
	
	
cfuncDone:
	lw $ra, ($sp)		# grab the values off the stack
	lw $s0, 4($sp)		
	lw $s1, 8($sp)
	lw $s2, 12($sp)		
	addi $sp, $sp, 16	# and move the stack back
	
	jr $ra
	
ELSE:
	li $v0, 1
	j cfuncDone
