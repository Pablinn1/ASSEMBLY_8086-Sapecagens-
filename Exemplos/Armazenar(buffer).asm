

    ORG 100h
    
    JMP INICIO
    
    BUF1 DB 16 DUP (?) ; Cria uma variavel com 16 bytes com caracteres ? em sua faixa 
    BUF2 DB 16 DUP (?) 
    LIN DB 0Ah,0Dh,24h ; Caracteres de Nova linha, (Enter): Mover o cursor pra linha atual e ($): Termino do print de strings  
    
    INICIO:
    
    MOV BUF1, 14        ; Contexto: Ocupar espaço no buffer para controlar o numero de inputs (errado pois n consigo injetar valor diretamente na memoria)

    MOV DX, OFFSET BUF1 ; Aponto o deslocamento diretamente pra posição inicial do buffer
    
    CALL LINE           ; Chamo a função LINE
    
    MOV DX, OFFSET LIN ; Após pedir o input do teclado, aponto o deslocamento para o primeiro byte de LIN
    
    MOV AH, 09h ; Chamo uma interrupção para imprimir strings 
    INT 21h     ; Essa função necessita de um '$' no final, por isso o 24h no buffer Lin
    
    MOV BUF2, 14
    MOV DX, OFFSET BUF2 ; Aponto o deslocamento diretamente no primeiro byte do buf2 
    
    CALL LINE ; Chamo a int de input do teclado 
    
    .EXIT
    
    LINE: ;Responsável por chamar a interrupção 
    
    MOV AH,0AH ; Essa interrupção salva os inputs do teclado diretamente na string que esta sendo apontada                   
    INT 21H    ; Os primeiros 2 bytes são: 1-Capacidade do Buffer, 2-Quantidade de inputs , o ultimo byte vai ser um 0DH pra indicar o fim mdo imput
               ; No caso desse código o primeiro byte vai ser o numero 14
               ; Essa interrupção entende "ENTER" como fim da interrupção 
    RET 
    
    END 
