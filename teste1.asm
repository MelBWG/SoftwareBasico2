;
; Arquivo que possui função principal do programa
; Requisitos: Essa função principal (main) não faz operações nem entrada ou saída de dados, só chama outras funções


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
precisao    resb 1
opcao_menu  resb 1

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

; funcao de entrada de dados int 16bit

; funcao de entrada de dados int 32bit