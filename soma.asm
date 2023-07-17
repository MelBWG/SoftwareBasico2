;       Trabalho 2 de Software Basico   - Arquivo soma.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa realiza a soma de dois numeros indicados pelo usuario em 16 bits ou 32 bits
;
;       Requisitos: Essa funcao nao faz operacoes nem entrada ou saida de dados, so chama outras funcoes
;       e realiza a operacao indicada. Faz operacao com sinal

global soma

extern mostra_int16
extern mostra_int32

extern pega_int16
extern pega_int32

extern precisao


;   Funcao nao recebe argumentos, retorno apenas por print na tela
section .text
soma:           cmp word [precisao],1
                je soma_lint
                push ax
                call pega_int16
                mov word [esp], ax
                call pega_int16
                add word [esp], ax
                call mostra_int16
                jmp fim_soma
                
soma_lint:      sub esp, 4
                call pega_int32
                mov [esp], eax
                call pega_int32
                add [esp], eax
                call mostra_int32
                jmp fim_soma

fim_soma:       ret