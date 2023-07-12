;


global soma

extern mostra_int
extern pega_int
extern precisao

section .text
; Recebe dois numeros por pilha, tem que verificar se 
soma:   enter 0,0
        cmp precisao,1
        je soma_lint


soma_lint: