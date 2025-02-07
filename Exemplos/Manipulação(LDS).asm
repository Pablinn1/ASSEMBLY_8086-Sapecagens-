
    
    
    
    DATA SEGMENT 
        
        PTR DW 0020H, 3000H  ; Offset = 0020H, Segmento = 3000H  (Parametros para salvar em ds e bx)
        
    DATA ENDS
    
    CODE SEGMENT
        ASSUME DS:DATA, CS:CODE
    
    START:
        MOV AX, DATA
        MOV DS, AX       ; Configura DS para acessar a variavel PTR
    
        LDS BX, PTR      ;  Agora BX = 0020H e DS = 3000H
                         ;  BX aponta para o endereco fisico 30000H + 0020H = 30020H
    
        MOV AX, 1234H    ; Valor que queremos armazenar na memoria
        MOV [BX], AX     ; Armazena 1234H no endereço DS:BX (30020H)
    
                         ; Agora vamos ler o valor armazenado para verificar:
        MOV CX, [BX]     ; CX recebe o valor salvo em 30020H
                                                        
        MOV AH, 4CH      ; Interrompe o programa (DOS)
        INT 21H
    
    CODE ENDS
    END START
