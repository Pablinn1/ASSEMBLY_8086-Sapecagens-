; Soma de vetores

org 100h
jmp start
vec1 db 1, 2, 5, 6  ; Dedico 4 bytes para a cria��o dos vetores
vec2 db 3, 5, 3, 1
vec3 db ?, ?, ?, ? 

start: 

 lea si, vec1 ; Salvo o endere�o do vec em Si
 
 lea bx, vec2 
 
 lea di, vec3 
 
 mov cx, 4   ; Configuro CX para o LOOP
 
sum: 

 mov al, [si] ; Mando o conte�do guardado no endere�o em SI para al
 
 add al, [bx] ; Somo AL com o conte�do guardado no endere�o em BX
 
 mov [di], al ; Movo para a posi��o 0 do vec3
 
 ; Incremento os deslocadores para avan�ar uma posi��o na linha do buffer
 inc si
 
 inc bx
 
 inc di 
 
 loop sum ; Repito o programa CX vezes
 
.EXIT