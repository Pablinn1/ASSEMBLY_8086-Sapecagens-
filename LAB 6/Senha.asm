    org 100h
    
    jmp start
    
    ; Criação dos Buffers de Mensagens
    MSG1 DB 'Digite a sua senha: ',00h,'$'       
    MSG2 DB 'Digite Novamente: ',00h,'$'
    MSG3 DB 'Senha correta ',00h,'$'
    MSG4 DB 'Senha Incorreta, Perdeu Playboy',00h, '$'
    
    ; Criação dos Buffers para as senhas e formatar textos
    Senha DB '11245', 0 
    Pass  DB 32, 0, 32 DUP ('$')
    Lin  DB 0AH,0AH, 0DH, 24H  
    
    ; Configurações inicias do código/avisos
    Start:  
    MOV bx,5 ; Esse bx = 5 indica o número de tentativas para por a senha
    ; Tentativas = BX - 1
    push bx ; Salvo BX na pilha
    
    MOV dx, offset MSG1 ; movo o endereço da MSG1 pra o DX e imprimo a mensagem             
    MOV ah, 09h
    int 21h
    
    ; Função principal, onde chamo funções de inputs
    Inicio:
    Call Get_Password ; Chamo a função de Input da senha
    
    Call Linha ; Coloco uma linha a cada frase printada
    
    ; Função feita para testar as senhas
    Teste: 
    MOV SI, OFFSET Senha    ; Movo o endereço da senha salva para SI
    MOV DI, OFFSET [Pass+2] ; Movo o endereço + 2 (pois os primeiros dois caracteres são 'lixos') para DI
    MOV CX, 6 ; Como a senha salva tem 5 caracteres, eu coloco um loop de 6 para comparar os bytes + byte final de paridade
    
    REPZ CMPSB ; Repito a função CX vezes/Comparo os bytes de DI e Si          
    
    JNZ ERRADA  ; Caso a comparação falhe (ZF = 0), pulo para function ERRADA
    JMP CORRETA ; Caso a senha esteja correta, pulo para a função CORRETA   
    
    ; Função responsável por permitir que o pedido de senha seja repetido
    ERRADA: 
    POP cx  ; Salvo o conteúdo de BX em CX 
    DEC cx  ; Decremento a fim de ter um loop
    PUSH cx ; Salvo esse CX na pilha pois tenho medo dele ser modificado no decorrer 
    CMP cx, 1 ; Comparo o conteúdo de CX com 1 (Lógica mais evidente quando olha nos regs.)
    
    JE Senha_Incorreta ; Caso CX = 1, o número de tentativas foi excedido
    
    MOV dx, offset MSG2 ; Printa a mensagem de digitar a senha novamente
    MOV ah, 09h
    int 21h 
    
    loop Inicio ; Volto ao inicio para pedir a senah novamente e etc
    
    .Exit 

    ; Função que imprime 'senha correta'
    CORRETA:
    MOV dx, offset MSG3
    MOV ah, 09h
    int 21h 
    
    .Exit ; Termino do Código (caso a senha esteja correta)
    
    ; Função de Quebra de linha
    Linha:
    MOV dx, offset Lin
    MOV ah, 09h
    int 21h
    ret   

    ; Função para guardar o endereço da senha digitada no BX 
    GET_PASSWORD:
    
    XOR CX, CX    ; Zera o conteúdo de CX
    MOV BX, OFFSET [Pass+2] ; Salvo o endereço do Pass em BX
    
    ; Função responsável pela leitura dos caracteres  
    LER_CARACTERE:
    MOV AH, 08H  ; Leitura sem echo do cmd, a leitura é salvo em AL
    INT 21H 
    
    MOV AH,0     ; Zero AH para ficar permitir que apenas AL tenha conteúdo
   
    CMP AL, 0DH  ; Vejo se o usuário pressionou Enter    
    JE FIM_SENHA ; Caso sim, vou para o FIM DA SENHA
    
    PUSH AX      ; Guardo o de ax na pilha por medo de perder ele no processo
    
    MOV AH, 02h 
    MOV dl, '*'  ; Imprimo os caracteres '*'  após cada digito do usuário
    int 21h
       
    CMP CX, 16  ; Atribuo um valor que vai limitar o número de caracteres a ser digitadp        
    JAE ESPERAR_ENTER  ; Caso CX = 16, pulo para uma função de esperar o ENTER 
    
    POP AX ; Retorno o valor de AX da pilha (conteúdo do input)
    
    MOV [BX], AL  ; Salvo no deslocamento em BX     
    INC BX        ; Incremento o 'endereço em BX'      
    INC CX        ; Incremento em CX      
    JMP LER_CARACTERE ; Volto ao topo da função  
    
    ; Função que impede da verificação acontecer, caso o input não termine com ENTER
    ESPERAR_ENTER:
    MOV AH, 08H         
    INT 21H         ; Espero um singelo enter do usuário para terminar o processo de input
    CMP AL, 0DH         
    JNE ESPERAR_ENTER   
 
    ; Função onde coloco 0 pra finalizar o buffer e
    ; Responsável por coletar quantas vezes CX foi interado (quantidades de inputs no buffer)
    FIM_SENHA:
    MOV BYTE PTR [BX], 0 ; Movo o byte de paridade para o final do buffer PASS
    MOV BYTE PTR Pass+1, CL ; Salvo CL na segunda posição do buffer PASS 
    ; A quantidade que CX incrementou foi a quantidade de vezes que algum caractere foi incrementado 
    
    CALL Linha
    MOV dx, offset [Pass+2] ; Entro no endereço Pass para printar as senhas digitadas
    CALL Print_Senha  
    RET

; Função para imprimir as tentativas de senha após os inputs        
    Print_Senha:
    MOV al, [si] ; Passo o conteúdo do endereço SI para DL
    MOV ah, 02h 
    int 21h      ; Printo a letra no serial
    inc si       ; Incremento o deslocamento SI
    Loop Print_Senha ; O valor salvo em CX (numero de caracteres digitados) controla o LOOP
    ret

    ; Caso as 3 tentativas forem fracassadas, o codigo termina com uma mensagem motivadora!  
    Senha_Incorreta:
    MOV DX, OFFSET MSG4
    MOV AH, 09H         
    INT 21H
        
    END
