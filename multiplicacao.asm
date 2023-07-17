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
extern mostra_string

extern _exit

extern precisao

; Pega primeiro valor, guarda em ax
; pega segundo valor, guarda em cx
; Resultado obviamente vai ser em dx e ax
; faz um shl dx 8b mais or eax,dx
; A princípio se a multiplicação
; funcao n recebe argumentos      
section .text
multiplicacao:  cmp word [precisao],1
                je mult_lint
                mov edx,0
                sub esp, 2
                call pega_int16
                mov [esp], ax
                call pega_int16
                mov cx, ax
                mov ax, [esp]
                add esp,2
                imul cx
                jo overflow
                push ax
                call mostra_int16
                jmp fim_mult
                
mult_lint:      sub esp, 4
                call pega_int32
                mov [esp], eax
                call pega_int32
                mov ecx, eax
                mov eax, [esp]
                add esp,4
                imul ecx
                jo overflow
                push eax
                call mostra_int32
                jmp fim_mult

overflow:       push msg_overflow
                push word s_msg_overflow
                call mostra_string
                push nwln
                push word s_nwln
                call mostra_string 
                mov eax, 1
                
fim_mult:       ret