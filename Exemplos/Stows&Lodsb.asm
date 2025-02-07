
; Leitura de string usando direcion flag and LODSB
;
;DATA SEGMENT 
;    
;    STR DB 'HELLO'  ; String na memória 
;    
;DATA ENDS
;
;CODE SEGMENT
;    
;    ASSUME DS:DATA, CS:CODE
;
;START:
;
;    MOV AX, DATA
;    
;    MOV DS, AX    ; Configura DS para acessar os dados
;
;    MOV SI, OFFSET STR  ; SI aponta para o inicio da string
;    
;    CLD                ; Defino DF = 0
;
;    LODSB   ; AL ? 'H' (ASCII 48H), SI = SI + 1
;    LODSB   ; AL ? 'E' (ASCII 45H), SI = SI + 1
;    LODSB   ; AL ? 'L' (ASCII 4CH), SI = SI + 1
;    ; ...
;
;CODE ENDS
;END START
;      

DATA SEGMENT
    
    BUF DW 10 DUP (?)  ; Reserva espaço para 10 palavras (20 bytes) 
    
DATA ENDS

CODE SEGMENT
    
    ASSUME DS:DATA, ES:DATA, CS:CODE

START: 

    MOV AX, DATA
    MOV ES, AX    ; ES aponta para o segmento de destino

    MOV DI, OFFSET BUF  ; DI aponta para o buffer
    MOV AX, 1234H       ; Valor a ser armazenado
    CLD                ; Direcaoo para frente

    STOSW  ; [DI] = AX, DI = DI + 2
    STOSW  ; [DI] = AX, DI = DI + 2

CODE ENDS

END START
 


