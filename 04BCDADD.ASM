; Experiment 4: Add two keyboard-entered packed BCD values
.MODEL SMALL
.STACK 100H
.DATA
    PROMPT1 DB 'Enter first 8-bit BCD number (e.g., 12): $'
    PROMPT2 DB 'Enter second 8-bit BCD number (e.g., 34): $'
    RESULT_MSG DB 13,10,'Sum: $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    ; Input first BCD number
    MOV AH, 09H
    LEA DX, PROMPT1
    INT 21H
    ; Read first digit (upper nibble)
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BL, AL
    MOV CL, 4
    SHL BL, CL
    ; Read second digit (lower nibble)
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    OR BL, AL
    ; Input second BCD number
    MOV AH, 09H
    LEA DX, PROMPT2
    INT 21H
    ; Read first digit (upper nibble)
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV BH, AL
    MOV CL, 4
    SHL BH, CL
    ; Read second digit (lower nibble)
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    OR BH, AL
    ; Perform BCD addition
    MOV AL, BL
    ADD AL, BH
    DAA
    ; Display result
    MOV AH, 09H
    LEA DX, RESULT_MSG
    INT 21H
    ; Display result as two digits
    MOV BL, AL
    MOV CL, 4
    SHR AL, CL
    ADD AL, 30H
    MOV AH, 02H
    MOV DL, AL
    INT 21H
    ; Display lower nibble
    MOV AL, BL
    AND AL, 0FH
    ADD AL, 30H
    MOV AH, 02H
    MOV DL, AL
    INT 21H
    ; Terminate program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
