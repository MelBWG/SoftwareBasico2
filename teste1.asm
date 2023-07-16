;       Trabalho 2 de Software Basico   - Arquivo principal calc.asm
;       Aluno: Giulia Filippi Giannetti         190013745
;       Programa age como calculadora de seis opcoes:
;       - SOMA
;       - SUBTRACAO
;       - MULTIPLICACAO
;       - DIVISAO
;       - MOD
;       - EXPONENCIACAO
; Requisitos: Essa função principal (main) não faz operações nem entrada ou saída de dados, só chama outras funções

global _start                           ; Funcao Main

global mostra_menu                      ; Loop de escolha da operacao

global mostra_int
global pega_int16
global pega_int32

global mostra_string
global pega_string

global precisao

section .data 
; Strings do menu inicial, indicacao de overflow
pede_nome           db      'Bem Vindo. Digite seu nome: ',0dh,0ah
size_pede_nome      dw      $-pede_nome

boas_vindas1        db      'Hola, ',0
size_boas_vindas1   dw      $-boas_vindas1
boas_vindas2        db      ', bem-vindo ao programa de CALC IA-32',0dh,0ah
size_boas_vindas2   dw      $-boas_vindas2

pede_precisao       db      'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):',0dh,0ah
size_pede_precisao  dw      $-pede_precisao

menu_principal0     db      'ESCOLHA UMA OPÇÃO:',0dh,0ah
s_menu_principal0   dw      $-menu_principal0

menu_principal1     db      '- 1: SOMA',0dh,0ah
s_menu_principal1   dw      $-menu_principal1

menu_principal2     db      '- 2: SUBTRACAO',0dh,0ah
s_menu_principal2   dw      $-menu_principal2

menu_principal3     db      '- 3: MULTIPLICACAO',0dh,0ah
s_menu_principal2   dw      $-menu_principal2

menu_principal4     db      '- 4: DIVISAO',0dh,0ah
s_menu_principal2   dw      $-menu_principal2

menu_principal5     db      '- 5: EXPONECIACAO',0dh,0ah
s_menu_principal2   dw      $-menu_principal2

menu_principal6     db      '- 6: MOD',0dh,0ah
s_menu_principal2   dw      $-menu_principal2

menu_principal7     db      '- 7: SAIR',0dh,0ah
s_menu_principal2   dw      $-menu_principal2

msg_overflow        db      'OCORREU OVERFLOW',0dh,0ah
s_msg_overflow      dw      $-msg_overflow

nwln                db      0dh,0ah
s_nwln              dw      2

precisao            dw      0       ; Tem que ser iniciado porque e utilizado pela func pega_int

section .bss 
; Locais para armazenar nome do usuario e operacao
nome        resb    30
opcao_menu  resw    1

section .text
_start:         push pede_nome
                push size_pede_nome
                call mostra_string
                push nome
                push 30
                call pega_string
                push boas_vindas1
                push size_boas_vindas1
                call mostra_string
                push nome
                push 30
                call mostra_string
                push boas_vindas2
                push size_boas_vindas2
                call mostra_string
                push pede_precisao
                push size_pede_precisao
                call mostra_string
                call pega_int
                mov precisao, ax
                push eax
                call mostra_int
_exit:          mov eax,1
                mov ebx, 0
                int 0x80



; Funcao de entrada de dados int (scanf("%d"))
; Deve retornar pelo registrador EAX 
; Nota: caractere fica no topo da pilha. [ebp-6] = esp
%define resultado      [epb-2]
%define flag_negativo  [epb-3] 
%define caractere      [ebp-4]      

pega_int16:     enter 4,0                       ; resultado (4) + flag_negativo (1) + caractere (1)
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
                imul cl                         ; ah e al com resultado (ax)
                mov resultado, ax
                mov ax, 0                       ; reseta o valor de ax para evitar problemas
compara:        mov al, caractere
                sub al, 0x30                    ; transforma em int
                cmp byte flag_negativo, 1
                je subtrai
                add resultado, ax
                jmp pega
subtrai:        sub resultado, ax
                jmp pega

fim_pega_int16: mov eax, 0
                mov eax, resultado
                leave
                ret                             ; A principio ela n envia o resultado por EAX



; Funcao de entrada de dados int (scanf("%d"))
; Deve retornar pelo registrador EAX 
; Nota: caractere fica no topo da pilha. [ebp-6] = esp
%define resultado      [epb-4]
%define flag_negativo  [epb-5] 
%define caractere      [ebp-6]  

pega_int32:     enter 6,0
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
                jne mult32
                mov byte flag_negativo, 1
pega32:         mov eax, 3          
                mov ebx, 0
                mov ecx,esp
                mov edx,1
                int 0x80
                mov al, caractere
                cmp al, 0x0A                    ; compara com \n
                je fim_pega_int32
mult32:         mov eax, resultado   
                mov ecx, 10
                imul cx                         ; dx e ax com resultado (ax)
                or eax, dx
                mov resultado, eax
                mov eax, 0                      ; reseta o valor de ax para evitar problemas
compara32:      mov al, caractere
                sub al, 0x30                    ; transforma em int
                cmp byte flag_negativo,1
                je subtrai
                add resultado, ax
                jmp pega32
subtrai32:      sub resultado, ax
                jmp pega32


fim_pega_int32: mov eax, 0
                mov eax, resultado
                leave
                ret                             ; A principio ela n envia o resultado por EAX



;   Funcao de saida de valores inteiros (printf("%d"))
;   Sem valor de retorno
;   Recebe um valor por pilha que pode ser um int32 ou int16, necessário verificar a flag
;   Cuidado que nesse caso, esp aponta pro buffer de caracteres adquiridos
;   Contador conta quantos caracteres foram adicionados na pilha
%define     entrada     [ebp+8]
%define     contador    [ebp-1]
mostra_int:     enter 1,0                       ; A principio, valor suficiente para um int32 ou int16
                mov contador, 0
                cmp precisao,1
                je calculo32
calculo:        mov eax, 0
                mov edx, 0
                mov dword eax, entrada          ; Carrega valor recebido
                cmp eax, 0                      ; Verifica se e negativo
                jge divide
                push 0x2D                       ; escreve o '-' antes de tudo
                mov eax, 4
                mov ebx, 1
                mov ecx, esp
                mov edx, 1
                int 0x80
                pop dl
                mov eax, entrada
                neg eax
divide:         mov edx,0
                mov ecx, 10  
                idiv ecx                        ; Resultado em dx e ax. Utilizamos dx e deixamos ax quieto
                add dl, 0x30
                push dl                         ; nesse caso passamos a lidar com um char
                inc contador                    
                cmp eax, 0
                je mostra_buffer                ; se tivermos um caractere, o valor do contador vai ser 1
                jmp dev

mostra_buffer:  mov eax, 4                      ; Evita problemas :) podemos retirar posteriormente
                mov ebx, 1
                mov ecx, esp
                mov edx, contador               ; numero de caracteres que recebemos
                int 0x80
                mov eax, 4
                mov ebx, 1
                mov ecx, nwln
                mov edx, s_nwln
                int 0x80
                add esp, contador               ; libera a pilha dos caracteres lidos
fim_mostra_int: leave
                ret 4


; Funcao de entrada de dados string (scanf("%s"))
; Assume-se que o ponteiro e o primeiro argumento passado pra pilha
%define tam_buffer      [ebp+8]
%define ptr_buffer      [ebp+10]
pega_string:    enter 0,0
                mov eax, 3
                mov ebx, 0
                mov ecx, ptr_buffer
                mov edx, tam_buffer 
                int 0x80
                leave 
                ret 4


;   funcao de saida de strings (printf("%s"))
;   recebe por pilha duas words
%define num_chars       [ebp+8] 
%define string_begin    [ebp+10]
mostra_string:  enter 0,0
                mov eax, 4
                mov ebx, 1
                mov ecx  string_begin
                mov edx, num_chars
                int 0x80
                leave
                ret 4                           ; Dois argumentos that is