; Experiment 7: Draw a rectangle and triangle using BIOS video services
.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    ; Set video mode 13h (320x200, 256 colors)
    MOV AH, 00H
    MOV AL, 13H
    INT 10H
    ; Draw rectangle: top horizontal line
    MOV CX, 50
RECT_HOR_TOP:
    MOV AH, 0CH
    MOV AL, 4
    MOV BH, 0
    MOV DX, 50
    INT 10H
    INC CX
    CMP CX, 150
    JLE RECT_HOR_TOP
    ; Bottom horizontal line
    MOV CX, 50
RECT_HOR_BOTTOM:
    MOV AH, 0CH
    MOV AL, 4
    MOV BH, 0
    MOV DX, 100
    INT 10H
    INC CX
    CMP CX, 150
    JLE RECT_HOR_BOTTOM
    ; Left vertical line
    MOV DX, 50
RECT_VER_LEFT:
    MOV AH, 0CH
    MOV AL, 4
    MOV BH, 0
    MOV CX, 50
    INT 10H
    INC DX
    CMP DX, 100
    JLE RECT_VER_LEFT
    ; Right vertical line
    MOV DX, 50
RECT_VER_RIGHT:
    MOV AH, 0CH
    MOV AL, 4
    MOV BH, 0
    MOV CX, 150
    INT 10H
    INC DX
    CMP DX, 100
    JLE RECT_VER_RIGHT
    ; Draw triangle base
    MOV CX, 200
TRI_BASE:
    MOV AH, 0CH
    MOV AL, 2
    MOV BH, 0
    MOV DX, 100
    INT 10H
    INC CX
    CMP CX, 250
    JLE TRI_BASE
    ; Triangle vertical side
    MOV DX, 100
TRI_HEIGHT:
    MOV AH, 0CH
    MOV AL, 2
    MOV BH, 0
    MOV CX, 200
    INT 10H
    DEC DX
    CMP DX, 50
    JGE TRI_HEIGHT
    ; Triangle diagonal side
    MOV CX, 200
    MOV DX, 100
TRI_HYP:
    MOV AH, 0CH
    MOV AL, 2
    MOV BH, 0
    INT 10H
    INC CX
    DEC DX
    CMP CX, 250
    JLE TRI_HYP
    ; Wait for key press
    MOV AH, 00H
    INT 16H
    ; Return to text mode
    MOV AH, 00H
    MOV AL, 03H
    INT 10H
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
