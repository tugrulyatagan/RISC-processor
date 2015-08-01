; I/O test
_initial
    $proc_in = 4080
    $proc_out = 4081
_end

    MOV R2, #4
    MOV R3, #3
H:  CSL R3, R3, #1
    SUB R2, R2, #1
    BNE H
    ADD R1, R1, #1
    MOVL R0, $proc_out
    STR [R0], R3

    ; halt processor
F:  BAL F
