;i/o test
_initial
    $proc_in = 4080
    $proc_out = 4081
_end

    MOV R1, #1
    BTS P

    BTS W

    MOV R1, #5
    BTS P


F:  BAL F



P:  MOVL R0, $proc_out
    STR [R0], R1
    RTS



W:  MOVL R0, #1000
D2: MOV R7, #0
D1: SUB R7, R7, #1
    BNE D1
    SUB R0, R0, #1
    BNE D2
    RTS
    NOP