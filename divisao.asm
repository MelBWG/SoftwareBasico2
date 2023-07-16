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
  
; Se o valor dos operandos é negativo, dx deve conter a extensão do sinal!!
section .text
divisao:        cmp word [precisao],1
                je div_lint
                sub esp, 2
                call pega_int16
                mov [esp], ax
                call pega_int16
                mov ecx, 0
                mov edx, 0
                mov cx, ax
                mov eax,0
                mov ax, [esp]
                cwd
cont:           add esp, 2
                idiv cx
                push ax
                call mostra_int16
                jmp fim_div
                
div_lint:       sub esp, 4
                call pega_int32
                mov [esp], eax
                call pega_int32
                mov ecx, eax
                mov edx, 0
                mov eax,0
                mov eax, [esp]
                cdq
cont32:         add esp, 4
                idiv ecx
                push eax
                call mostra_int32
                jmp fim_div
                
fim_div:        ret