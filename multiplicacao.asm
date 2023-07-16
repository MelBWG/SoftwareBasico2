;       Trabalho 2 de Software Basico   - Arquivo multiplicacao.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa realiza a multiplicacao de dois numeros indicados pelo usuario em 16 bits ou 32 bits
;
;       Requisitos: Essa funcao nao faz operacoes nem entrada ou saida de dados, so chama outras funcoes
;       e realiza a operacao indicada

global multiplicacao

extern mostra_int16
extern mostra_int32
extern pega_int16
extern pega_int32

extern msg_overflow
extern s_msg_overflow
extern nwln
extern s_nwln

extern precisao

; Pega primeiro valor, guarda em ax
; pega segundo valor, guarda em cx
; Resultado obviamente vai ser em dx e ax
; faz um shl dx 8b mais or eax,dx
; A princípio se a multiplicação
; funcao n recebe argumentos      
section .text
multiplicacao:  enter 0,0               ; começa com pilha n iniciada
                cmp precisao,1
                je mult_lint
                sub esp, 2
                pega_int16
                mov [esp], ax
                pega_int16
                mov cx, ax
                mov ax, [esp]
                imul cx
                jo overflow
                add esp, 2
                push ax
                call mostra_int16
                jmp fim_mult
                
mult_lint:      sub esp, 4
                pega_int32
                mov [esp], eax
                pega_int32
                mov ecx, eax
                mov eax, [esp]
                imul ecx
                jo overflow
                add esp, 4
                push eax
                call mostra_int32
                jmp fim_soma

overflow:       push msg_overflow
                push s_msg_overflow
                call mostra_string
                push nwln
                push s_nwln
                call mostra_string
                
fim_mult:       leave
                ret