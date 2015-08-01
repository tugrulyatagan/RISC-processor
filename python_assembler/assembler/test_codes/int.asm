;ld str deneme
_initial
    $proc_in = 4080
    $proc_out = 4081
_end

    MOV R1, #0
    ION

F:  BAL F

ISR: ADD R1, R1, #1
     BTS P
     RTI


P:  MOVL R0, $proc_out
    STR [R0], R1
    RTS
    NOP
