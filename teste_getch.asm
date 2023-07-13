global _main
section .data
resposta    db  'Voce digitou '
s_resposta  dw  $-resposta
nwln        db  0dh,0ah
contador    db  4

section .text
_main:  sub esp,4
loop:   mov eax,3
        mov ebx,0
        mov ecx,esp
        mov edx,1
        int 0x80
        mov eax,4
        mov ebx,1
        mov ecx, resposta
        mov edx,s_resposta
        int 0x80
        mov ecx,esp
        mov edx,1
        int 0x80
        mov ecx,nwln
        mov edx,2
        int 0x80
        mov eax,[contador]
        dec eax
        mov [contador],eax
        cmp contador,0
        jne loop
        mov eax 0
        mov ebx 1
        int 0x80
        