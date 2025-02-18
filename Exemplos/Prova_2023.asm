org 100h

SERIAL:

MOV DX, 2FBh        ; Endereço do registrador LCR (CONTROLADOR DE LINHAS)

MOV al, b'10000011' ; BIT 7: DLAB (ACESSO AO DIVISOR), BIT 0,1: 8 bits para envio e recepção 
OUT DX, al

;----- DLL EDLM (DIVISORES PARA 9600 BPS) -----;

; Com o acesso ao divisor permitido, posso configurar o Bound rate

MOV DX, 2F8h ; Entro no endereço do latch pra o divisor LSB (menos significativo) 
MOV AX, 0CH  ; 0Ch = 12 decimal (configuração padrão)
OUT  DX, AX  ; Envio a configuração para o endereço em questão

MOV DX, 2F9h ; Endereço do divisor mais significativo
MOV AX, 0H   
OUT DX, AX      

;----------------------------------------------;

;----- Desligamendo do DLAB e configurações de transmissão e recepção -----; 

MOV DX, 2FBh  ; Endereço do controlador de linhas  
IN AL, DX
AND AL, B'01111111' ; Deixo tudo intacto, exceto o DLAB, onde vai ficar 0 após esta operação 
                    ; 1000_0011 AND 0111_1111 = 0000_011
OUT DX, AL        

; Com o DLAB desligado, posso acessar os registradores de TX e RX

CALL TEST_RECEP ; Chamo a função que verifica se recebi algum dado   

;----- Receber dados do RX -------; 

MOV DX, 2F8H  ; Entro no endereço de RX E TX 
IN AL, DX     ; Guardo o byte em al e em seguida salvo na Pilha (para utilizar em funções futuras)
PUSH AL
CMP AL, 0     ; Comparo AL com 0 e vejo se são iguais...
JE SEM_ERRO   ; Caso seja, vou para SEM_ERRO
              ; Caso não seja é pq deu merda e vou para a label ERRO

; ----- Configuração do temporarizador e speaker ----- ; 

ERRO:
MOV DX, 043H        ; Endereço do canal de controle de modo (parte do temporarizador)
MOV AL, B'10111110' ; BIT 7,6 = Seleção dos canais (no caso canal 2)
                    ; BIT 5,4 = Tipo de leitura de byte (no caso: LSB E DEPOIS MSB)
                    ; BIT 3,2,1 = Seleção dos modos (no caso modo 2)
                    ; BIT 0 = Escolha entre binário oou bcd (no caso binário)

OUT DX, AL          ; Movo essa config para o endereço em questão

;------ Configuração do Speaker ------; 

; 1.193m mhz (padrão do temporarizador)

; N = Divisores da frequência

; Quero uma frequência 500hz, para achar o N basta que

; 1.193 mhz/ 500hz = 2386 (decimal) = 0952h (hexa)

MOV AX, 0952H ; Movo para AX o valor de N encontrado      
MOV DX, 42H   ; Endereço do canal 2 
OUT DX, AL    ; Como o envio é limitado a 8 bytes por vez, a única parte enviada foi a menos significativa
MOV AL, AH    ; Envio a parte mais significativa par AL
MOV DX, AL    ; E agora envio o MSB para o canal 2

MOV DX, 061H  ; Entro no endereço do "speaker"
IN AL, DX     ; Movo o "lixo" que está dentro dele 
OR AL B'00000011' ; E ativo o speaker setando os 2 primeiros bits
OUT DX, AL

;------  PARTE COMUNICAÇÃO PARALELA ------ ; 


IMPRESSORA:
CALL TESTE_BUSY ; Verificação para ver se a impressora está ocupada
MOV DX, 0378H   ; Endereço do registrador de dados LPT1 (ENVIAR DADOS)
POP AL          ; Chamo da pilha o dado vindo pela comunicação serial entre o pc e o pic
OUT DX, AL      
CALL STROBE     ; Chamo o strobe para ativar o envio
JMP SERIAL

TEST_RECEP:
MOV DX, 2FDH   ; Entro no registrador LSR (Estado de linha)
IN AL, DX      ; Recebo o byte do reg. em al
BT AL, 0       ; Vejo se o bit 0 dele está zerado, caso esteja, não tenho nenhum dado a minha espera    
JNC TEST_RECEP ; Loop de espera
RET            

TESTE_BUSY:    
               ; Pulso ativo em alto (indica se a impressora ta ocupada), porém com lógica barrada
               ; Busy igual a 1, recebo 0 
               ; Busy igual a 0, recebo 1 
MOV DX, 0379H
IN AL, DX
BT AL, 7       ; Verifico o bit 7 e vejo se ele é igual a 0, caso seja é pq a impressora ta ocupada
JNC TESTE_BUSY ; Loop até ela desocupar
RET

STROB:        ; Pulso em nivel baixo, que indica se tem algum dado válido no barramento de dados
              ; O strobe tem lógica barrada, logo se ele estiver ativado (em 0), vou receber o sinal 1
              ; Se ele estiver desativado (em 1), vou receber o sinal 0

MOV DX, 0379H ; Adress do Registrador de status
IN AL, DX
BTS AL, 0     ; Envio 1 para ativar o strobe
OUT DX, AL

IN AL, DX
BTR AL, 0    ; Envio 0 para ativar o strobe
OUT DX, AL
RET

END