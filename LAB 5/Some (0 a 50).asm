; Soma de números (0 a 99) - Utilizando números de 0 a 50

org 100h

; Início do programa
oper_1:

    ; Lê o primeiro número (primeiro dígito)
    mov ah, 0
    int 16h                 ; Aguarda entrada do teclado

    mov ah, 0Eh
    int 10h                 ; Exibe o caractere digitado

    sub al, 30h             ; Converte o ASCII para número
    mov cl, al              ; Salva o número em CL

    mov ah, 0
    int 16h                 ; Aguarda nova entrada do teclado

    cmp al, 2bh             ; Verifica se é o caractere '+'
    je oper_2               ; Se for '+', pula para a próxima parte

second_digit:

    mov ah, 0Eh
    int 10h                 ; Exibe o caractere digitado

    sub al, 30h             ; Converte o ASCII para número
    mov dl, al              ; Salva o número em DL

    ; Calcula o número completo no primeiro operando
    mov al, cl
    mov bl, 0ah
    mul bl                  ; Multiplica o primeiro dígito por 10
    mov cl, al              ; Salva o resultado em CL
    add cl, dl              ; Soma o segundo dígito ao número

oper_2:

    ; Exibe o operador '+'
    mov ah, 2
    mov dl, '+'
    int 21h

    ; Lê o segundo número (primeiro dígito)
    mov ah, 0
    int 16h

    mov ah, 0Eh
    int 10h                 ; Exibe o caractere digitado

    sub al, 30h             ; Converte o ASCII para número
    mov dl, al              ; Salva o número em DL

    mov ah, 0
    int 16h                 ; Aguarda nova entrada do teclado

    cmp al, 0dh             ; Verifica se é o caractere 'Enter'
    je Soma                 ; Se for 'Enter', pula para soma final

second_digit_2:

    mov ah, 0Eh
    int 10h                 ; Exibe o caractere digitado

    sub al, 30h             ; Converte o ASCII para número
    mov dh, al              ; Salva o número em DH

    mov al, dl
    mov bl, 0ah
    mul bl                  ; Multiplica o primeiro dígito por 10
    mov bl, al              ; Salva o resultado em BL

    add bl, dh              ; Soma o segundo dígito ao número
    jmp Soma2               ; Pula para a soma secundária

Soma:

    ; Soma os dois números
    add cl, dl
    mov al, cl

    ; Divide o resultado por 10 para exibir os dígitos separadamente
    mov ah, 0               ; Zera o registrador AH
    mov bl, 10              ; Divisor
    div bl                  ; Divide AL por 10

    mov bl, ah              ; Parte alta (dezena) em BL
    mov cl, al              ; Parte baixa (unidade) em CL

    ; Exibe o sinal '='
    mov ah, 2
    mov dl, '='
    int 21h

    ; Exibe a parte alta (dezena)
    add cl, 48              ; Converte para ASCII
    mov dl, cl
    mov ah, 2
    int 21h

    ; Exibe a parte baixa (unidade)
    add bl, 48              ; Converte para ASCII
    mov dl, bl
    mov ah, 2
    int 21h

    ; Termina o programa
    mov ah, 4Ch
    mov al, 0
    int 21h

Soma2:

    ; Soma os dois números (caso haja um segundo dígito no segundo número)
    add cl, bl
    mov al, cl

    ; Divide o resultado por 10 para exibir os dígitos separadamente
    mov ah, 0
    mov bl, 10
    div bl

    mov bl, ah              ; Parte alta (dezena) em BL
    mov cl, al              ; Parte baixa (unidade) em CL

    ; Exibe o sinal '='
    mov ah, 2
    mov dl, '='
    int 21h

    ; Exibe a parte alta (dezena)
    add cl, 48
    mov dl, cl
    mov ah, 2
    int 21h

    ; Exibe a parte baixa (unidade)
    add bl, 48
    mov dl, bl
    mov ah, 2
    int 21h

    ; Termina o programa
    mov ah, 4Ch
    mov al, 0
    int 21h