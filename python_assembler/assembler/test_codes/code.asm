; deneme kod
_initial
    $serialAdr = 100
    $len = 5
    a = 31,32,35
    b = 100,110
_end
    ION
    MOV R0, #3
    MOV R1, #5
    MOV R1, $len
    ADD R5, R5, #1
    LD  R4, [R5, &b]
L:  LSL R0, R0, #1
    ADD R2, R0, #1
    SUB R1, R1, #1
    BEQ S
    BAL L
S:  BAL S


ISR: ADD R5, R5, #1
    ADD R6, R6, #2
    RTI



