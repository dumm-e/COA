; Experiment 3: Convert hexadecimal word to decimal digits for display
org 100h
.model small
.data
    hex dw 0FFFFh
    counter db 0
.code
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    mov ax, hex
    mov bx, 000Ah
L:
    inc counter
    div bx
    push dx
    cmp ax, 0
    mov dx, 00h
    je exit
    jmp L
exit:
    mov cl, counter
    mov ch, 00h
L1:
    pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    loop L1
    ; Terminate program
    mov ah, 4Ch
    int 21h
    ret
end
