    
    #start=thermometer.exe#
     
     ORG 100h
     
    JMP START
    
    LIN  DB  0AH,0AH, 0DH, 24H

    MSG1 DB 'Temperatura em Farenheits: ', 00h, '$'
    
    
    START:
    
    IN AL,125 
    
    PUSH AX
    
    CALL Conversor_Temp
    
    CALL MENSAGEM
    
    CALL PRINT
    
    CALL LINHA
    
    POP AX
    
    CMP AL,22 
    
    JL LOW   
     
    CMP AL,55  
              
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
    
    ;MOV DL, ','
    ;MOV AH, 02H
    ;INT 21H
    
    ;MOV DL, BH
    ;MOV AH, 02H
    ;INT 21H
    
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