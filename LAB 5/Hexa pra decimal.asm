; Imprime na tela os números A a F (hexadecimal) em decimal

org 0           ; Definição do ponto de origem para o código

; Verifica a tecla pressionada
mov ah, 0       ; Interrupção para verificar a tecla pressionada
int 16h         ; Chama a interrupção de teclado para armazenar o valor pressionado em AL

; Converte os caracteres de A a F (hexadecimal) para seus valores decimais
sub al, 11h     ; Subtrai 11h de AL para que A (41h) se torne 30h, B (42h) se torne 31h, e assim por diante até F
mov bl, al      ; Copia o valor de AL para BL, pois DL será usado para imprimir os dígitos

; Imprime o primeiro dígito '1' para valores A, B, C, D, E, F (decimais 10-15)
mov ah, 2       ; Função de impressão de caractere
mov dl, 31h     ; Caractere '1' em ASCII (representando o primeiro dígito)
int 21h         ; Chama a interrupção para imprimir o número '1'

; Imprime o último dígito (0 a 5) correspondente ao número decimal
mov ah, 2       ; Função de impressão de caractere
mov dl, bl      ; Move o valor decimal (0-5) de BL para DL
int 21h         ; Chama a interrupção para imprimir o último dígito (0-5)

; Fim do prog

