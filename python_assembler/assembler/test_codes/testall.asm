; Test all instructions
L0:	ION
	IOF
	RTI
	NOP
L1:	LSL R2, R3, #3
	LSR R0, R1, #10
	ASR R7, R4, #1
	CSR R2, R3, #2
	ADD R1, R4, #60
L2:	SUB R3, R0, #15
	MOV R1, #130
	CMP R2, #25
	ADD R5, #40
	SUB R3, #200
	AND R2, R5, R3
	OR  R2, R5, R3
	XOR R2, R5, R3
L3:	LSL R1, R4, R3
	LSR R1, R2, R3
	ASR R1, R2, R3
	CSR R5, R5, R7
	ADD R1, R2, R3
	SUB R1, R2, R3
	NEG R5, R5
	NOT R3, R7
	CMP R6, R7
	TST R7, R0

	BEQ L1
	BNE L2
L4:	BCS L3
	BCC L4
	BMI L5
	BPL L1
	BVS L2
	BVC L3
	BHI L4
	BLS L5
	BGE L6
	BLT L0
	BGT L1
	BLE L5

	LD  R4, [R0, R3]
	LD  R3, [R5, #10]
L5:	LD  R1, [R2]
	STR [R5, #26], R1
	STR [R3], R2
	MOVL R0, #1368
L6:	BAL L0
