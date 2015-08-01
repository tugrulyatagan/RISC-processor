;i/o test
_initial
    $proc_in = 4080
    $proc_out = 4081
    a = 2
    b = 5
_end

    MOV R1, #0
    MOV R2, #0

S:  MOVL R0, $proc_in
    LD  R1, [R0]
    LD  R2, [R7, &b]
    ADD R1, R1, R2
    MOVL R0, $proc_out
    STR [R0], R1
    BAL S



F:  BAL F
