       ORG 100h

; --- Captura e armazena a próxima tecla pressionada ---
        mov ah, 0       ; Prepara para capturar uma tecla pressionada
        int 16h         ; Interrompe para capturar a tecla e armazená-la em AL
        

; --- Exibe o caractere armazenado em AL ---
        mov ah, 2       ; Prepara para exibir o caractere
        mov dl, al      ; Move o conteúdo de AL para DL (caractere a ser exibido)
        int 21h         ; Interrupção para exibir o caractere em DL
        

; --- Converte o caractere de hexadecimal para decimal ---
        sub al, 48      ; Converte o caractere (ASCII) para o valor decimal
        mov bl, al      ; Armazena o valor em BL para operações futuras
        
        
; --- Exibe o caractere '+' ---
        mov ah, 2       ; Prepara para exibir o caractere
        mov dl, '+'     ; Define o caractere '+' para exibição
        int 21h         ; Interrupção para exibir o caractere '+'  
          

; --- Captura uma nova tecla pressionada ---
        mov ah, 0       ; Prepara para capturar outra tecla pressionada
        int 16h         ; Interrompe para capturar a tecla e armazená-la em AL 
           

; --- Exibe o caractere armazenado em AL ---
        mov ah, 2       ; Prepara para exibir o caractere
        mov dl, al      ; Move o conteúdo de AL para DL
        int 21h         ; Interrupção para exibir o caractere em DL 
        

; --- Converte o segundo caractere de hexadecimal para decimal ---
        sub al, 48      ; Converte o caractere (ASCII) para valor decimal
        mov cl, al      ; Armazena o valor em CL para operações futuras 
        
        
; --- Soma os dois valores capturados ---
        add bl, cl      ; Soma os valores armazenados em BL e CL (resultado em BL) 
        

; --- Prepara para dividir o resultado da soma por 10 ---
        mov ah, 0       ; Zera o registrador AH para evitar erros
        mov al, bl      ; Move o valor da soma (BL) para AL
        mov bl, 10      ; Define o divisor como 10
        div bl          ; Divide AL por BL (resultado: quociente em AL, resto em AH)
        
        
; --- Armazena os resultados da divisão ---
        mov bl, ah      ; Move o resto da divisão (parte mais significativa) para BL
        mov cl, al      ; Move o quociente (parte menos significativa) para CL
        

; --- Exibe o caractere '=' ---
        mov ah, 2       ; Prepara para exibir o caractere
        mov dl, '='     ; Define o caractere '=' para exibição
        int 21h         ; Interrupção para exibir o caractere '='
        

; --- Exibe a parte mais significativa (BL) ---
        add bl, 48      ; Converte o valor para ASCII
        mov ah, 2       ; Prepara para exibir o caractere
        mov dl, bl      ; Move o valor ASCII para DL
        int 21h         ; Interrupção para exibir o caractere
        

; --- Exibe a parte menos significativa (CL) ---
        add cl, 48      ; Converte o valor para ASCII
        mov dl, cl      ; Move o valor ASCII para DL
        mov ah, 2       ; Prepara para exibir o caractere
        int 21h         ; Interrupção para exibir o caractere
