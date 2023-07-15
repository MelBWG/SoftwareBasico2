;

global soma

extern mostra_int
extern pega_int
extern precisao

section .text
soma:   enter 0,0
        cmp precisao,1
        je soma_lint


soma_lint:



fim_soma: leave
          ret