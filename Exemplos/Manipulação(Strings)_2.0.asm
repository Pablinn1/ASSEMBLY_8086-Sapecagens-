    
    
    Data segment
    
    Table db '0123456789' ;Tabela de numeros
    
    Data ends
        
    
    Code segment
        
    assume ds:Table, cs:Code    ; Determino onde os registradores Ds e Cs vao operar
    
    
    Start:
    
    MOV AX, data ;Mando o adress de data para ax
    
    MOV DS, AX   ;Linko com Ds (segmento)
    
    MOV BX, offset table ; Determino o deslocamento (offset) EM BX
    
    MOV ah, 0
    
    INT 16h   ; get a number in the console (ele vem em hexa)
    
    sub al, 30h ; Transformo em ascii
    
    XLATB    ; Depois transformo para hexa de novo
    
    Code ends
    
    END Start
    
    
    ; Quis interagir com o codigo, mas poderia ser feito apenas colocando um valor predeterminado em al