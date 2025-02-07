
        org 100h
       
        mov ah, 0 ;Interrompe o programa e checa e guarda a proxima tecla pressionada, esta que e guardada no registrado AL
         
        int 16h   
        
        
        mov ah, 2 ; Interrompe o programa e printa a ultima palavra movida pra dl
        
        mov dl,al ; A interrupcao 21h necessita que o conteudo a ser printado esteja guardado no registrador dl
         
        int 21h
        
            
        
        sub al, 48 ; A subtracao e sempre feita atarves do conteudo salvo no registrado al
        
        mov bl, al ; Movo al pra bl a fim de efetuar uma soma posteriormente
        
             
        mov ah, 2  ; Interrupcao e print do caractere '+'
        
        mov dl, '+'
        
        int 21h
         
     
        mov  ah, 0 ; Interrupcao para guardar a tecla a ser pressionada
        
        int 16h
        
        
        mov ah, 2 ; Interrupcao de print
        
        mov dl,al
         
        int 21h
        
        
        sub al, 48 ; Subtracao do conteudo do registrador al
        
        mov cl, al
              
        add bl, cl ; Realizonuma soma entre os registradores bl e cl (o conteudo da soma estara no bl)
        
        
        
        mov ah, 2   ; Printo o caractere '='
        mov dl, '=' 
        int 21h
          
          
        add bl, 48  ; Printo a soma entre os registradores bl e cl
        mov dl, bl
        mov ah, 2
        int 21h
