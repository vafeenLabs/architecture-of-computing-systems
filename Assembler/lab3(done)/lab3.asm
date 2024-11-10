.MODEL TINY            
.STACK 128
.DATA
LEN EQU 10       
MAS DB -1, -2, 9, 8, 0, 7, 8, 0, 9, 0
RESULT DW 0
D DB 5
C DB -1
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    MOV CX, LEN 
    XOR AX, AX
    XOR SI, SI    
    JCXZ EXIT    
CYCLE:
    MOV BL, MAS[SI]        
    MOV AL, [C]
    CMP MAS[SI], AL      
    JL PRER                
    MOV AL, [D]
    CMP MAS[SI], AL
    JG PRER
    INC RESULT
PRER:
    ADD SI, 1       
    LOOP CYCLE            
EXIT:
    MOV AX, 4C00H
    INT 21H    
END START