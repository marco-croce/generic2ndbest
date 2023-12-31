#	Generic 2nd Best Attività Didattica LPS

#	Fase 2.1

#	Language: MIPS32-MARS
# 	Style: plain MIPS32
# 	Version: int_comparator-MIPS32

.text

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
    
