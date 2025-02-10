    
    #start=thermometer.exe#
    
    org 100h
    
    start:
     
     in AL,125 ; 125 condiz a uma porta de entrada, logo al recebe 
     cmp AL,22
     jl low    ; Salta se o AL for menor que o segundo operando '22'
     
     cmp AL,55 ; Salta se AL for menor = ao segundo operando, 
               ; Ou seja, mantem o loop ate AL > 55
     jle ok
     jg high   ; Salta se o al for maior que o segudo operando
    
    low:
     
     mov AL,1
     out 127,AL ; Liga o fogo
     
     jmp ok
    
    high:
    
     mov AL,0   ; 127 condiz com uma porta de saida, logo al envia
     out 127,AL ; Ascende o fogo
   
    ok:
    
     jmp start  ; Loop 