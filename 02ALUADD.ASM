; Experiment 2: ALU arithmetic operations
.model small
.code
    mov al, 06h
    mov bl, 02h
    add al, bl
    mov cl, al
    sub al, bl
    mov ch, al
    mul bl
    mov dl, al
    div bl
    int 3h
end
