;       Trabalho 2 de Software Basico   - Arquivo exponenciacao.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa realiza a exponenciacao de dois numeros indicados pelo usuario em 16 bits ou 32 bits
;
;       Requisitos: Essa funcao nao faz operacoes nem entrada ou saida de dados, so chama outras funcoes
;       e realiza a operacao indicada

;-----------------------------------------------------------------------------------

global exponenciacao

extern mostra_int16
extern mostra_int32
extern pega_int16
extern pega_int32
extern mostra_string

extern precisao

;-----------------------------------------------------------------------------------   

section .text
exponenciacao:  cmp word [precisao],1
                je exp_lint
                mov edx,0
                sub esp, 2                  ; adiciona espaco na pilha pro segundo operador
                call pega_int16
                mov [esp], ax     
                sub esp,2             
                call pega_int16
                mov [esp], ax               ; contador do loop
                mov ax, [esp+2]
                mov cx, ax
loop_exp:       cmp word [esp], 1
                je fim_loop
                sub word [esp], 1
                imul cx
                jo overflow_exp
                jmp loop_exp
fim_loop:       add esp, 4
                push ax
                call mostra_int16
                jmp fim_exp
                
exp_lint:       sub esp, 4
                call pega_int32
                mov [esp], eax
                sub esp, 4
                call pega_int32
                mov [esp], eax
                mov eax, [esp+4]
                mov ecx, eax
loop_exp32:     cmp dword [esp],1
                je fim_loop32
                sub dword [esp], 1
                imul ecx
                jo overflow_exp
                jmp loop_exp32
fim_loop32:     add esp,8
                push eax
                call mostra_int32
                jmp fim_exp

overflow_exp:   add esp, 4
                cmp word [precisao], 1
                jne m_m_ovflw
                add esp, 4
m_m_ovflw:      push msg_overflow
                push word s_msg_overflow
                call mostra_string
                push nwln
                push word s_nwln
                call mostra_string    
                mov eax, 1
                  
fim_exp:        ret