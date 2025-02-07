    
    
; Soma de dois numeros predispostos    
    

ORG 100H

MOV AL, 35H     
      
MOV AH, 2
MOV DL, AL
INT 21H


MOV DL, '+'
INT 21H


MOV AL, 32H
MOV DL, AL
INT 21H
          

MOV DL, '='
INT 21H          

    
MOV AL, 35H
ADD AL, 32H

SUB AL, 30H

MOV DL, AL    
         
INT 21H

       