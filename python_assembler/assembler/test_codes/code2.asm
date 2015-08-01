; deneme kod
	LSL	R2, R5, #10
	NOP
	BCS label
	ADD	R1, R4, #60
	SUB R4, R3, #30
label:	ADD	R5, #40
	ADD R4, R5, R6	; add
	ADD R5, R4, R3
	LD  R3, [R5, R2]
	LD  R0, [R1, #10]
	LD  R4, [R2]
	STR [R5, #26], R1
	STR [R3], R2
	BGT label
	BAL label
	MOVL R0 #1368
	SUB R3, #30
	XOR R5, R3, R7
