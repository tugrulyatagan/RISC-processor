; deneme kod
_initial
    $pro_in = 4080
    $pro_out = 4081
_end

    MOV R2, #3
    MOV R1, #5
L:  LSL R2, R2, #1
    SUB R1, R1, #1
    BEQ S
    BAL L




S:  ADD R7, R2, #0
;    MOVL R0, $pro_out
;    STR [R0], R2



F:  BAL F


