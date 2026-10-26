; Experiment 9: Display the 8086 flags register bits
.MODEL SMALL
.DATA
    MSG DB 0DH,0AH,"-- -- -- OF DF IF TF SF ZF",0DH,0AH
        DB "-- AF -- PF -- CF $"
    NEWL DB 0DH,0AH,"$"
    FLAG DW ?
.CODE
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX

    MOV DX, OFFSET MSG
    MOV AH, 09H
    INT 21H
    MOV DX, OFFSET NEWL
    MOV AH, 09H
    INT 21H

    CLI
    STC
    STD
    PUSHF
    POP BX
    MOV FLAG, BX
    MOV CX, 16
    MOV BX, 8000H
LOOPS:
    MOV AX, FLAG
    AND AX, BX
    JZ ZERO
    MOV DL, 31H
    MOV AH, 02H
    INT 21H
    JMP SPACE
ZERO:
    MOV DL, 30H
    MOV AH, 02H
    INT 21H
SPACE:
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV AH, 02H
    INT 21H
    ROR BX, 1
    LOOP LOOPS

    MOV AH, 4CH
    INT 21H
END START
