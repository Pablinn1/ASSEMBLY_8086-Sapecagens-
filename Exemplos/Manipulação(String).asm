
     
DATA SEGMENT  ; Inicia um segmento de data
    
    STR DB 'HELLO', 0  ; String terminada em 0 (tipo C)
    
DATA ENDS     ; Termina o segmento

CODE SEGMENT  ; Inicia um Segmento de Codigo
    
    ASSUME DS:DATA, CS:CODE   ; Diz ao compilador que ds usara ds e cs usara code
    

START:  

    MOV AX, DATA ; Movo o valor do adress of data segment
    
    MOV DS, AX          ; DS aponta para o segmento de dados

    MOV BX, OFFSET STR  ; BX aponta para o inicio da string
    MOV AL, [BX]        ; Le o primeiro caractere (AL = 'H')

    ; AL agora contém 'H' (48H)

CODE ENDS ; Termina o segmento de codigo
END START ; Termina a label start
