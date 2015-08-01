;i/o test
_initial
    $proc_in = 4080
    $proc_out = 4081
_end

    MOV R1, #1


S:  MOVL R0, $proc_out
    STR [R0], R1
    BAL W
R:


    MOV R2, #8
L:  LSL R1, R1, #1
    BAL S
    SUB R2, R2, #1
    BNE L

    MOV R2, #8
R:  ASR R1, R1, #1
    SUB R2, R2, #1
    BNE R



F:  BAL F









W:  MOVL R0, #100
D2: MOV R7, #0
D1: SUB R7, R7, #1
    BNE D1
    SUB R0, R0, #1
    BNE D2
    BAL R

