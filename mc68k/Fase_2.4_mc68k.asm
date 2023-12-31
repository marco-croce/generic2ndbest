;	Generic 2nd Best Attività Didattica LPS

;	Fase 2.4

;	Language: MC68K-ASM1
; 	Style: plain MC68000
; 	Version: stS_comparator_main-MC68000

ORG $4000

array:

    dc.l 28
    ds.b 3
    dc.b 6
    
    dc.l 18
    ds.b 3
    dc.b 5
    
    dc.l 20
    ds.b 3
    dc.b 2
    
    dc.l 10
    ds.b 3
    dc.b 3
    
ORG $2000

main: 
    ; a2 -> Stack (parametro p_ar)
    move.l #array, a2
    move.l a2,-(sp)
    ; d0 -> Stack (parametro arrLen)
    move.w #4,d0
    move.w d0,-(sp)
    ; d1 -> Stack (parametro elemSize)
    move.w #8,d1
    move.w d1,-(sp)
    
    jsr alg_2nd_best
    
    jmp fine_codice
    
; Routine alg_2nd_best
; Input
;   Stack - parametro elemSize
;   Stack - parametro arrLen
;   Stack - parametro p_ar
; Output
;   d4 - risultato ( m1 ) - long
;   d5 - risultato ( m2 ) - byte
; Registri modificati
;       a2 - p_ar
;       a3 - best
;       a4 - scnd_best
;       a5 
;       d0 - arrLen
;       d1 - elemSize
;       d2 - i
;       d3 - a
alg_2nd_best:
    ; elemSize -> d1 sp
    move.l (sp)+,d1
    ; arrLen -> d0
    move.l (sp)+,d0
    ; p_ar -> a2
    move.l (sp)+,a2
    
    ; i = 0
    move.w #0,d2
    ; i < arrLen
    cmp.l d0,d2
    blt for_true
    rts
for_true:
    ; if (i == 0)
    tst.l d2
    beq if
    jmp if_false
if:
    ; elemSize*i
    move.l d1,a5
    muls.l d2,a5
    ; p_ar+elemSize*i;
    add.l a2,a5 
    ; best = p_ar+elemSize*i;
    move.l a5,a3
    ; scnd_best = p_ar+elemSize*i;
    move.l a5,a4
    jmp fine_routine
if_false:
    ; elemSize*i
    move.l d1,a5
    muls.l d2,a5
    ; p_ar+elemSize*i;
    add.l a2,a5 

    ; d0 -> Stack 
    move.w	d0,-(sp)
    ; d1 -> Stack
    move.w	d1,-(sp)
    
    ; Parametri stS_comparator
    move.l a3,a0
    move.l a5,a1
    
    jsr sts_comparator
    
    ; Ripristino d1
    move.l (sp)+,d1
    ; Ripristino d0
    move.l (sp)+,d0
    
    ; if(a < 0)
    tst.w d3
    blt best
    jmp not_best
best:
    ;scnd_best = best;
    move.l a3,a4
    ; best = p_ar+elemSize*i;
    move.l d1,a5
    muls.l d2,a5
    add.l a2,a5
    move.l a5,a3
    
    jmp fine_routine
not_best:
    ; if(a > 0)
    tst.w d3
    bgt second
    jmp fine_routine
second:
    ; d0 -> Stack 
    move.w	d0,-(sp)
    ; d1 -> Stack
    move.w	d1,-(sp) 
    
    move.l a3,a0
    move.l a5,a1
    
    jsr sts_comparator
    
    ; Ripristino d1
    move.l (sp)+,d1
    ; Ripristino d0
    move.l (sp)+,d0
    
    tst.w d3
    blt second_best
    jmp fine_routine
second_best:
    ; scnd_best = p_ar+elemSize*i
    move.l a5,a4
fine_routine:
    ; i++
    add.w #1,d2
    ; if(i < arrLen)
    cmp.w d0,d2
    blt for_true
    ; Salvataggio second_best
    move.l (a4),d4
    add.l #7,a4
    move.b (a4),d5
    
    rts
    
; Routine sts_comparator
; Input
;	a0 formato long - parametro a
;	a1 formato long - parametro b
; Output
;	d3 formato word - risultato
; Registri modificati
;	d0,d1,d6,d7
sts_comparator:
    move.l (a0),d0 ; m1 (x)
    move.l (a1),d1 ; m1 (y)
    add.l #7,a0
    add.l #7,a1
    move.b (a0),d6 ; m2 (x)
    move.b (a1),d7 ; m2 (y)

    cmp.l d1,d0
    beq controllo
    jmp if_ff
    
controllo:
    cmp.b d7,d6
    beq if_tt
    jmp if_ff
    
if_tt:
    move.w #0,d3
    rts
    
if_ff:
    cmp.b d7,d6
    blt if2_tt
    jmp controllo2

controllo2:
    cmp.b d7,d6
    beq controllo3
    jmp if2_ff
    
controllo3:
    cmp.l d1,d0
    bgt if2_tt
    jmp if2_ff
    
if2_tt:
    move.w #1,d3
    rts
    
if2_ff:
    move.w #-1,d3
    rts

fine_codice:
    

END