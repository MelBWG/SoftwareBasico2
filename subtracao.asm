;       Trabalho 2 de Software Basico   - Arquivo subtracao.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa realiza a subtracao de dois numeros indicados pelo usuario em 16 bits ou 32 bits
;
;       Requisitos: Essa funcao nao faz operacoes nem entrada ou saida de dados, so chama outras funcoes
;       e realiza a operacao indicada

;-----------------------------------------------------------------------------------

global subtracao

extern mostra_int16
extern mostra_int32
extern pega_int16
extern pega_int32
extern precisao

;-----------------------------------------------------------------------------------

section .text
subtracao:      cmp word [precisao],1
                je sub_lint
                sub esp, 2
                call pega_int16
                mov [esp], ax
                call pega_int16
                sub [esp], ax
                call mostra_int16
                jmp fim_sub
                
sub_lint:       sub esp, 4
                call pega_int32
                mov [esp], eax
                call pega_int32
                sub [esp], eax
                call mostra_int32
                jmp fim_sub

fim_sub:        ret