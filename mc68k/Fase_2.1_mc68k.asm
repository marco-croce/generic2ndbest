;	Generic 2nd Best Attività Didattica LPS

;	Fase 2.1

;	Language: MC68K-ASM1
; 	Style: plain MC68000
; 	Version: int_comparator-MC68000

ORG $2000

; Routine int_comparator
; Input
;	a0 formato long - parametro a
;	a1 formato long - parametro b
; Output
;	d2 formato word - risultato
; Registri modificati
;	d0,d1

int_comparator:
    move.w (a0),d0
    move.w (a1),d1
    move.w d0,d2
    sub.w d1,d2
    
    rts

END