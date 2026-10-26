; Experiment 5: Read a string and display its length (single digit)
.model small
.stack 100h
.data
    array db 100 dup('$')
    msg db 13,10,'Length of string: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov bl, 0
    mov si, offset array
l1:
    mov ah, 01
    int 21h
    cmp al, 13
    je stringPrint
    mov [si], al
    inc si
    inc bl
    jmp l1
stringPrint:
    mov ah, 09h
    lea dx, msg
    int 21h
    mov dl, bl
    mov ah, 2
    add dl, 48
    int 21h
    mov ah, 4Ch
    int 21h
    main endp
end main
ret
