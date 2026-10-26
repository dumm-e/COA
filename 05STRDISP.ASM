.model small
.data
    k1 db "Hello This is Kadambari here $"
.code
main proc
    mov ax, @data
    mov ds, ax
    lea dx, k1
    mov ah, 09h
    int 21h
end main
ret
