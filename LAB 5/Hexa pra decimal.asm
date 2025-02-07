; Imprime na tela os n�meros A a F (hexadecimal) em decimal

org 0           ; Defini��o do ponto de origem para o c�digo

; Verifica a tecla pressionada
mov ah, 0       ; Interrup��o para verificar a tecla pressionada
int 16h          ; Chama a interrup��o de teclado para armazenar o valor pressionado em AL

; Converte os caracteres de A a F (hexadecimal) para seus valores decimais
sub al, 11h      ; Subtraio 11h de AL para que A (41h) se torne 30h, B (42h) se torne 31h , e assim por diante at� F
mov bl, al       ; Copio o valor de AL para BL, pois o DL ser� usado para imprimir os d�gitos

; Imprime o primeiro d�gito '1' para valores A, B, C, D, E, F (decimais 1-5)
mov ah, 2        ; Fun��o de impress�o de caractere
mov dl, 31h      ; Caractere '1' em ASCII (representando o primeiro d�gito)
int 21h          ; Chama a interrup��o para imprimir o n�mero '1'

; Imprime o �ltimo d�gito (0 a 5) correspondente ao n�mero decimal
mov ah, 2        ; Fun��o de impress�o de caractere
mov dl, bl       ; Movo o valor decimal (0-5) de BL para DL
int 21h          ; Chama a interrup��o para imprimir o �ltimo d�gito (0-5)

; Fim do programa
