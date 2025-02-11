    
    #start=thermometer.exe#
     
     ORG 100h
    JMP SETUP
    
    VAR1 DB 10, 0, 10 DUP ('$')
    LIN  DB  0AH,0AH, 0DH, 24H
    MSG1 DB 'Temperatura em Farenheits: ', 00h, '$'
    
    
    SETUP:
    MOV DX, OFFSET [VAR1] ; Aponto DX para VAR1 (pegar e printar strings)
    MOV DI, OFFSET [VAR1] ; Aponto DI para VAR1 (interagir algebricamente)

    CALL GET_VAR          ; Chamo a função de input de variável
    
    CALL LINHA
    
    CALL TEST_VAR
    
    MOV DX, OFFSET [VAR1] 
    
    MOV DI, OFFSET [VAR1]
    
    CALL GET_VAR
    
    CALL LINHA 
    
    CALL TEST_VAR   ; O teste serve para saber com quantas casas decimais estamos trabalhando no INPUT
    
    START:
    IN AL,125 
    
    PUSH AX
    
    CALL Conversor_Temp
    
    CALL MENSAGEM
    
    CALL PRINT
    
    CALL LINHA
    
    POP AX
    
    MOV DI, OFFSET [VAR1]
    
    ;MOV CH, [VAR1+7]
    
    CMP AL,[VAR1+6] 
    
    JL LOW
    
    MOV DI, OFFSET [VAR1]
    
    ;MOV CH, [VAR1+7]
       
    CMP AL,[VAR1+8]  
              
    JLE _LOOP
    
    JG HIGH   
    
    LOW:
    MOV AL,1
    OUT 127,AL 
    JMP _LOOP
    
    HIGH: 
    MOV AL,0   
    OUT 127,AL 
   
    _LOOP:  
    JMP START 
         
    Conversor_Temp:
    MOV BL, 09h
    MUL BL
    DIVISION:
    MOV BL, 05h
    DIV BL 
    SOMA:
    ADD AL, 20h 
   
   PART_DIGITS:
    XOR AH, AH
    MOV BL, 0AH
    DIV BL
    MOV BH, AH 
    XOR AH, AH
    
    PART_DIGITS2:
    MOV BL, 0AH
    DIV BL
    MOV CH, AH
    MOV CL, AL
    RET
    
    PRINT:

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
     
    GET_VAR:
    MOV AH, 0AH
    INT 21H
    RET 
    
    TEST_VAR: 
    MOV AL, [DI+1] ; Movo o conteúdo da segunda posição para al 
    ; Conteúdo esse sendo o números de inputs feitos no teclado
    CMP AL, 3 
    JE TRAT_VAR1
    CMP AL, 2  ; Comparo com 3, 2 e 1, para saber com quantas casas decimais estou trabalhando 
    JE TRAT_VAR2
    CMP AL, 1
    JE TRAT_VAR3

    TRAT_VAR1:   ; Caso esteja trabalhando com 3 casas decimais                    
    MOV DI, OFFSET [VAR1+2]
    MOV AL, [DI] ; Movo o conteúdo da terceira posição (msb) pra al
    SUB AL, 30H  ; Transformo em hexa
    MOV BL, 100  ; Multiplico por 100
    MUL BL
    
    MOV CH, AL  ; Guardo em CH
    
    MOV AL, [DI+1]
    SUB AL, 30H
    MOV BL, 10 ; A parte da dezena multiplico por 10 e guardo em CL
    MUL BL
    
    MOV CL, AL
    
    MOV AL, [DI+2]
    SUB AL, 30H
    MOV BL, 1
    MUL BL
    
    MOV DL, AL
    
    ADD CH, CL
    ADD CH, DL  ; Faço a soma entre os conteúdos guardados
    
    MOV DI, OFFSET [VAR1+2] ; Adentro novamente no endereço (medo de erros)
   
    CMP [VAR1+7], 00H ; Comparo VAR1+7 com 00 (no primeiro loop com certeza não vai ser)
    
    MOV [VAR1+7], 00H ; Movo 00 para VAR1+7, criando um byte de paridade/comparação
    
    JE MODE2          ; Caso VAR1+7 seja igual a 00 (segundo input com certeza vai ser), pulo pra MODE2
    
    MOV [VAR1+6], CH ; Movo o primeiro input pra VAR1+6
    
    RET
    
    MODE2: ; Em mode2 vou guardar meu segundo input em VAR1+8
    MOV [VAR1+8], CH
    RET
    
;--- A lógica se mantém a mesma, porém diminuindo certos deatlhes dependendo das casas decimais---;
    TRAT_VAR2: ; Caso esteja trabalhando com 2 casas decimais
    MOV DI, OFFSET [VAR1+2] 
    MOV AL, [DI]
    SUB AL, 30H
    MOV BL, 10
    MUL BL

    MOV CL, AL
    MOV AL, [DI+1]
    SUB AL, 30H
    MOV BL, 1
    MUL BL
    
    MOV CH, AL
    ADD CH, CL
    MOV DI, OFFSET [VAR1+2]
    CMP [VAR1+7], 00H ;
    MOV [VAR1+7], 00H
    JE MODE3 
    MOV [VAR1+6], CH
    RET
    
    MODE3:
    MOV [VAR1+8], CH
    RET
    
    TRAT_VAR3: ; Caso esteja trabalhando com uma casa decimal
    MOV DI, OFFSET [VAR1+2]
    MOV AL, [DI]
    SUB AL, 30H
    MOV BL, 1
    MUL BL
    MOV CH, AL
    MOV DI, OFFSET [VAR1+2]
    CMP [VAR1+7], 00H ;(0)
    MOV [VAR1+7], 00H
    JE MODE3 
    MOV [VAR1+6], CH
    RET
    
    MODE4:
    MOV [VAR1+8], CH
    RET
    
    
 
    
    
