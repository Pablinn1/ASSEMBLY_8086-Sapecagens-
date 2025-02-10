ORG 100h

JMP START
; Crios os buffers de vetores/textos
VEC1 DB 4,0 ,4 DUP ('$')
VEC2 DB 4,0 ,4 DUP ('$')
VEC3 DB ?, ?, ?,'$' 
LIN DB 0AH, 0DH, 24H

MSG1 DB 'Digite no Vetor: ', 00h, '$'
MSG2 DB 'Resultado do Vetor 3: ', 00h, '$'

; A lógica permance a mesma do código anterior, exceto em algumas ocasiões 
START:
MOV DX, OFFSET MSG1 
CALL Print

MOV DX, OFFSET VEC1
CALL Captura_vetores

MOV DX, OFFSET MSG1
CALL PRINT

MOV DX, OFFSET VEC2
CALL Captura_vetores
CALL Mul_Vetores    ; Função responsável pelo calculo do produto escalar
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

; Indico os endereços dos vetores para determinados ponteiros
Mul_Vetores:   
LEA SI, VEC1
LEA BP, VEC2
LEA DI, VEC3
MOV CX, 3 ; Indica a ordem do vetor linha

Multi: 
MOV AL, [BP+2] ; Movo o dado do endereço BP para AL
SUB AL, 30H    ; Subtraio par ficar em decimal (mais fácil)
MOV BL, [SI+2]
SUB BL,30H
MUL BL         ; Multiplico BL com AL 
MOV [DI], AL   ; Guardo o resultado no endereço apontado por DI

INC DI
INC BP
INC SI

LOOP Multi ; Loop definido por CX

Prod_Escalar: ; Calculo real do produtor escalar
LEA DI, VEC3 ; Adentro no endereço efetivo do VEC3
MOV AL, [DI] ; Movo o primeiro byte para al
MOV BL, [DI+1] ; Movo o segundo byte para al 
ADD AL, BL     ; Somo os dois bytes
MOV BL, [DI+2] 
ADD AL, BL     ; Somo com o último byte

;A seguir: Lógica para tratar com números de 2 digitos
MOV BL, 0AH
DIV BL         ; Divido o número por 10
MOV CL, AL     ; Movo a parte alta para AL
MOV CH, AH     ; Movo a parte baixa para CL
RET

PRINT_VEC3: 
MOV DX, OFFSET MSG2
CALL Print

MOV DL, CL   ; Movo CL para DL e logo em seguida somo com 30h
ADD DL, 30H  ; Soma essa que induz o conteúdo ficar em ascii
MOV AH, 02H
INT 21H  

MOV DL, CH 
ADD DL, 30H
INT 21H
.EXIT
END   