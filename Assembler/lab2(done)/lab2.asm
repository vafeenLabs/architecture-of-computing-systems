.MODEL TINY
.STACK 100H
.DATA
    A DD 0
    B DD -1
    X DD ?
.CODE
MAIN PROC
    MOV CX, [A]
    MOV BX, [B]
    CMP BX, CX
    JE EQUAL
    JB BELOW
    JA ABOVE
    RET
BELOW:
    MOV AX, [B]
    CWD
    IDIV CX
    ADD AX, 5
    MOV [X], AX
    RET
ABOVE:
    MOV AX, [A]
    IMUL AX
    SUB AX, BX
    CWD
    IDIV BX
    MOV [X], AX
    RET
EQUAL:
    MOV [X], -5
    RET
MAIN ENDP
END