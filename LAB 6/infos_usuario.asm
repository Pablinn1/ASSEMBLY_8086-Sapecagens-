    
    
    org 100h 
    
    JMP Inicio 
    
    MSG1 DB 'NOME: ',00h, '$' 
    MSG2 DB 'Call-Number: ', 00h , '$'
    MSG3 DB 'Adress: ', 00h, '$'  ;  
    MSG4 DB 'Seus dados sao: ', 00h, '$'  ;  
    
    NOME DB 32, 0, 32 DUP ('$')
    TELE DB 32, 0, 32 DUP ('$')
    ADRESS DB 32, 0, 32 DUP ('$')

    Lin  DB 0AH,0AH, 0DH, 24H  
    
    Inicio: 
    
    mov dx, offset MSG1 ;Entro no endereço de buffer do MSG1 
    
    Call Mensagem ;Função para imprimir a string na tela       
    
    
    mov dx, offset NOME ;Entro no endereço do buffernome
   
    
    Call Infos  ; Chamo a função de captura de INFO
      
    Call Linha ; Função de pular linha
    
    
    mov dx, offset MSG2 
     
    Call Mensagem
    
    
    mov dx, offset TELE ; Endereço do buffer TELE
    
    
    Call Infos ;Função de capturar o número de telefone
    
    Call Linha
    
    ; A lógica se segue em diante
    mov dx, offset MSG3 
     
    Call Mensagem
    
    
    mov dx, offset ADRESS
    
     
    Call Infos 
    
    Call Linha
    
    Call Linha 
    
    Call Print
    
     
    .Exit
    
   
    Infos: 
    
    mov ah, 0AH ; Capturo as infos do usuário
    ; O primeiro byte vai ser o tamanho da buffer e o segundo vai ser a quantidade de inputs
    int 21h 
    ret
    
    ; Função de nova linha
    Linha:
    mov dx, offset Lin
    mov ah, 09h
    int 21h
    ret
    
    ; Função para printar os dados do usuário na tela
    Print:
    mov dx, offset MSG4
    CALL Mensagem 
    CALL Linha      
    mov dx, offset [NOME+2]   ; PASS+2 pois os primeiros bytes são irrelevantes
    mov ah, 09h   
    int 21h   
    
    CALL LINHA 
    ; A lógica continua a mesma
    mov dx, offset [TELE+2]
    mov ah, 09h
    int 21h  

    CALL LINHA 
    
    mov dx, offset [ADRESS+2]
    mov ah, 09h
    int 21h 
      
    CALL LINHA  
    ret
        
    ; Função de imprimir na tela
    Mensagem:
    mov ah,09h
    int 21h
    ret
    End
    
    