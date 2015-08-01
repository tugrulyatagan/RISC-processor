;ld str deneme
_initial
    $proc_in = 4080
    $proc_out = 4081
    a = 100,32,35
    b = 49,110
_end
;    MOV R2, #3
;    MOV R1, #4

;L:  LSL R2, R2, #1
;    SUB R1, R1, #1
;    BEQ S
;    BAL L
;

;S: ADD R2, R2, #2



    LD  R2, [R5, &b]
    ;ADD R2, R2, #5
    MOVL R0, $proc_out
    STR [R0], R2





F:  BAL F