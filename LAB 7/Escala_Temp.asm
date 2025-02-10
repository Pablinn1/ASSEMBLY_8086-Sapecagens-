; Celcius para Fahrenheit (valores fecahdos)

ORG 100h

JMP START

VAR1 DB  3 , 0 ,3 DUP ('$')     
LIN  DB  0AH,0AH, 0DH, 24H

MSG1 DB 'Digite a temperatura em Celcius: ', 00h, '$'
MSG2 DB 'A temperatura em Fahrenheits:' , 00h, '$'

START:

MOV DX, OFFSET MSG1

CALL PRINT

MOV DX, OFFSET VAR1 ; Move para DX o endereço de VAR1

CALL GET_VAR1  
                      
CALL LINHA

CALL _CONFIG ; Label responsável por acessar o endereço do VAR1
 
MOV DX, OFFSET MSG2

CALL PRINT
  
CALL PRINT_RESULT ; Função responsável por imprimir o resultado

.EXIT

GET_VAR1:
MOV AH, 0AH
INT 21H

RET

_CONFIG:
LEA DI, VAR1

EQUATION:

MOV AL, [DI+2]
SUB AL, 30H
MOV BL, 0AH ; Pego o primeiro digito e trasnformo em escala decimal 
MUL BL     
MOV BL, [DI+3] 
SUB BL, 30H
ADD AL, BL ; E somo com o segundo digito (unidade)

MULTI:     ; Multiplico por 9
MOV BL, 9
MUL BL

DIVISION: ; Divido por 5
MOV BL, 5
DIV BL

SOMA: ; Somo com 32
ADD AL, 32

PART_DIGITS: ; Quebro o número em duas partes
MOV BL, 10 
DIV BL
MOV CH, AH   ; Movo o menos significativo para CH
XOR AH, AH

PART_DIGITS_2: ; Quebro a parte alta em duas partes
MOV BL, 10
DIV BL
MOV CL, AL  
MOV BH, AH
RET

PRINT:  
MOV AH, 09H
INT 21H
RET

PRINT_RESULT:
ADD CH, 30H ; Somo os resultados com 30h para deixar em asciii
ADD CL, 30H
ADD BH, 30H

MOV DL,CL
MOV AH, 02H
INT 21H 

MOV DL,BH
MOV AH, 02H
INT 21H 

MOV DL, CH
MOV AH, 02H
INT 21H
RET

LINHA:
MOV DX, OFFSET LIN
MOV AH, 09H
INT 21H
RET  

END