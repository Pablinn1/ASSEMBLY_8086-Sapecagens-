Rorg 100h

JMP START


VEC1 DB 4,0 ,4 DUP ('$')
VEC2 DB 4,0 ,4 DUP ('$')
VEC3 DB ?, ?, ?,'$' 

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

CALL Mul_Vetores
 
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

Mul_Vetores: 


LEA SI, VEC1

LEA BP, VEC2

LEA DI, VEC3

MOV CX, 3

Multi: 

MOV AL, [BP+2]
SUB AL, 30H

MOV BL, [SI+2]
SUB BL,30H

MUL BL


MOV [DI], AL

INC DI
INC BP
INC SI

LOOP Multi

Prod_Escalar:


LEA DI, VEC3

MOV AL, [DI]

MOV BL, [DI+1] 

ADD AL, BL 

MOV BL, [DI+2]

ADD AL, BL

MOV BL, 0AH

DIV BL

MOV CL, AL

MOV CH, AH


RET


PRINT_VEC3: 

MOV DX, OFFSET MSG2

CALL Print

MOV DL, CL

ADD DL, 30H

MOV AH, 02H

INT 21H   


MOV DL, CH 

ADD DL, 30H

INT 21H


.EXIT

END   