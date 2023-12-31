#	Generic 2nd Best Attività Didattica LPS

#	Fase 2.4bis

#	Language: MIPS32-MARS
# 	Style: plain MIPS32
# 	Version: str_comparator_main-MIPS32

.data

array:
    .space 4
    .space 4
    .space 4

stringa1:
    .align 3
    .asciiz "aaaa"
stringa2:
    .align 3
    .asciiz "bbbb"
stringa3:
    .align 3
    .asciiz "cccc"

 .text
    # Allocazione puntatori a stringhe all'interno dell'array
    la $a0,stringa1
    sw $a0,array
    la $a0,stringa2
    sw $a0,array+4
    la $a0,stringa3
    sw $a0,array+8  
    
main:    
    # $a0 -> Stack (parametro p_ar)
    sub $sp,$sp,4
    la $a0,array
    sw $a0,($sp)
    # $t1 -> Stack (parametro arrLen)
    sub $sp,$sp,4
    li $t1,3
    sw $t1,($sp)
    # $t2 -> Stack (parametro elemSize)
    sub $sp,$sp,4
    li $t2,4
    sw $t2,($sp)
    
    jal alg_2nd_best
  
    j fine_codice
    
# Routine alg_2nd_best
# Input
# 	t0 - parametro p_ar
#	t1 - parametro arrLen
#       t2 - parametro elemSize
# Output
#	v0 - risultato (puntatore alla striga)
# Registri modificati
#       t3 - best
#       t4 - scnd_best
#       t5 - i
#       t6
#       t7 - a
alg_2nd_best:
    # elemSize -> t2
    lw $t2,($sp)
    add $sp,$sp,4
    # arrLen -> t1
    lw $t1,($sp)
    add $sp,$sp,4
    # p_ar -> t0
    lw $t0,($sp)
    add $sp,$sp,4

    # i = 0
    li $t5,0
    # i < arrLen
    blt $t5,$t1,for_true
    jr $ra
for_true:
    # if (i == 0)
    beqz $t5, if
    j if_false
if:
    # elemSize*i;
    mul $t6,$t2,$t5
    # p_ar+elemSize*i;
    add $t6,$t6,$t0
    # best = p_ar+elemSize*i;
    move $t3,$t6
    # scndBest = p_ar+elemSize*i;
    move $t4,$t6
    j fine_routine
if_false:
    # elemSize*i;
    mul $t6,$t2,$t5
    # p_ar+elemSize*i;
    add $t6,$t6,$t0

    # $ra -> Stack
    sub $sp,$sp,4
    sw $ra,($sp)
    # $t0 -> Stack
    sub $sp,$sp,4
    sw $t0,($sp)
    # $t1 -> Stack
    sub $sp,$sp,4
    sw $t1,($sp)
    
    # Parametri str_comparator
    move $a0,$t3
    move $a1,$t6
    
    jal str_comparator
    
    # Ripristino $t1
    lw $t1,($sp)
    add $sp,$sp,4
    # Ripristino $t0
    lw $t0,($sp)
    add $sp,$sp,4
    # Ripristino $ra 
    lw $ra,($sp)
    add $sp,$sp,4
    
    # Risultato str_comparator
    move $t7,$v0
    
    # if(a < 0)
    bltz $t7,best
    j not_best
best:
    # scnd_best = best;
    move $t4,$t3
    # best = p_ar+elemSize*i;
    mul $t6,$t2,$t5
    add $t6,$t6,$t0
    move $t3,$t6
    
    j fine_routine
not_best:
    # if(a > 0)
    bgtz $t7,second
    j fine_routine
second:
    # $ra -> Stack
    sub $sp,$sp,4
    sw $ra,($sp)
    # $t0 -> Stack
    sub $sp,$sp,4
    sw $t0,($sp)
    # $t1 -> Stack
    sub $sp,$sp,4
    sw $t1,($sp)
    
    # Parametri str_comparator
    move $a0,$t4
    move $a1,$t6
    
    jal str_comparator
    
    # Ripristino $t1
    lw $t1,($sp)
    add $sp,$sp,4
    # Ripristino $t0
    lw $t0,($sp)
    add $sp,$sp,4
    # Ripristino $ra 
    lw $ra,($sp)
    add $sp,$sp,4
    
    # Risultato str_comparator
    move $t7,$v0
    
    bltz $t7,second_best
    j fine_routine
second_best:
    # scnd_best = p_ar+elemSize*i
    move $t4,$t6
fine_routine:
    # i++
    add $t5,$t5,1
    # if(i < arrLen)
    blt $t5,$t1,for_true
    # Salvataggio second_best
    lw $a3,($t4)
    lw $v0,($a3)
    
    jr $ra

              
# Routine str_comparator
# Input
# 	a0 - parametro a
#	a1 - parametro b
# Output
#	v0 - risultato
# Registri modificati
#       t0, t1, a3  
str_comparator:  
	li $v0, 0
loop:
        lw $a3, ($a0)
        lb $t0, ($a3)
        lw $a3, ($a1)
	lb $t1, ($a3)
	add $a0, $a0, 1
	add $a1, $a1, 1
	beqz $t0, loop_end
	beqz $t1, loop_end
	bgt $t0, $t1, greater
	blt $t0, $t1, less
	beq $t0, $t1, loop
greater:
	li $v0, 1
	j end
less:
	li $v0, -1
	j end
equal:
	li $v0, 0
	j end
loop_end:
	beq $t0, $t1, equal
	beqz $t0, less
	beqz $t1, greater
end:
	jr $ra
	
	
fine_codice:
