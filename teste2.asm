global _start

section .data
nwln    db  0ah,0dh
contador dw   2
section .bss
soma    resw  1

section .text
_start: mov word [soma],0
        mov eax,0
pega:   mov ecx,10
        mul cl
        add [soma], ax
        mov ax,0
        push ax
        mov eax,3
        mov ebx,0
        mov ecx,esp
        mov edx,1
        int 0x80
        pop ax 
        sub ax,0x30
        sub word [contador],1
        cmp word [contador],1
        jge pega
        add [soma], ax
dev:    mov ax, [soma]
        cmp ax,0
        je exit
        mov edx,0
        mov ecx, 10  
        div cx
        mov [soma],ax
        add dx, 0x30
        push dx
        mov eax,4
        mov ebx,1
        mov ecx,esp
        mov edx,1
        int 0x80
        jmp dev
exit:   mov eax,4
        mov ebx,1
        mov ecx,nwln
        mov edx,2
        int 0x80
        pop ax
        mov eax,1
        mov ebx,0
        int 0x80