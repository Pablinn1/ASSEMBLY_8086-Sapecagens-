
#start=stepper_motor.exe#


name "stepper"

#make_bin#

steps_before_direction_change = 20h ; 32 (decimal)

jmp start

; ========= data ===============

; Arquivo binario para Sentido-horario
; Rotacao suave (meio-passo)
Meiopasso    db 0000_0110b
         db 0000_0100b    
         db 0000_0011b
         db 0000_0010b

; Arquivo binario para Anti-Sentido-horario
; Rotacao suave (meio-passo)
Antimeiopasso   db 0000_0011b
         db 0000_0001b    
         db 0000_0110b
         db 0000_0010b


; Arquivo binario para Sentido-horario
; Rotacao Pesada (Passo Completo)
Fullstep db 0000_0001b
         db 0000_0011b    
         db 0000_0110b
         db 0000_0000b

; Arquivo binario para Anti-Sentido-horario
; Rotacao Pesada (Passo-Completo)
AntiFullstep db 0000_0100b
          db 0000_0110b    
          db 0000_0011b
          db 0000_0000b


start:
mov bx, offset Meiopasso ; Comeco a partir do Meipasso 
mov si, 0
mov cx, 0 ; Uso CX como um contador de passo

next_step: 

; motor sets top bit when it's ready to accept new command 

wait:   in al, 7     
        test al, 1000 0000b  ; Testo o bit mais significativo (and operation)
        jz wait             ; Caso seja diferente eu permane�o em um loop 
                            ; Para esperar o melhor momento de atualizar o motor
                            ; Aparentemente o bit mais sigf. do motor � uma flutuacao que precisa ser respeitada

mov al, [bx][si]            ; Movo para AL o byte guardado no endere�o

out 7, al                   ; Movo o byte para o motor

inc si

cmp si, 4                   ; Comparo SI com 4 (quantidades de bytes em uma arquivo)
jb next_step                ; Caso seja menor eu continuo no loop
mov si, 0                   ; Caso maior ou igual eu zero SI

inc cx                      ; INCREMENTO CX

cmp cx, steps_before_direction_change ; Comparo com 32 (decimal)

jb  next_step              

mov cx, 0                   ; Caso seja maior ou igual, zero cx
add bx, 4                   ; Movo o deslocamento BX para o proximo arquivo data

;PARTE FINAL

cmp bx, offset AntiFullstep ; Comparo o "deslocador" bx com o endere�o do antifullstep(ultimo arquivo data)
jbe next_step               ; Caso seja menor ou igual a vida continua

mov bx, offset Meiopasso    ; Caso seja  maior reseto bx para o primeiro arquivo binario (Meiopasso)

jmp next_step               ; Volto para o loop



  ; Os passo v�o ser interados 32 vezes cada, apos 32*4 intera�oes o passo retorna ao primeiro (Meiopasso)