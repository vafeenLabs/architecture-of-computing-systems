.MODEL TINY
.STACK 128
.DATA
LEN EQU 10
MAS DB -1, -2, 9, 8, 0, 7, 8, 0, 0, 0
RESULT DW 0
D DB ?
C DB ?
MSG1 DB ' Enter D: $'
MSG2 DB ' Enter C: $'
MSG DB ' Result: $'

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; Ввод значений D и C
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV D, AL
    
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV C, AL

    MOV CX, LEN
    XOR AX, AX
    XOR SI, SI
    JCXZ EXIT

CYCLE:
    MOV BL, MAS[SI]
    MOV AL, C
    CMP MAS[SI], AL
    JL PRER
    MOV AL, D
    CMP MAS[SI], AL
    JG PRER
    INC RESULT

PRER:
    ADD SI, 1
    LOOP CYCLE

EXIT:
    ; Вывод результата
    MOV AH, 09H
    LEA DX, MSG
    INT 21H
    MOV AX, RESULT
    CALL OUTDEC

    MOV AX, 4C00H
    INT 21H

; Процедура вывода десятичного числа
OUTDEC PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    XOR CX, CX
    MOV BX, 10

CYCLE_OUTDEC:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    OR AX, AX
    JNZ CYCLE_OUTDEC

    MOV AH, 02H

CYCLE_PRINT:
    POP DX
    ADD DL, 30H
    INT 21H
    LOOP CYCLE_PRINT

    POP DX
    POP CX
    POP BX
    POP AX
    RET
OUTDEC ENDP

END START