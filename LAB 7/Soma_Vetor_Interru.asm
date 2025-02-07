org 100h

JMP START


VEC1 DB 5,0 ,5 DUP ('$')
VEC2 DB 5,0 ,5 DUP ('$')
VEC3 DB ?, ?, ?, ?, '$' 

LIN DB 0AH, 0DH, 24H

MSG1 DB 'Digite no Vetor: ', 00h, '$'

MSG2 DB 'Resultado do Vetor 3: ', 00h, '$'
 
START:

MOV DX, OFFSET MSG1 

CALL Print

MOV DX, OFFSET VEC1

CALL Captura_vetores

MOV DX, OFFSET MSG1

CALL PRINT

MOV DX, OFFSET VEC2

CALL Captura_vetores

CALL Soma_Vetores
 
CALL PRINT_VEC3 


Captura_vetores:

MOV ah, 0AH
INT 21h

CALL Linha

RET
 
 
Print:

MOV AH, 09H
INT 21H 
 
RET
 
Linha:

MOV DX, OFFSET LIN
MOV AH, 09h
INT 21H

RET

Soma_Vetores: 

LEA SI, VEC1

LEA BX, VEC2

LEA DI, VEC3

MOV CX, 4

SOMA: 

MOV AL, [SI+2]
ADD AL, [BX+2]
SUB AL, 30H
MOV [DI], AL

INC DI
INC BX
INC SI

LOOP SOMA

RET

PRINT_VEC3: 

MOV DX, OFFSET MSG2

CALL Print

MOV DX, OFFSET VEC3

CALL Print

.EXIT

END   