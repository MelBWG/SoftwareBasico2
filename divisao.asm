;       Trabalho 2 de Software Basico   - Arquivo divisao.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa realiza a divisao de dois numeros indicados pelo usuario em 16 bits ou 32 bits
;
;       Requisitos: Essa funcao nao faz operacoes nem entrada ou saida de dados, so chama outras funcoes
;       e realiza a operacao indicada

global divisao

extern mostra_int16
extern mostra_int32
extern pega_int16
extern pega_int32

extern precisao

; Pega primeiro valor, guarda em ax
; pega segundo valor, guarda em cx
; Resultado obviamente vai ser em dx e ax
; faz um shl dx 8b mais or eax,dx
; A princípio se a multiplicação
; funcao n recebe argumentos      
section .text
divisao:        enter 0,0               ; começa com pilha n iniciada
                cmp precisao,1
                je div_lint
                sub esp, 2
                pega_int16
                mov [esp], ax
                pega_int16
                mov cx, ax
                mov ax, [esp]
                idiv cx
                add esp, 2
                push ax
                call mostra_int16
                jmp fim_div
                
div_lint:       sub esp, 4
                pega_int32
                mov [esp], eax
                pega_int32
                mov ecx, eax
                mov eax, [esp]
                idiv ecx
                pop edx
                push eax
                call mostra_int32
                jmp fim_div
                
fim_div:        leave
                ret