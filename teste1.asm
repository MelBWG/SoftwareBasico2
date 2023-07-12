;
; Arquivo que possui função principal do programa
; Requisitos: Essa função principal (main) não faz operações nem entrada ou saída de dados, só chama outras funções

global mostra_menu  ; Loop de escolha da operacao

global mostra_string
global pega_string

global mostra_int
global pega_int

section .data 
; Strings do menu inicial, indicacao de overflow
pede_nome           db      'Bem Vindo. Digite seu nome: ',0dh,0ah
size_pede_nome      dw      $-pede_nome

boas_vindas1        db      'Hola,',0
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


section .bss 
; Locais para armazenar nome do usuario e operacao
nome        resb 30
precisao    resw 1
opcao_menu  resw 1

section .text
; Output string que pede nome
; Input nome
; Output boas vindas
; Output pergunta precisao
; Input resposta
; def loop calculadora
; Output menu de operacoes
; Input opcao
; if opcao = sair termina programa
; else chama funcao apropriada
; loop calculadora
; fim programa


; funcao de entrada de dados string
; assume-se que o ponteiro e o primeiro argumento passado pra pilha
pega_string: enter 0,0
             mov eax, 3
             mov ebx, 0
             mov edx, [ebp+8]   ; tamanho do buffer
             mov ecx, [ebp+10]  ; endereco do buffer
             int 0x80
             leave    

; funcao de entrada de dados int 16bit
; precisamos de um buffer de no minimo 6 chars,
; um sinal de negativo e mais o range do int16
; Deve retornar pelo registrador EAX 
%define buffer_int16    d
%define resultado       dword   [epb-13]
%define flag_negativo   dword   [epb-15] 
%define proximo_char    dbyte   [ebp-ecx]
pega_int:   enter 15,0 ; 11 bytes do string e mais o word que vai guardar o valor intermediario
            mov word resultado, 0
            mov word flag_negativo, 0  ; Inicia esses dois valores como 0
            cmp precisao, 1
            je pega32
            mov eax, 3
            mov ebx, 0
            mov ecx, ebp        ; inicio da string no caso 16bit
            sub ecx, 6
            mov edx, 6
            int 0x80                      ; Vamos supor '-22039'
            mov ecx, 6                    ; set loop
            cmp proximo_char, 0x2D        ; Caractere '-' se for negativo, basta subtrair ao inves de somar o valor
            mov flag_negativo, 1

converte:   mov al, proximo_char
            cmp flag_negativo, 1        ; Caractere '-' se for negativo, basta subtrair ao inves de somar o valor
            je subtrai
            sub al, 0x30 
            add word resultado, al
            mul word resultado, 10
            loop converte
            mov eax, resultado
            jmp fim_pega_int

subtrai:    sub al, 0x30
            sub word resultado, al
            mul word resultado, 10
            loop converte
            mov eax, resultado
            jmp fim_pega_int

pega32:     mov eax, 3
            mov ebx, 0
            mov ecx, ebp
            sub ecx, 11
            mov edx, 11
            int 0x80
            mov ecx, 11
            cmp proximo_char, 0x2D
            jne converte
            mov flag_negativo,1
            jmp converte


fim_pega_int: ret ; A principio ela n recebe argumento

; funcao de saida de int 16bit
mostra_int:


; divide por 10, pega modulo, subtrai por 


;funcao de saida de 
mostra_string:  enter 0,0
                mov eax, 4
                mov ebx, 1
                mov edx, [ebp+8]
                mov ecx  [ebp+10]
                int 0x80
                leave
                res 4 ; Dois argumentos that is