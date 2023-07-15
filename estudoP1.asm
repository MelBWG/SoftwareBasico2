;   Funcao calcula fatorial
;   Consegue calcular ate o fatorial de 8

%include "io.mac"
global _start
section .data
msg1     db     'Mostrando agora  o fatorial de ',0

section .text
_start:
        PutStr msg1
        PutInt 8
        nwln
        mov ax, 1
        mov cx, 8
op:     mul cx
        loop op
        shl edx,16
        or eax, edx
        PutLInt eax
        nwln
        mov eax,1
        mov ebx,0
        int 0x80

