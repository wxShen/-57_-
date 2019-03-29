addiu $s1,$0,1 # 1 is the known value of first and second Fib. number
sw $s1,0($s0)
sw $s1,64($s0)
sw $s1,4($s0)
sw $s1,68($s0)
addiu $t1,$0,1
addiu $t0,$0,14
loop:   lw $s2,0($s0)
	lw $s3,4($s0)
	add $s1,$s2,$s3 # F[1] = F[0] = 1
	sw $s1,8($s0)
	sw $s1,72($s0)
	addiu $s0, $s0 ,4
	sub $t0,$t0,$t1 
	beq $t0,$0,sum
	j loop
sum :   addiu $t2,$0,16
	addiu $s0,$s0,72
	loop1:  lw $s4,0($t3)
		lw $s5,64($t3)
		add $s6,$s4,$s5
		sw $s6,0($s0)
		addiu $t3,$t3,4
		addiu $s0,$s0,4
		sub $t2,$t2,$t1
		beq $t2,$0,exit
		j loop1
		exit: sub $s1,$s1,$t1
	
	
