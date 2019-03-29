 loop:  ori 	$t1, $t2, 1
add 	$t2, $t1, $t1
loop1: sltu 	$t4, $t1, $t2
ori 	$t4, $t1 ,2
slt 	$t5, $t3, $t4
loop2: sub 	$t6, $t4 ,$t5
sw 	$t6, 4($t0)
lw 	$t7, 4($t0)
ori 	$t1, $t0, 1
subu 	$t3, $t5 ,$t2
addiu	$t6, $t4 ,1
beq	$t6, $t7, loop
beq     $t6,$t7,loop2
addiu	$t4, $t6 ,1
j loop1
addiu	$t4, $t6 ,1
addiu	$t4, $t6 ,1