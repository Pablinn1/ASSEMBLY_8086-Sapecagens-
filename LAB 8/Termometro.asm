    
    #start=thermometer.exe#
     
     ORG 100h
    JMP START
    
    LIN  DB  0AH,0AH, 0DH, 24H
    MSG1 DB 'Temperatura em Farenheits: ', 00h, '$'
     
    START:
    IN AL,125   ; Recebo o valor do termômetro e guarda em AL
    
    PUSH AX ; Salva AL na pilha (medo de perder no processo)
    
    CALL Conversor_Temp ; Chamo a função de conversor de temp.
    CALL MENSAGEM
    CALL PRINT
    CALL LINHA
    
    POP AX
    
    CMP AL,22 ; Compara o valor de AL com 22 (graus)
    
    JL LOW    ; Caso seja menor que 22, vou pra LOW
     
    CMP AL,55  
              
    JLE _LOOP ; Salto pro _Loop caso AL seja menor ou igual a 55
    
    JG HIGH   ; Caso 55 seja maior, pulo pra HIGH 
    
    LOW:
    MOV AL,1 ; Caso esteja abaixo de 22, ativo o fogão
    OUT 127,AL 
    JMP _LOOP
    
    HIGH:    ; Caso esteja acima de 22, ativo o fogão
    MOV AL,0   
    OUT 127,AL 
   
    _LOOP:  
    JMP START 

    ;Função de coversão (optei por trabalhar em hexa)     
    Conversor_Temp:
    MOV BL, 09h     
    MUL BL 
    DIVISION:
    MOV BL, 05h
    DIV BL 
    SOMA:
    ADD AL, 20h 
   
   PART_DIGITS:
    XOR AH, AH  ; Reseto os valores de AH para trabalhar com números fechados
    MOV BL, 0AH  
    DIV BL      ; Divido o número em duas partes
    MOV BH, AH  ; A parte menos significativas de todas guardo em BH
    XOR AH, AH
     
    PART_DIGITS2:
    MOV BL, 0AH ; Novamente divido o número em duas partes
    DIV BL
    MOV CH, AH 
    MOV CL, AL
    RET
    
    PRINT:     ;Transformo todos os números em ASCII e imprimo na tela
    ADD BH, 30H
    ADD DH, 30H
    ADD CL, 30H
    ADD CH, 30H
     
    MOV DL, CL
    MOV AH, 02H
    INT 21h
    
    MOV DL, CH
    MOV AH, 02H
    INT 21h
    
    MOV DL, BH
    MOV AH, 02H
    INT 21h 

    XOR AX, AX
    RET
    
    LINHA:
    MOV DX, OFFSET LIN
    MOV AH, 09H
    INT 21H
    XOR DX, DX
    XOR AX, AX
    RET

    MENSAGEM:
    MOV DX, OFFSET MSG1
    MOV AH, 09H
    INT 21H
    RET