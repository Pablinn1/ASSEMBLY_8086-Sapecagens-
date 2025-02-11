#start=stepper_motor.exe#  ; Inicia o simulador de motor de passo no EMU8086

ORG 100h  ; Define a origem do código na memória (modo .COM)

JMP START  ; Pula a tabela de dados e vai direto para a execução do código

; =================== Definição da Tabela de Meio-Passo ====================
HALF_STEP DB 0000_0001b  ; Estado 1 → Ativa apenas a bobina D
          DB 0000_0011b  ; Estado 2 → Ativa bobinas C e D
          DB 0000_0100b  ; Estado 3 → Ativa apenas a bobina B
          DB 0000_0110b  ; Estado 4 → Ativa bobinas B e C

; =================== Início do Programa ====================
START:

MOV BX, OFFSET HALF_STEP  ; BX aponta para o início da sequência HALF_STEP
MOV SI, 00H               ; SI = 0 (começa no primeiro estado da sequência)

; =================== Loop Principal ====================
RUN:

WAIT:  
    IN AL, 7             ; Lê o estado da porta 7 (status do motor)
    TEST AL, 10000000b   ; Testa o bit 7 para verificar se o motor está pronto
    JZ WAIT              ; Se o motor não estiver pronto, espera até que esteja

; =================== Envia o Comando para o Motor ====================
RODA_VIVA:
    MOV AL, [BX][SI]  ; Lê o próximo valor da sequência HALF_STEP
    OUT 7, AL         ; Envia o comando para a porta do motor
    INC SI            ; Avança para o próximo estado da sequência

    CMP SI, 4         ; Se ainda não chegou ao fim da sequência...
    JB RUN            ; Continua no loop RUN

    JMP START         ; Reinicia a sequência de passos

END  ; Finaliza o código
