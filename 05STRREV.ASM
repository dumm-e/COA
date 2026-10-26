; Experiment 5: Reverse and display a fixed string
.model small
.stack 100h
.data
    string db 'Hi Kadambari'
.code
main proc
    mov ax, @data
    mov ds, ax
    mov si, offset string
    mov cx, 12
loop1:
    mov bx, [si]
    push bx
    inc si
    loop loop1
    mov cx, 12
loop2:
    pop dx
    mov ah, 02h
    int 21h
    loop loop2
main endp
end main
