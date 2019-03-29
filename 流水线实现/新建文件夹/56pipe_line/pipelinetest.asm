sw $1,0($0)
sw $2,4($0)
sw $3,8($0)
sw $4,12($0)
sw $5,16($0)
sw $6,24($0)
sw $7,112($0)
sw $25,116($0)
sw $13,24($0)
mfc0 $1,cp0(14.0)
addiu $1,$1,4
mtc0 $1,cp0(14.0)
eret #返回108H

addiu $1,$0,1
sll $2,$1,4
addu $3,$2,$1
srl $4,$2,2
slti $25, $4, 5
bgez $25,14 #跳转到 84H(lui)
subu $5, $3, $4
sw $5, 20($0)
nor $6, $5, $2
or $7, $6, $3
xor $8, $7,$6
beq $8, $3, 2 #跳转到 6cH(lw)
sw $8,28($0)
slt $9,$1,$2
lw $10, 28($0)
bne $10, $5, 2 #跳转到 7CH
and $11,$2,$1
sw $11, 28($0)
jal 38
sw $4, 16($0)
lui $12, 12
srav $26, $12, $2
addiu $27, $26, 68
jalr $27
addiu $1, $0, 8
sb $26, 5($3)
sltu $13, $10, $3
bgtz $13,2
sllv $14,$6,$4
sra $15,$14,2
srlv $1, $15, $1
blez $16,7 #不跳转
srav $16, $15, $s1
bltz $16,6 #跳转到D4H
sll $11,$26,4
lw $28, 3($10)
bne $28, $29, 7 #跳转到E4H
sb $15, 8($5)
lb $18, 8($5)
lbu $19, 8($5)
sltiu $24, $15, 0xFFFF
or $29, $12, $5
jr $11#跳转到 C0H
andi $20, $15, 0xFFFF
ori $21, $15, 0xFFFF
xori $22,$15,0xFFFF
mult $12,$29
mflo $23
mfhi $30
mtlo $26
mthi $27
mtc0 $0,c14
syscall
mfc0 $2,cp0(14.0)
mfc0 $3,cp0(13.0)
mfc0 $4,cp0(12.0)
addiu $1, $0, 32
slt $17, $15, $14
lui $1, 0X1234
addiu $17, $17, 0x5678
sw $17, 0($1)
sll $17, $17, 4
bgtz $17,-3
addiu $1, $1, 4
addiu $2, $0, 60
lw $17, -28($1)
srl $17, $17, 4
sw $17, 0($2)
bne $17, $0, -3
addiu $2, $2, 4
addiu $6, $0, 68
addiu $7, $0, 100
lw $3, -28($1)
lw $4, -4($2)
or $5, $3, $4
sb $5, 0($7)
addiu $7, $7, 1
addiu $1, $1, 4
bne $2, $6, -7
addiu $2, $2, -4
addiu $9, $0, 100
lbu $9,3($9)
addiu $13, $0, 104
lw $13, 0($13)
sll $9, $9, 24
xori $13, $13, 9
sw $13, 1($7)
lw $1, 0($0)
lw $2, 4($0)
lw $3, 8($0)
lw $4, 12($0)
lw $5, 16($0)
lw $6, 24($0)
lw $7, 112($0)
lw $25, 116($0)
lw $13, 120($0)
j 0x34