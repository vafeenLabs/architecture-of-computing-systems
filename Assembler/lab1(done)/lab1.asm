.model tiny
org 100h
.data
	c dd 2                 
	d dd 2
	a dd 8                  
	res dd 0                  
.code

	MOV CX, -2
	MOV AX, [c]
	IMUL CX      ; -2 * c
	MOV BX, AX
	MOV AX, [d]
	MOV CX, 82
	IMUL CX      ; d * 82
	ADD BX, AX   ; -2 * c + d * 82
	
	MOV AX, [a]
	MOV CX, 4
	CWD
	IDIV CX      ; a / 4
	SUB AX, 1    ; a / 4 - 1
	MOV CX, AX
	MOV AX, BX
	CWD
	IDIV CX      ;(-2 * c + d * 82) / (a / 4 - 1)
    MOV [res], AX      
ret