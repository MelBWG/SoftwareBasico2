global _start
section .data
resposta    db  'Voce digitou '
s_resposta  dw  $-resposta
nwln        db  0dh,0ah
contador    dw  2

section .bss
valores     resb  4

section .text
_start: mov eax,0
        push eax        ; adiciona 32 bytes na pilha
loop:                         ; caractere
        mov eax,3
        mov ebx,0
        mov ecx,esp     ; read one byte from console and put it in pile
        mov edx,1
        int 0x80
        pop ax
        shr ax, 8       ; shift de 1 byte
        sub byte ax,0x30
        ;mov cx, 10
        ;mul cx
        add word [esp], ax
        ;mov ecx, [contador]
        ;dec ecx
        ;mov [contador],ecx
        ;cmp ecx,0
        ;jne loop
        mov eax,4
        mov ebx,1
        mov ecx, resposta
        mov edx,s_resposta
        int 0x80
        pop ax  ; Resultado
        ;mov cx, 10
 loop2: mov dx,0
        ;cmp ax,0
        ;je exit
        ;div cx
        add word ax, 0x30
        shl ax, 8
        push ax
        mov eax,4
        mov ebx,1
        mov ecx,esp
        mov edx,1
        int 0x80
        ;pop cx
        ;cmp ax,0
        ;jne loop2
        ;push dx
        ;mov eax,4
        ;mov ebx,1
        ;mov ecx,esp
        ;mov edx,1
        ;int 0x80
        pop dx
        mov ecx,nwln
        mov edx,2
        int 0x80
exit:   mov eax,0
        mov ebx,1
        int 0x80
        