; factorial
_initial
    $proc_in = 4080
    $proc_out = 4081
_end

D:  BTS P
    BTS R

    ; if n == 0
    CMP R2, #0
    BNE C1
    MOV R1, #1
    BAL D

    ; if n == 1
C1: CMP R2, #1
    BNE C2
    MOV R1, #1
    BAL D

    ; if n == 2
C2: CMP R2, #2
    BNE C3
    MOV R1, #2
    BAL D

    ; if n > 2
C3: MOV R3, R2
    MOV R1, R2
S:  SUB R3, R3, #1
    CMP R3, #1
    BEQ D
    MUL R1, R1, R3
    BAL S

    ; print subroutine
P:  MOVL R0, $proc_out
    STR [R0], R1
    RTS

    ; read input
R:  MOVL R0, $proc_in
    LD   R2, [R0]
    RTS
