; Experiment 6: Exchange two blocks of bytes
.MODEL SMALL
.STACK 100H
.DATA
    BLOCK1 DB 'ABCDE'
    BLOCK2 DB '12345'
    MSG1 DB 13,10,'Block1 : $'
    MSG2 DB 13,10,'Block2 : $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    ; Exchange blocks
    LEA SI,BLOCK1
    LEA DI,BLOCK2
    MOV CX,5
EXCH:
    MOV AL,[SI]
    MOV BL,[DI]
    MOV [SI],BL
    MOV [DI],AL
    INC SI
    INC DI
    LOOP EXCH
    ; Display Block1
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    LEA SI,BLOCK1
    MOV CX,5
DISP1:
    MOV DL,[SI]
    MOV AH,02H
    INT 21H
    INC SI
    LOOP DISP1
    ; Display Block2
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    LEA SI,BLOCK2
    MOV CX,5
DISP2:
    MOV DL,[SI]
    MOV AH,02H
    INT 21H
    INC SI
    LOOP DISP2
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
