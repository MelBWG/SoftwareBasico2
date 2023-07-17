;       Trabalho 2 de Software Basico   - Arquivo modulo.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa realiza a divisao inteira de dois numeros indicados pelo usuario em 16 bits ou 32 bits
;       e mostra o resto
;       Requisitos: Essa funcao nao faz operacoes nem entrada ou saida de dados, so chama outras funcoes
;       e realiza a operacao indicada

;-----------------------------------------------------------------------------------

global modulo

extern mostra_int16
extern mostra_int32
extern pega_int16
extern pega_int32

extern precisao

;-----------------------------------------------------------------------------------

section .text
modulo:         cmp word [precisao],1
                je mod_lint
                sub esp, 2
                call pega_int16
                mov [esp], ax
                call pega_int16
                mov ecx, 0
                mov edx, 0
                mov cx, ax
                mov ax, [esp]
                cwd 
pega_mod:       add esp, 2
                idiv cx
                push dx
                call mostra_int16
                jmp fim_mod
                
mod_lint:       sub esp, 4
                call pega_int32
                mov dword [esp], eax
                call pega_int32
                mov ecx, 0
                mov edx, 0
                mov ecx, eax
                mov eax, [esp]
                cdq
pega_mod32:     add esp, 4
                idiv ecx
                push edx
                call mostra_int32
                jmp fim_mod
                
fim_mod:        ret