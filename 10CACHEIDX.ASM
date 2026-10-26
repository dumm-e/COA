
.MODEL SMALL
.STACK 100H
.DATA
    BLOCK DB 13
    LINES DB 4
    MSG DB 'Cache line: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AL, BLOCK
    XOR AH, AH
    DIV LINES
    MOV BL, AH          ; Save remainder before INT 21H changes AH
    LEA DX, MSG
    MOV AH, 09H
    INT 21H
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
