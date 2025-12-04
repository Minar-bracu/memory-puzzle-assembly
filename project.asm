.MODEL SMALL
.STACK 100H
.DATA
    numbersgeneratedflag db 10h DUP(0)
    numberlocarray db 18h DUP(0)
    cardsfacedup db 18h DUP(0)
    
    ; UI Elements
    topborder    db 201,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,187,"$"
    bottomborder db 200,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,205,188,"$"
    sideborder   db 186,"$"
    
    ; Title Screen
    title1 db "  MEMORY PUZZLE GAME  $"
    title2 db "                              $"
    
    ; Menu
    menuopt1 db "  [1] EASY   - 2x3 Grid   $"
    menuopt2 db "  [2] MEDIUM - 3x4 Grid   $"
    menuopt3 db "  [3] HARD   - 3x6 Grid   $"
    menuselect db "  Select difficulty:      $"
    
    ; Game Messages  
    attemptsremaining db " ATTEMPTS: $"
    loadingmsg db "  Generating puzzle...    $"
    percentmsg db "%$"
    
    ; End Screens
    Gameover db "      GAME OVER!          $"
    Congrats db "    YOU WIN!              $"
    pressanykey db "  Press any key...        $"
    
    totalsize db 0
    maxpuzzlenumber db 0
    temp dw 0
    savedCX dw 0
    savedDX dw 0
    totalloadednumbers db 0
    
    verticalsize db 1h
    horizontalsize db 4h
    attempts db 3h

    pointer dw 0h
    prevpointer dw 0h
    prevcardwasnumber db 0h
    
    prevcardnumber db 0
    prevcardpointerloc dw ?
    prevcardpointerlocarray dw ?
    
    totalsolved db ?
    griddraw dw 0h
   
.CODE  
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
            
        THEGAME:
        mov ax, 3
        int 10h
        mov attempts,3
        
        mov ah,2
        mov bh,0
        mov dh,5
        mov dl,24
        int 10h
        mov ah,9
        lea dx,topborder
        int 21h
        
        mov ah,2
        mov dh,6
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,title2
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,7
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,title1
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,8
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,title2
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,9
        mov dl,24
        int 10h
        mov ah,9
        lea dx,bottomborder
        int 21h
        
        MOV     CX, 0fh
        MOV     DX, 4240H
        MOV     AH, 86H
        INT     15H
        
        mov ax, 3
        int 10h
        
        mov ah,2
        mov bh,0
        mov dh,4
        mov dl,24
        int 10h
        mov ah,9
        lea dx,topborder
        int 21h
        
        mov ah,2
        mov dh,5
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,title2
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,6
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,menuopt1
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,7
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,menuopt2
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,8
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,menuopt3
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,9
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,title2
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,10
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,menuselect
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,11
        mov dl,24
        int 10h
        mov ah,9
        lea dx,bottomborder
        int 21h
        
        mov ah,2
        mov dh,10
        mov dl,46
        int 10h

        mov ah,1
        int 21h
        cmp al,31h
        je easy
        cmp al,32h
        je medium
        cmp al,33h
        je Hard          
        
        Easy: 
        
        mov verticalsize,1
        mov horizontalsize,2
        
        jmp WITHOUTADDITIONALRANDOMNESS
        
        Medium:
        mov verticalsize,2
        mov horizontalsize,3
        
        jmp numbergeneration
        
        Hard:
        
        mov verticalsize,2
        mov horizontalsize,5
        
        jmp numbergeneration
        
        
        
        
        
        
        
       WITHOUTADDITIONALRANDOMNESS:
        mov ax, 3
        int 10h
        
        mov ah,2
        mov bh,0
        mov dh,8
        mov dl,24
        int 10h
        mov ah,9
        lea dx,topborder
        int 21h
        
        mov ah,2
        mov dh,9
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,loadingmsg
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,10
        mov dl,24
        int 10h
        mov ah,9
        lea dx,bottomborder
        int 21h
        
        mov al,verticalsize
        inc al
        mov bl,horizontalsize
        inc bl
        mul bl
        mov totalsize,al
        
        mov bl,2
        div bl
        mov maxpuzzlenumber,al
        
        call generatingnumbersflag
        
        
        WARRANDGEN:         ; generate a rand no using the system time
        

        mov ah,0
        mov al,totalsize
        cmp totalloadednumbers,al
        jge drawingthenumbergrid

        WARrandgenprogstart:

        
        

        MOV AH, 00h  ; interrupts to get system time        
        INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

        mov  ax, dx
        xor  dx, dx
        mov  cx, 10    
        div  cx       ; here dx contains the remainder of the division - from 0 to 9
        
           


        
        cmp dl,maxpuzzlenumber
        jg WARrandgenprogstart
        
        mov si,dx
        mov dh,0
        
        cmp numbersgeneratedflag[si],0
        je WARrandgen
        
        dec numbersgeneratedflag[si]
        
        xor ax,ax
        mov al,totalloadednumbers
        mov si,ax
        mov numberlocarray[si],dl
        inc totalloadednumbers
        
        ; Show loading progress
        call ShowLoadingProgress
           
        jmp  WARrandgenprogstart 
        
        NUMBERGENERATION:
        mov ax, 3
        int 10h
        
        mov ah,2
        mov bh,0
        mov dh,8
        mov dl,24
        int 10h
        mov ah,9
        lea dx,topborder
        int 21h
        
        mov ah,2
        mov dh,9
        mov dl,24
        int 10h
        mov ah,9
        lea dx,sideborder
        int 21h
        mov ah,9
        lea dx,loadingmsg
        int 21h
        mov ah,9
        lea dx,sideborder
        int 21h
        
        mov ah,2
        mov dh,10
        mov dl,24
        int 10h
        mov ah,9
        lea dx,bottomborder
        int 21h
        
        mov al,verticalsize
        inc al
        mov bl,horizontalsize
        inc bl
        mul bl
        mov totalsize,al
        
        mov bl,2
        div bl
        mov maxpuzzlenumber,al
        
        call generatingnumbersflag
        
        
        RANDGEN:         ; generate a rand no using the system time
        

        mov ah,0
        mov al,totalsize
        cmp totalloadednumbers,al
        jge drawingthenumbergrid

        randgenprogstart:

        
        

        MOV AH, 00h  ; interrupts to get system time        
        INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

        mov  ax, dx
        xor  dx, dx
        mov  cx, 10    
        div  cx       ; here dx contains the remainder of the division - from 0 to 9
        
           


        
        cmp dl,maxpuzzlenumber
        jg randgenprogstart
        
        ; Optimized: Reduced from 4 to 2 saved registers (only save what's needed)
        mov savedCX,cx
        mov savedDX,dx

        MOV     CX, dx
        MOV     DX, 4240H
        MOV     AH, 86H
        INT     15H

        mov cx,savedCX
        mov dx,savedDX


        mov si,dx
        xor dh,dh    ; Optimized: XOR is faster than MOV for zeroing
        
        cmp numbersgeneratedflag[si],0
        je randgen
        
        dec numbersgeneratedflag[si]
        
        xor ax,ax
        mov al,totalloadednumbers
        mov si,ax
        mov numberlocarray[si],dl
        inc totalloadednumbers
        
        ; Show loading progress
        call ShowLoadingProgress
           
        jmp  randgenprogstart
        

       DRAWINGTHENUMBERGRID:
       ; Clear screen after loading is complete
       mov ax, 3
       int 10h
       
       xor si,si          ; Optimized: XOR faster than MOV for zeroing
       
       xor cx,cx
       mov cl,verticalsize
       inc cx
        
       outergridnumber:
       mov savedCX,cx     ; Fixed: use savedCX consistently
        
       mov cl,horizontalsize
       inc cl
        
       innergridnumber:
       mov ah,2
       mov dl,numberlocarray[si]
       add dl,30h
       int 21h
       inc si 
       loop innergridnumber
       ; Print newline (CR+LF)
       mov dl,0dh
       int 21h
       mov dl,0ah
       int 21h
        
       mov cx,savedCX
       loop outergridnumber

       call DelayShort    ; Use procedure instead of inline delay

       xor dx,dx          ; Optimized: XOR faster than MOV
       call SetCursor     ; Use procedure
        
        DRAWINGTHEGRID:
       xor cx,cx
       mov cl,verticalsize
       inc cx
        
       outergrid:
       mov savedCX,cx
        
       mov cl,horizontalsize
       inc cl
        
       innergrid:
       mov dl,5
       call PrintChar    ; Use procedure
       loop innergrid
       ; Print newline
       mov dl,0dh
       call PrintChar
       mov dl,0ah
       call PrintChar
        
       mov cx,savedCX
       loop outergrid
        
       mov dx,pointer
       call SetCursor    ; Use procedure
        
        DIRECTIONS:
        mov ah,2
        mov bh,0
        mov dh,verticalsize
        add dh,1
        mov dl,0
        int 10h 
        
        mov ah,9
        lea dx,attemptsremaining
        int 21h
        mov ah,2
        mov dl,attempts
        add dl,30h
        int 21h
        
        cmp dl,2fh
        je end
        
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        mov ah,totalsize
        cmp totalsolved,ah
        je end
        
        
        
      
        mov ah, 07
        int 21h
      
      
        cmp al,077h
        je moveup
        
        cmp al,73h
        je movedown
        
        cmp al,61h
        je moveleft
        
        cmp al,64h
        je moverright
               
        jmp selection
      
      
        
        moveup:
        
        
        mov ax,pointer
        cmp ah,0
        je wrapverticallyup
        
        dec ah
        mov pointer,ax
        jmp visualchange
        
        wrapverticallyup:
 
        mov ah,verticalsize
        mov pointer,ax
                      
        jmp visualchange
        
        movedown:
        mov ax,pointer
        cmp ah,verticalsize
        je wrapverticallydown
                          
        inc ah
        mov pointer,ax
        jmp visualchange
        
        wrapverticallydown:
 
        mov ah,0
        mov pointer,ax
                      
        jmp visualchange
        
        
        
        
        
        moveleft:
        mov ax,pointer
        cmp al,0
        je wraphorizontallyleft
        
        dec al
        mov pointer,ax
        jmp visualchange
        
        wraphorizontallyleft:
 
        mov al,horizontalsize
        mov pointer,ax
                      
        jmp visualchange
        
        
        
        moverright:
        
        mov ax,pointer
        cmp al,horizontalsize
        je wraphorizontallyright
        
        inc al
        mov pointer,ax
        jmp visualchange
        
        wraphorizontallyright:
 
        mov al,0
        mov pointer,ax
                      
        jmp visualchange
        
        
        
        
        
        VISUALCHANGE:
        
        cmp prevcardwasnumber,1
        je  withpointer
        
        
        mov dx,prevpointer  
        mov al,dh
        mov bl,horizontalsize
        inc bl
        mul bl
        add al,dl
        
        
        mov si,ax
        
        
        cmp cardsfacedup[si],1
        je withpointer
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        mov ah,2
        mov bh,0
        mov dx,prevpointer
        int 10h
        
        mov dl,5
        int 21h
        
        
        withpointer:
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
        
        
        mov prevcardwasnumber,0
        
        
        
        
        mov dx,pointer 

        mov al,dh
        mov bl,horizontalsize
        inc bl
        mul bl
        add al,dl
        
        
        mov si,ax 
        
        
        cmp cardsfacedup[si],1
        je directions
        
        
        
        
        
        
        
        
        
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        mov dl,6 
        int 21h
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
        
        mov dx,pointer
        mov prevpointer,dx
        
        jmp directions
        
        
        
        Selection:; User has selected this card
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h;moving the cursor to the pointer loc
        
        
        ;checking if the user is selecting an already facedup card
        
        
        mov dx,pointer
        mov al,dh
        mov bl,horizontalsize
        inc bl
        mul bl
        add al,dl
        
        
        mov si,ax
        
        cmp cardsfacedup[si],1;checking if the user is selecting an already facedup card
        je directions
        
        
        cmp prevcardnumber,0;IF no previous card has been selected to match against
        je selectionprogstart
        
        
        mov al,prevcardnumber
        cmp numberlocarray[si],al
        
        je MATCHFOUND
        
        jmp MATCHNOTFOUND
        
        
        
        
        
        
        
        
        
        SELECTIONPROGSTART:;calculating the loation of the card in the array
        
        mov dx,pointer 
        
        mov prevcardpointerloc,dx
        
        
        mov al,dh
        mov bl,horizontalsize
        inc bl
        mul bl
        add al,dl
        
        
        mov si,ax
        mov prevcardpointerlocarray, si;storing card's pointer location for future reference
        
        xor dx,dx 
        mov ah,2                 
        
        mov dl,numberlocarray[si]
        
        mov prevcardnumber,dl;;storing card's number location for future reference
        
        mov cardsfacedup[si],1
        add dl,30h
        int 21h
        
        
        
        
        
        
        
        mov prevcardwasnumber,1
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
        
        
        jmp directions
        
        
        
        
        
        
        
        
        
        
        MATCHFOUND:
        add totalsolved,2
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
      
        xor dx,dx 
        mov ah,2                 
        
        mov dl,numberlocarray[si]
        mov cardsfacedup[si],1
        
        add dl,30h
        int 21h
                
                
        mov prevcardwasnumber,1        
                
        mov prevcardnumber,0        
                
                
                
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h       
                
                
        
        
        jmp directions
      
      
      
      
      
      
      
      
        MATCHNOTFOUND:
        dec attempts
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
        
        
        
        xor dx,dx 
        mov ah,2                 
        
        mov dl,numberlocarray[si]
        mov cardsfacedup[si],0
        
        add dl,30h
        int 21h
        
        ;show card temporarilly
        
        MOV     CX, 0FH
        MOV     DX, 4240H
        MOV     AH, 86H
        INT     15H
        
        ;face down both cards 
        
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
        
        xor dx,dx 
        mov ah,2                 
        
        mov dl,5
        mov cardsfacedup[si],0
        
        
        int 21h
                
                
        mov prevcardwasnumber,0        
                
        mov prevcardnumber,0
        
        
                
        mov ah,2
        mov bh,0
        mov dx,prevcardpointerloc
        int 10h        
                
        mov cx,prevcardpointerlocarray
        mov si,cx        
        mov dl,5
        
        
        
        int 21h
        
        
        mov ah,2
        mov bh,0
        mov dx,pointer
        int 10h
        
        mov cardsfacedup[si],0        
                
                
                
                
        
        
        jmp directions
      
         END:
         mov ax, 3
         int 10h
        
         cmp attempts,0FFh
         je GameoverB
         
         mov ah,2
         mov bh,0
         mov dh,8
         mov dl,24
         int 10h
         mov ah,9
         lea dx,topborder
         int 21h
         
         mov ah,2
         mov dh,9
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,title2
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,10
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,congrats
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,11
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,title2
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,12
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,pressanykey
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,13
         mov dl,24
         int 10h
         mov ah,9
         lea dx,bottomborder
         int 21h
         
         mov ah,1
         int 21h
         
         jmp thegame
      
         GameoverB:
         mov ax, 3
         int 10h
         
         mov ah,2
         mov bh,0
         mov dh,8
         mov dl,24
         int 10h
         mov ah,9
         lea dx,topborder
         int 21h
         
         mov ah,2
         mov dh,9
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,title2
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,10
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,gameover
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,11
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,title2
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,12
         mov dl,24
         int 10h
         mov ah,9
         lea dx,sideborder
         int 21h
         mov ah,9
         lea dx,pressanykey
         int 21h
         mov ah,9
         lea dx,sideborder
         int 21h
         
         mov ah,2
         mov dh,13
         mov dl,24
         int 10h
         mov ah,9
         lea dx,bottomborder
         int 21h
         
         mov ah,1
         int 21h
         
        jmp thegame
        
                ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
         
        
    MAIN ENDP
    
    
    GENERATINGNUMBERSFLAG PROC
        xor cx,cx
        mov cl,maxpuzzlenumber
        
        GNF:
        mov si,cx
        mov numbersgeneratedflag[si],2
        loop GNF
        
        ret
    GENERATINGNUMBERSFLAG ENDP 
    
    
    ; ============================================
    ; OPTIMIZED HELPER PROCEDURES
    ; ============================================
    
    ; SetCursor - Sets cursor position
    ; Input: DX = position (DH=row, DL=col)
    SetCursor PROC
        push ax
        push bx
        mov ah,2
        xor bh,bh
        int 10h
        pop bx
        pop ax
        ret
    SetCursor ENDP
    
    ; PrintChar - Prints a single character
    ; Input: DL = character to print
    PrintChar PROC
        push ax
        mov ah,2
        int 21h
        pop ax
        ret
    PrintChar ENDP
    
    ; ClearScreen - Clears the screen using video mode reset
    ClearScreen PROC
        push ax
        mov ax,3
        int 10h
        pop ax
        ret
    ClearScreen ENDP
    
    ; CalcArrayIndex - Calculate array index from pointer position
    ; Input: DX = pointer (DH=row, DL=col)
    ; Output: SI = array index
    CalcArrayIndex PROC
        push ax
        push bx
        mov al,dh
        mov bl,horizontalsize
        inc bl
        mul bl
        add al,dl
        xor ah,ah
        mov si,ax
        pop bx
        pop ax
        ret
    CalcArrayIndex ENDP
    
    ; DelayShort - Short delay for visual feedback
    DelayShort PROC
        push ax
        push cx
        push dx
        MOV CX, 0Fh
        MOV DX, 4240H
        MOV AH, 86H
        INT 15H
        pop dx
        pop cx
        pop ax
        ret
    DelayShort ENDP
    
    ShowLoadingProgress PROC
        push ax
        push bx
        push cx
        push dx
        
        mov ah,2
        xor bh,bh
        mov dh,11
        mov dl,30
        int 10h
        
        xor ax,ax
        mov al,totalloadednumbers
        mov bl,100
        mul bl
        
        xor bx,bx
        mov bl,totalsize
        xor dx,dx
        div bx
        
        cmp ax,100
        jl NotHundred
        
        push ax
        mov ah,2
        mov dl,'1'
        int 21h
        mov dl,'0'
        int 21h
        mov dl,'0'
        int 21h
        pop ax
        jmp PrintPercent
        
    NotHundred:
        cmp ax,10
        jl SingleDigit
        
        push ax
        xor dx,dx
        mov bx,10
        div bx
        push dx
        
        mov ah,2
        add al,30h
        mov dl,al
        int 21h
        
        pop dx
        add dl,30h
        int 21h
        pop ax
        jmp PrintPercent
        
    SingleDigit:
        mov ah,2
        mov dl,' '
        int 21h
        mov dl,al
        add dl,30h
        int 21h
        
    PrintPercent:
        mov ah,9
        lea dx,percentmsg
        int 21h
        
        mov ah,2
        xor bh,bh
        mov dh,12
        mov dl,27
        int 10h
        
        mov ah,2
        mov dl,'['
        int 21h
        
        xor ax,ax
        mov al,totalloadednumbers
        mov bl,20
        mul bl
        xor bx,bx
        mov bl,totalsize
        xor dx,dx
        div bx
        
        mov cx,ax
        push cx
        
        cmp cx,0
        je NoFilledBlocks
    PrintFilled:
        mov ah,2
        mov dl,0DBh
        int 21h
        loop PrintFilled
        
    NoFilledBlocks:
        pop cx
        mov ax,20
        sub ax,cx
        mov cx,ax
        
        cmp cx,0
        je NoEmptyBlocks
    PrintEmpty:
        mov ah,2
        mov dl,0B0h
        int 21h
        loop PrintEmpty
        
    NoEmptyBlocks:
        mov ah,2
        mov dl,']'
        int 21h
        
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    ShowLoadingProgress ENDP
   
   
     END MAIN 
     
     