; Experiment 3: Manual's "ASCII to BCD" snippet
; The code actually converts a packed BCD byte to two displayed ASCII digits.
.model small
.data
    asctl db 037h ; Packed BCD value: decimal 37
.code
    mov ax, @data
    mov ds, ax
    mov al, asctl
    mov ah, al
    and ah, 0F0h
    mov cl, 4
    shr ah, cl
    add ah, 30h
    and al, 0Fh
    add al, 30h
    mov dl, ah
    mov ah, 02h
    int 21h
    mov dl, al
    mov ah, 02h
    int 21h
    mov ah, 4Ch
    int 21h
end
