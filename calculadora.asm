;       Trabalho 2 de Software Basico   - Arquivo principal calculadora.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa age como calculadora de seis opcoes:
;       - SOMA
;       - SUBTRACAO
;       - MULTIPLICACAO
;       - DIVISAO
;       - MOD
;       - EXPONENCIACAO
;       Requisitos: Essa funcao principal (main) nao faz operacoes nem entrada ou saida de dados, 
;       so chama outras funcoes


global _start                           

global mostra_int16
global mostra_int32
global pega_int16
global pega_int32

global mostra_string
global pega_string

global precisao

;----------------------------------------------------------------------------------

section .data 

pede_nome           db      'Bem Vindo. Digite seu nome: ',0ah,0dh
size_pede_nome      equ       $-pede_nome

boas_vindas1        db      'Hola, ',0
size_boas_vindas1   equ      $-boas_vindas1
boas_vindas2        db      ', bem-vindo ao programa de CALC IA-32',0dh,0ah
size_boas_vindas2   equ      $-boas_vindas2

pede_precisao       db      'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):',0dh,0ah
size_pede_precisao  equ      $-pede_precisao

menu_principal0     db      'ESCOLHA UMA OPÇÃO:',0dh,0ah
s_menu_principal0   equ      $-menu_principal0

menu_principal1     db      '- 1: SOMA',0dh,0ah
s_menu_principal1   equ      $-menu_principal1

menu_principal2     db      '- 2: SUBTRACAO',0dh,0ah
s_menu_principal2   equ      $-menu_principal2

menu_principal3     db      '- 3: MULTIPLICACAO',0dh,0ah
s_menu_principal3   equ      $-menu_principal3

menu_principal4     db      '- 4: DIVISAO',0dh,0ah
s_menu_principal4   equ      $-menu_principal4

menu_principal5     db      '- 5: EXPONECIACAO',0dh,0ah
s_menu_principal5   equ      $-menu_principal5

menu_principal6     db      '- 6: MOD',0dh,0ah
s_menu_principal6   equ      $-menu_principal6

menu_principal7     db      '- 7: SAIR',0dh,0ah
s_menu_principal7   equ      $-menu_principal7

msg_overflow        db      'OCORREU OVERFLOW',0dh,0ah
s_msg_overflow      equ      $-msg_overflow

nwln                db      0dh,0ah
s_nwln              equ      2


;----------------------------------------------------------------------------------



;----------------------------------------------------------------------------------

section .bss 

nome        resb    30
precisao    resw    1
opcao_menu  resw    1

;-----------------------------------------------------------------------------------


%include 'soma.asm'
%include 'subtracao.asm'
%include 'multiplicacao.asm'
%include 'divisao.asm'
%include 'modulo.asm'
%include 'exponenciacao.asm'

;----------------------------------------------------------------------------------

section .text
_start:         push pede_nome
                push word size_pede_nome
                call mostra_string
                push nome
                push word 30
                call pega_string
                push boas_vindas1
                push word size_boas_vindas1
                call mostra_string
                push nome
                push word 30
                call mostra_string
                push boas_vindas2
                push word size_boas_vindas2
                call mostra_string
                push pede_precisao
                push word size_pede_precisao
                call mostra_string
                call pega_int16

                push ax
                call g_precisao

mostra_menu:    push menu_principal0
                push word s_menu_principal0
                call mostra_string

                push menu_principal1
                push word s_menu_principal1
                call mostra_string

                push menu_principal2
                push word s_menu_principal2
                call mostra_string

                push menu_principal3
                push word s_menu_principal3
                call mostra_string

                push menu_principal4
                push word s_menu_principal4
                call mostra_string

                push menu_principal5
                push word s_menu_principal5
                call mostra_string

                push menu_principal6
                push word s_menu_principal6
                call mostra_string

                push menu_principal7
                push word s_menu_principal7
                call mostra_string

                call pega_int16
                push ax
                call g_operacao
                cmp word [opcao_menu], 1d
                je chama_soma
                cmp word [opcao_menu], 2d
                je chama_sub
                cmp word [opcao_menu], 3d
                je chama_mult
                cmp word [opcao_menu], 4d
                je chama_div
                cmp word [opcao_menu], 5d
                je chama_exp
                cmp word [opcao_menu], 6d
                je chama_mod
                cmp word [opcao_menu], 7d
                je _exit
                jmp mostra_menu

_exit:          mov eax, 1
                mov ebx, 0
                int 0x80

chama_soma:     call soma
                jmp mostra_menu

chama_sub:      call subtracao
                jmp mostra_menu

chama_mult:     call multiplicacao
                jmp verifica_ovflw

chama_div:      call divisao
                jmp mostra_menu

chama_exp:      call exponenciacao
                jmp verifica_ovflw

chama_mod:      call modulo
                jmp mostra_menu

verifica_ovflw: cmp ax, 1
                je _exit
                jmp mostra_menu


g_precisao:     mov ax, [esp+4]
                mov word [precisao], ax
                ret 

g_operacao:     mov ax, [esp+4]
                mov word [opcao_menu], ax
                ret
;----------------------------------------------------------------------------------

; Funcao de entrada de dados int (scanf("%d"))
; Deve retornar pelo registrador EAX 
; Nota: caractere fica no topo da pilha. [ebp-6] = esp
%define resultado      [ebp-2]
%define flag_negativo  [ebp-3] 
%define caractere      [ebp-4]      

pega_int16:     enter 4,0                       ; resultado (2) + flag_negativo (1) + caractere (1)
                mov eax, 0
                mov dword resultado, 0
                mov byte flag_negativo, 0       ; Inicia esses dois valores como 0
                mov eax, 3
                mov ebx, 0
                mov ecx, esp                    ; inicio da string no caso 16bit
                mov edx, 1
                int 0x80                        ; Pegou primeiro caractere
                mov al, caractere               ; set loop
                cmp al, 0x2D                    ; Caractere '-' se for negativo, basta subtrair ao inves de somar o valor
                jne mult
                mov byte flag_negativo, 1
pega:           mov eax, 3          
                mov ebx, 0
                mov ecx,esp
                mov edx,1
                int 0x80
                mov al, caractere
                cmp al, 0x0A                    ; compara com \n
                je fim_pega_int16
mult:           mov ax, resultado   
                mov cx, 10
                imul cx                         ; ah e al com resultado (ax)
                mov resultado, ax
                mov ax, 0                       ; reseta o valor de ax para evitar problemas
compara:        mov al, caractere
                sub ax, 0x30                    ; transforma em int
                cmp byte flag_negativo, 1
                je subtrai
                add resultado, ax
                jmp pega
subtrai:        sub resultado, ax
                jmp pega

fim_pega_int16: mov eax, 0
                mov ax, resultado
                leave
                ret                             ; A principio ela envia o resultado por AX



; Funcao de entrada de dados int (scanf("%d"))
; Deve retornar pelo registrador EAX 
; Nota: caractere fica no topo da pilha. [ebp-6] = esp
%define resultado32      [ebp-4]
%define flag_negativo32  [ebp-5] 
%define caractere32      [ebp-6]  

pega_int32:     enter 6,0                       ; resultado (4) + flag_negativo (1) + caractere (1)
                mov eax, 0
                mov dword resultado32, 0
                mov byte flag_negativo32, 0     ; Inicia esses dois valores como 0
                mov eax, 3
                mov ebx, 0
                mov ecx, esp                   
                mov edx, 1
                int 0x80                        ; Pegou primeiro caractere
                mov al, caractere32             
                cmp al, 0x2D                    ; Caractere '-' se for negativo, basta subtrair ao inves de somar o valor
                jne mult32
                mov byte flag_negativo32, 1
pega32:         mov eax, 3          
                mov ebx, 0
                mov ecx,esp
                mov edx,1
                int 0x80
                mov al, caractere32
                cmp al, 0x0A                    ; compara com \n
                je fim_pega_int32
mult32:         mov eax, resultado32   
                mov ecx, 10
                imul ecx                        ; edx e eax com resultado (eax)
                mov resultado32, eax
                mov eax, 0                      ; reseta o valor de eax para evitar problemas
compara32:      mov al, caractere32
                sub eax, 0x30                   ; transforma em int
                cmp byte flag_negativo32,1
                je subtrai32
                add resultado32, eax
                jmp pega32
subtrai32:      sub resultado32, eax
                jmp pega32


fim_pega_int32: mov eax, 0
                mov eax, resultado32
                leave
                ret                             ; A principio ela envia o resultado por EAX



;   Funcao de saida de valores inteiros (printf("%d"))
;   Sem valor de retorno
;   Recebe um valor por pilha (int16)
;   Cuidado que nesse caso, esp aponta pro buffer de caracteres adquiridos
;   Contador conta quantos caracteres foram adicionados na pilha
%define     entrada16     [ebp+8]
%define     contador16    [ebp-1]
mostra_int16:   enter 1,0                       
                mov byte contador16, 0
calculo16:      mov eax, 0
                mov edx, 0
                mov word ax, entrada16          ; Carrega valor recebido
                cmp ax, 0                       ; Verifica se e negativo
                jge divide16
                sub esp,1
                mov byte [esp], 0x2D            ; escreve o '-' antes de tudo
                mov eax, 4
                mov ebx, 1
                mov ecx, esp
                mov edx, 1
                int 0x80
                add esp, 1
                mov ax, entrada16
                neg ax
                cwd
divide16:       mov edx, 0
                mov cx, 10  
                div cx                          ; Resultado em dx e ax. Utilizamos dx e deixamos ax quieto
                add dx, 0x30
                sub esp, 1
                mov byte [esp],dl               ; nesse caso passamos a lidar com um char
                add byte contador16, 1                    
                cmp eax, 0
                jle mostra_buffer16             ; se tivermos um caractere, o valor do contador vai ser 1
                jmp divide16

mostra_buffer16:mov eax, 4                    
                mov ebx, 1
                mov ecx, esp
                mov dl, contador16              ; numero de caracteres que recebemos
                int 0x80
                mov eax, 4
                mov ebx, 1
                mov ecx, nwln
                mov edx, s_nwln
                int 0x80
                mov eax,0
                mov al, contador16
                add esp, eax                    ; libera a pilha dos caracteres lidos
                leave
                ret 2


;   Funcao de saida de valores inteiros (printf("%d"))
;   Sem valor de retorno
;   Recebe um valor por pilha (int32)
;   Cuidado que nesse caso, esp aponta pro buffer de caracteres adquiridos
;   Contador conta quantos caracteres foram adicionados na pilha
%define     entrada32     [ebp+8]
%define     contador32    [ebp-1]
mostra_int32:   enter 1,0                       ; A principio, valor suficiente para um int32 ou int16
                mov byte contador32, 0
calculo32:      mov eax, 0
                mov edx, 0
                mov dword eax, entrada32        ; Carrega valor recebido
                cmp eax, 0                      ; Verifica se e negativo
                jge divide32
                sub esp,1
                mov byte [esp], 0x2D            ; escreve o '-' antes de tudo
                mov eax, 4
                mov ebx, 1
                mov ecx, esp
                mov edx, 1
                int 0x80
                inc esp
                mov eax, entrada32
                neg eax
divide32:       mov edx,0
                mov ecx, 10  
                idiv ecx                        ; Resultado em dx e ax. Utilizamos dx e deixamos ax quieto
                add dx, 0x30
                sub esp, 1
                mov byte [esp],dl               ; nesse caso passamos a lidar com um char
                inc byte contador32             ; se tivermos um caractere, o valor do contador vai ser 1
                cmp eax, 0
                je mostra_buffer32
                jmp divide32

mostra_buffer32:mov eax, 4                      
                mov ebx, 1
                mov ecx, esp
                mov dl, contador32              ; numero de caracteres que recebemos
                int 0x80
                mov eax, 4
                mov ebx, 1
                mov ecx, nwln
                mov edx, s_nwln
                int 0x80
                mov eax,0
                mov al, contador32
                add esp, eax                    ; libera a pilha dos caracteres lidos
                leave
                ret 4

add_zero32:     sub esp,1
                mov byte [esp], 0x30
                inc byte contador32
                jmp mostra_buffer32


; Funcao de entrada de dados string (scanf("%s"))
; Assume-se que o ponteiro e o primeiro argumento passado pra pilha
%define tam_buffer      [ebp+8]
%define ptr_buffer      [ebp+10]
%define contador        [ebp-2]
%define contador_ptr    [ebp-6]
pega_string:    enter 6,0
                mov eax, ptr_buffer
                mov contador_ptr, eax           ; move o ponteiro para o buffer
pega_char:      mov eax, 3
                mov ebx, 0
                mov ecx, contador_ptr
                mov edx, 1
                int 0x80
                inc word contador
                mov eax, contador_ptr
                inc dword contador_ptr
                cmp byte [eax], 0ah
                je nl
                mov ax, tam_buffer
                cmp word contador, ax
                je clean_exit
                jmp pega_char             
exit:           leave 
                ret 6

clean_exit:     sub esp, 1
readcharl:      mov eax, 3
                mov ebx, 0
                mov ecx, esp
                mov edx, 1
                int 0x80
                mov al, [esp]  
                cmp byte al, 0ah
                jne readcharl
                add esp, 1
                jmp exit

nl:             mov byte [eax],0
                jmp exit


;   Funcao de saida de strings (printf("%s"))
;   Recebe por pilha duas words
%define num_chars       [ebp+8] 
%define string_begin    [ebp+10]
mostra_string:  enter 0,0
                mov eax, 4
                mov ebx, 1
                mov ecx, string_begin
                mov dx, num_chars
                int 0x80
                leave
                ret 6                          

