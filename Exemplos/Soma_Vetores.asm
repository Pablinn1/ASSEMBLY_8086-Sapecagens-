; Soma de vetores

org 100h
jmp start
vec1 db 1, 2, 5, 6  ; Dedico 4 bytes para a criação dos vetores
vec2 db 3, 5, 3, 1
vec3 db ?, ?, ?, ? 

start: 

 lea si, vec1 ; Salvo o endereço do vec em Si
 
 lea bx, vec2 
 
 lea di, vec3 
 
 mov cx, 4   ; Configuro CX para o LOOP
 
sum: 

 mov al, [si] ; Mando o conteúdo guardado no endereço em SI para al
 
 add al, [bx] ; Somo AL com o conteúdo guardado no endereço em BX
 
 mov [di], al ; Movo para a posição 0 do vec3
 
 ; Incremento os deslocadores para avançar uma posição na linha do buffer
 inc si
 
 inc bx
 
 inc di 
 
 loop sum ; Repito o programa CX vezes
 
.EXIT