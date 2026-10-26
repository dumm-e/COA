; Experiment 3: Convert packed BCD byte to two ASCII digits
.model small
.data
    bcd db 42h
    asci1 db ?
    asci2 db ?
.code
start:
    mov ax, @data
    mov ds, ax
    mov al, bcd
    ; Get upper nibble (tens digit)
    mov ah, al
    and ah, 0F0h
    mov cl, 4
    shr ah, cl
    add ah, 30h
    mov asci1, ah
    ; Get lower nibble (units digit)
    and al, 0Fh
    add al, 30h
    mov asci2, al
    ; Display tens digit
    mov dl, asci1
    mov ah, 02h
    int 21h
    ; Display units digit
    mov dl, asci2
    mov ah, 02h
    int 21h
    ; Exit
    mov ah, 4Ch
    int 21h
end start
