#	Generic 2nd Best Attività Didattica LPS

#	Fase 2.4

#	Language: MIPS32-MARS
# 	Style: plain MIPS32
# 	Version: stS_comparator_main-MIPS32

.data

array: 

    .word 28
    .byte 6
    .space 3  
    
    .word 18
    .byte 5
    .space 3
    
    .word 20
    .byte 2
    .space 3
    
    .word 10
    .byte 3
    .space 3

.text

main:
  # $a0 -> Stack (parametro p_ar)
  sub $sp,$sp,4
  la $a0,array
  sw $a0,($sp)
  # $t1 -> Stack (parametro arrLen)
  sub $sp,$sp,4
  li $t1,4
  sw $t1,($sp)
  # $t2 -> Stack (parametro elemSize)
  sub $sp,$sp,4
  li $t2,8
  sw $t2,($sp)
  
  jal alg_2nd_best
  
  j fine_codice

# Routine alg_2nd_best
# Input
# 	t0 - parametro p_ar
#	t1 - parametro arrLen
#       t2 - parametro elemSize
# Output
#	v0 - risultato ( m1 ) - word
#       v1 - risultato ( m2 ) - byte
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
    
    # Parametri int_comparator
    move $a0,$t3
    move $a1,$t6
    
    jal sts_comparator
    
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
    
    # Parametri int_comparator
    move $a0,$t4
    move $a1,$t6
    
    jal sts_comparator
    
    # Ripristino $t1
    lw $t1,($sp)
    add $sp,$sp,4
    # Ripristino $t0
    lw $t0,($sp)
    add $sp,$sp,4
    # Ripristino $ra 
    lw $ra,($sp)
    add $sp,$sp,4
    
    # Risultato sts_comparator
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
    lw $v0,($t4)
    lb $v1, 4($t4)
    
    jr $ra
   
   
   
# Routine sts_comparator
# Input
# 	a0 - parametro a
#	a1 - parametro b
# Output
#	v0 - risultato
# Registri modificati
#       t0, t1, t8, t9
sts_comparator:
    lw $t0, ($a0)  # m1 (x)
    lw $t1, ($a1)  # m1 (y)
    lb $t8, 4($a0) # m2 (x)
    lb $t9, 4($a1) # m2 (y)
    
    # if( x->m1 == y->m1 && x->m2 == y->m2 )
    beq $t0,$t1,controllo
    j if_ff
    
controllo:
    beq $t8,$t9,if_tt
    j if_ff
    
if_tt:
    # return 0;
    li $v0,0
    jr $ra
  
if_ff:
    # if( ( x->m2 < y->m2) || ( (x->m2 == y->m2 ) && ( x->m1 > y->m1 ) ) )
    blt $t8,$t9,if2_tt
    j controllo2
    
controllo2:
    beq $t8,$t9,controllo3
    j if2_ff
    
controllo3: 
    bgt $t0,$t1,if2_tt
    j if2_ff
    
if2_tt:  
    # return 1;
    li $v0,1
    jr $ra
    
if2_ff:
    # return -1;
    li $v0,-1
    jr $ra
    
    
    
fine_codice:
