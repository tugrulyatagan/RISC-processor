;i/o test
_initial
    $proc_in = 4080
    $proc_out = 4081
    a = 0
    b = 5
    c = 3
_end


    LD  R2, [R7, #2]
    LD  R3, [R7, #1]

    ADD R1, R2, R3




S:  MOVL R0, $proc_out
    STR [R0], R1



F:  BAL F
