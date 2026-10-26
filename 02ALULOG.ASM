; Experiment 2: ALU logical operations
.model small
.code
    mov al, 06h
    mov bl, 02h
    and al, bl
    mov cl, al
    or al, bl
    mov ch, al
    not bl
    mov dl, al
    xor al, bl
    int 3h
end
