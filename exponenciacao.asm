;       Trabalho 2 de Software Basico   - Arquivo exponenciacao.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa realiza a exponenciacao de dois numeros indicados pelo usuario em 16 bits ou 32 bits
;
;       Requisitos: Essa funcao nao faz operacoes nem entrada ou saida de dados, so chama outras funcoes
;       e realiza a operacao indicada

global exponenciacao

extern mostra_int16
extern mostra_int32
extern pega_int16
extern pega_int32
extern mostra_string

extern precisao

; Pega primeiro valor, guarda em ax
; pega segundo valor, guarda em cx
; Resultado obviamente vai ser em dx e ax
; faz um shl dx 8b mais or eax,dx
; A princípio se a multiplicação
; funcao n recebe argumentos      
section .text
exponenciacao:  cmp word [precisao],1
                je mult_lint
                mov edx,0
                sub esp, 2
                call pega_int16
                mov cx, ax
                call pega_int16
                mov [esp], ax   ; contador do loop
                mov ax, cx
loop_exp:       dec word [esp]
                cmp word [esp], 1
                je fim_loop
                imul cx
                jo overflow
                jmp loop_exp
fim_loop:       add esp, 2
                push ax
                call mostra_int16
                jmp fim_exp
                
exp_lint:       sub esp, 4
                call pega_int32
                mov ecx, eax
                call pega_int32
                mov [esp], eax
                mov eax, ecx
loop_exp32:     dec dword [esp]
                cmp dword [esp],1
                je fim_loop32
                imul ecx
                jo overflow
                jmp loop_exp32
fim_loop32:     add esp,4
                push eax
                call mostra_int32
                jmp fim_exp

overflow:       add esp, 2
                cmp word [precisao], 1
                jne m_m_ovflw
                add esp, 2
m_m_ovflw:      push msg_overflow
                push word s_msg_overflow
                call mostra_string
                push nwln
                push word s_nwln
                call mostra_string      
fim_exp:        ret