Title Game

data segment 
    target db 0  
    guess db 0
    msg1 db "Donnez un nombre entre 1 et 99: ",13,10,"$"
    msg2 db "Devinez le nombre: (essais restants $"
    msg3 db " )",13,10,"$"
    less db "moins",13,10,"$"
    more db "plus",13,10,"$"
    gagne1 db "Le joueur 1 gagne!!",13,10,"$"  
    gagne2 db "Le joueur 2 gagne!!",13,10,"$"
data ends  

code segment
    assume cs:code,ds:data   
    
debut:    
     mov ax,data
     mov ds,ax
         
     mov dx,offset msg1
     mov ah,09h
     int 21h
     
     mov target, 0 ;set target to 0
     
saisie1:       
     mov ah,01h
     int 21h
              
     cmp al, 13
     je comparaison1 
             
     cmp al, '0'
     jb debut  
     
     cmp al, '9'
     ja debut
     
     
     sub al, '0' 

     shl target, 1
     mov bl, target
     shl bl, 2  
     add target, bl
     add target, al
     jmp saisie1    
     
comparaison1:     
     cmp target, 1
     jb debut
     
     cmp target, 99
     ja debut
         
      
     mov cx, 10 ; number of tries 10
player2:     
     mov dx,offset msg2
     mov ah,09h
     int 21h 
            
     mov dx, cx 
     add dl, '0'
     mov ah,02h
     int 21h
     
     mov dx,offset msg3
     mov ah,09h
     int 21h
     
             
saisie2:
     mov ah,01h
     int 21h
              
     cmp al, 13
     je comparaison2 
             
     cmp al, '0'
     jb player2  
     
     cmp al, '9'
     ja player2
     
     
     sub al, '0' 

     shl guess, 1
     mov bl, guess
     shl bl, 2  
     add guess, bl
     add guess, al
     jmp saisie2    
     
comparaison2:   
     cmp guess, 1
     jb player2
     
     cmp guess, 99
     ja player2 
     
     mov bl, target
               
     cmp guess, bl
     jb plus
     
     cmp guess, bl
     ja moins
     
     mov dx,offset gagne2
     mov ah,09h
     int 21h 
     
     jmp fin
     
plus:
     mov dx,offset more
     mov ah,09h
     int 21h 
           
     mov guess, 0      
     loop player2 
     
     jmp jump
     
moins: 
     mov dx,offset less
     mov ah,09h
     int 21h 
       
     mov guess, 0  
     loop player2   
             
             
jump:           
     mov dx,offset gagne1
     mov ah,09h
     int 21h 
     

fin: mov ah,4ch
     int 21h
        
code ends
     end debut