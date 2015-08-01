; Knight Rider Kitt
_initial
    $proc_in = 4080
    $proc_out = 4081
    $delay = 15
_end

    MOV R1, #1

    ; left
L:  BTS P
    BTS W
    LSL R1, R1, #1
    CMP R1, #128
    BCC L

    ; right
R:  BTS P
    BTS W
    ASR R1, R1, #1
    CMP R1, #1
    BHI R
    BAL L

    ; print subroutine
P:  MOVL R0, $proc_out
    STR [R0], R1
    RTS

    ; wait subroutine
W:  MOVL R0, $delay
D2: MOV R7, #0
D1: SUB R7, R7, #1
    BNE D1
    SUB R0, R0, #1
    BNE D2
    RTS