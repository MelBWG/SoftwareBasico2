section .data
cte1        dq  1.8
valor       dq 30.5
res_correto dq  86.9
cte2        dw  32
msg_errado      db   'Valor incorreto',0dh,0ah
s_msg_errado    dw  $-msg_errado
msg_certo       db   'Valor correto',0dh,0ah
s_msg_certo     dw  $-msg_certo

section .bss
resultado resq  1

section .text
global _start

_start: finit     
        fld  qword  [valor]
        fld   qword  [cte1]
        fmulp   ;st[0] tem o 1.8*C
        fild  word  [cte2]
        faddp
        fld  qword   [res_correto]
        fcomp   st0,st1
        fstsw   ax
        cmp ax, 0100000000000000B
        je correto
errado: 
        mov eax,4
        mov ebx,1
        mov ecx, msg_errado
        mov edx, s_msg_errado
        int 0x80
        jmp exit

correto:
        mov eax,4
        mov ebx,1
        mov ecx, msg_certo
        mov edx, s_msg_certo
        int 0x80
        jmp exit

exit:   mov eax,1
        mov ebx,0
        int 0x80

