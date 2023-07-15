global _start

section .data
nom_arqu    db  'tentativa1.txt',0
s_nom_arqu  dw  $-nom_arqu
sample      db  'Hello World!0'
s_sample    dw  $-sample


section .text
_start:     mov eax,8
            mov ebx, nom_arqu
            mov ecx, 0777
            int 0x80
            push eax
            mov eax, 4
            mov ebx, [esp]
            mov ecx, sample
            mov edx, s_sample
            int 0x80
            pop ebx
            mov eax, 6
            int 0x80
            mov eax, 1
            mov ebx, 0
            int 0x80


