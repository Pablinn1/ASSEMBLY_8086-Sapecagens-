#start=stepper_motor.exe#  ; Inicia o simulador de motor de passo no EMU8086

ORG 100h  ; Define a origem do código na memória (modo .COM)

JMP START  ; Pula a seção de dados e vai direto para a execução do programa

; =================== Definição das Variáveis ====================
VAR1 DB 5,0,5 DUP ('$')  ; Buffer para armazenar os valores digitados pelo usuário
MSG1 DB 'Digite o numeros de controle do motor de passo:',00h,'$'  
                         ; Mensagem que será exibida ao usuário antes da entrada de dados

; =================== Início do Programa ====================
START:

MOV DX, OFFSET MSG1  ; DX aponta para a string MSG1
MOV AH, 09H          ; Função 09H do DOS → Imprime a string até encontrar '$'
INT 21H              ; Exibe a mensagem na tela

MOV DX, OFFSET VAR1  ; DX aponta para o buffer VAR1 onde será armazenada a entrada do usuário
MOV AH, 0AH          ; Função 0AH do DOS → Entrada de string
INT 21H              ; Aguarda a entrada de dados

; =================== Início do Loop Principal ====================
RODA_MUNDO:

MOV BX, OFFSET VAR1  ; BX aponta para o início do buffer VAR1
MOV SI, 00H          ; SI = 0 (começa no primeiro estado da sequência)

; =================== Loop de Controle do Motor ====================
RODA_GIGANTE:

WAIT:  
    IN AL, 7             ; Lê o estado da porta 7 (status do motor)
    TEST AL, 10000000b   ; Testa o bit 7 para verificar se o motor está pronto
    JZ WAIT              ; Se o motor não estiver pronto, espera até que esteja

; =================== Envia o Comando para o Motor ====================
RODA_MOINHO:
    MOV AL, [BX+2][SI]  ; Lê o próximo valor da sequência salva pelo usuário
    OUT 7, AL           ; Envia o comando para a porta do motor
    INC SI              ; Avança para o próximo estado da sequência

    CMP SI, 4           ; Se ainda não chegou ao fim da sequência...
    JB RODA_GIGANTE     ; Continua no loop

    JMP RODA_MUNDO      ; Reinicia o processo e aguarda nova entrada

END  ; Finaliza o código
