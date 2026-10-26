; Experiment 6: Transfer a block of bytes
.MODEL SMALL
.STACK 100H
.DATA
    SOURCE DB 'HELLO'
    DEST DB 5 DUP(?)
    MSG1 DB 13,10,'Source Block : HELLO$'
    MSG2 DB 13,10,'Transferred Block : $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    ; Block transfer
    LEA SI,SOURCE
    LEA DI,DEST
    MOV CX,5
TRANSFER:
    MOV AL,[SI]
    MOV [DI],AL
    INC SI
    INC DI
    LOOP TRANSFER
    ; Display source message
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    ; Display destination message
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    ; Display transferred data
    LEA SI,DEST
    MOV CX,5
DISPLAY:
    MOV DL,[SI]
    MOV AH,02H
    INT 21H
    INC SI
    LOOP DISPLAY
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
