;uart test
_initial
    $proc_in = 4080
    $proc_out = 4081
    $uart_rx = 4082
    $uart_tx = 4083
_end
    MOV R4, #0

    ; set tx
    MOVL R0, $uart_tx
    STR [R0], R4

    ; set rx
    MOVL R0, $uart_rx
    MOV R7, #1
    LSL R7, R7, #9
    STR [R0], R7


D:  BTS R
    ADD R4, R4, #1
    BTS P
    ;BTS S
    BAL D




R:  MOVL R0, $uart_rx
    MOV R7, #1
    LSL R7, R7, #8
TR: LD  R1, [R0]
    TST R7, R1
    BEQ TR
    LD  R1, [R0]
    MOV R7, #255
    AND R1, R7, R1
    RTS




S:  MOVL R0, $uart_tx
    MOV R7, #1
    LSL R7, R7, #8
    OR  R7, R7, R4
    STR [R0], R7
    ;
    MOV R7, #0
    STR [R0], R7
    RTS






P:  MOVL R0, $proc_out
    STR [R0], R4
    RTS