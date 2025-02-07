    
                
    DATA SEGMENT   ; Crio um segmento de data apra guardar a tabela de numeros
        
    TABLE DB '0123456789'  ; Tabela ASCII (30H-39H)
    
    DATA ENDS
    
    
    CODE SEGMENT 
        
    ASSUME DS:DATA, CS:CODE
    
    START:
    
        MOV AX, DATA ; Carrego em ax o endereço do data segment
        MOV DS, AX   ; Carrega o segmento de dados
    
        MOV BX, OFFSET TABLE   ; Aponta BX para a tabela
        MOV AL, 8              ; Number BCD (5)
        
        XLATB                   ; Converte para ASCII ('5')
    
                                ; AL agora contem '5' (35H)
    
    CODE ENDS
    
    END START
              