
; Soma de vetores (0 á 9)

ORG 100h

JMP START

; Crio os buffers de entrada e o buffer da soma
VEC1 DB 5,0 ,5 DUP ('$')
VEC2 DB 5,0 ,5 DUP ('$')
VEC3 DB ?, ?, ?, ?, '$' 
LIN DB 0AH, 0DH, 24H

MSG1 DB 'Digite no Vetor: ', 00h, '$'
MSG2 DB 'Resultado do Vetor 3: ', 00h, '$'
 
START:

MOV DX, OFFSET MSG1 ; DX recebe o endereço de MSG1

CALL Print ; Função para imprimir na tela

MOV DX, OFFSET VEC1 ; DX recebe o endereço de VEC1

CALL Captura_vetores ; Função para capturar os inputs

MOV DX, OFFSET MSG1 ; DX recebe o endereço de MSG1

CALL PRINT

MOV DX, OFFSET VEC2 ; DX recebe o endereço de VEC2

CALL Captura_vetores

CALL Soma_Vetores ; Função para somar VEC1 + VEC2
 
CALL PRINT_VEC3  ; Função para printar o VEC3


Captura_vetores:

MOV ah, 0AH ; Interrupção para guardar uma string no endereço DX
INT 21h

CALL Linha

RET
 
 
Print:

MOV AH, 09H ;Interrupção para printar uma string do endereço DX
INT 21H 
 
RET
 
Linha:

MOV DX, OFFSET LIN
MOV AH, 09h
INT 21H

RET

Soma_Vetores: 

; Salvo o endereco de cada vetor em um ponteiro
; Facilita na manipulação algébrica 
LEA SI, VEC1
LEA BX, VEC2
LEA DI, VEC3

MOV CX, 4 ; O valor de CX é baseado na ordem dos vetores

SOMA: 
MOV AL, [SI+2] ; Movo para AL o dado onde SI esta apontando
; SI + 2 pois os primeiros dois bytes são irrelevantes nesse caso
ADD AL, [BX+2] ; Somo AL com o dado onde BX esta apontando
SUB AL, 30H    ; Diminuo por 30h para que o valor esteja na faixa de 0 á 9 em hexa
; EX: 35H + 34H = 69H > 69H - 30H = 39H
MOV [DI], AL
;Incremento os ponteiros para que pulem uma posição no buffer
INC DI 
INC BX
INC SI

LOOP SOMA ; O loop vai de acordo com o valor de CX

RET

PRINT_VEC3: 
MOV DX, OFFSET MSG2
CALL Print
MOV DX, OFFSET VEC3
CALL Print
.EXIT
END   