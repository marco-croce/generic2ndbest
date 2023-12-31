#	Generic 2nd Best Attività Didattica LPS

#	Fase 2.2

#	Language: MIPS32-MARS
# 	Style: plain MIPS32
# 	Version: alg_2nd_best-MIPS32

# Routine alg_2nd_best
# Input
#   Stack - parametro elemSize
#	Stack - parametro arrLen
# 	Stack - parametro p_ar
# Output
#	v1 - risultato 
# Registri modificati
#       t0 - p_ar
#       t1 - arrLen
#       t2 - elemSize
#       t3 - best
#       t4 - scnd_best
#       t5 - i
#       t6 
#       t7 - a

.text

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
    # scnd_best = p_ar+elemSize*i;
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
    
    # Parametri int_comparator
    move $a0,$t3
    move $a1,$t6
    
    jal int_comparator
    
    # Ripristino $t1
    lw $t1,($sp)
    add $sp,$sp,4
    # Ripristino $t0
    lw $t0,($sp)
    add $sp,$sp,4
    # Ripristino $ra 
    lw $ra,($sp)
    add $sp,$sp,4
    
    # Risultato int_comparator
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
    
    move $a0,$t4
    move $a1,$t6
    
    jal int_comparator
    
    # Ripristino $t1
    lw $t1,($sp)
    add $sp,$sp,4
    # Ripristino $t0
    lw $t0,($sp)
    add $sp,$sp,4
    # Ripristino $ra 
    lw $ra,($sp)
    add $sp,$sp,4
    
    # Risultato int_comparator
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
    lw $v1,($t4)
    
    jr $ra
   

      
# Routine int_comparator
# Input
# 	a0 - parametro a
#	a1 - parametro b
# Output
#	v0 - risultato
# Registri modificati
#       t0, t1 
int_comparator:
    lw $t0,($a0)
    lw $t1,($a1)
    sub $v0,$t0,$t1
    
    jr $ra
