[org 0x100]
jmp start

CLS:
	mov ax, 0xb800 		; load video base in ax
	mov es, ax 		; point es to video base
	mov di, 0 		; point di to top left column
nextchar: 
	mov word [es:di], 0x0720 ; clear next char on screen
	add di, 2 		; move to next screen location
	cmp di, 4000 		; has the whole screen cleared
	jne nextchar 		; if no clear next position
	RET

boundary:
	mov ax, 0xb800 		; load video base in ax
	mov es, ax 		; point es to video base
	mov di, 0 		; point di to top left column
	mov cx,2
nextcha: 
	mov word [es:di], 0x08DB ; clear next char on screen
	add di, 2 		; move to next screen location
	dec cx
	cmp di,160
	je exit
	cmp cx, 0 		; has the whole screen cleared
	jne nextcha 		; if no clear next position
	mov cx,2
nn:	
	mov word [es:di], 0x0220 ; clear next char on screen
	add di,2
	dec cx
	cmp di,160
	je exit
	cmp cx,0
	jne nn
	mov cx,2
jmp nextcha
exit:	
RET
printblue: 
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	mov ax, 0xb800
	mov es, ax 		; point es to video base
	mov al, 80 		; load al with columns per row
	mul byte [bp+6] 	; multiply with y position
	add ax, [bp+8] 	; add x position
	shl ax, 1 		; turn into byte offset
	mov di,aX 		; point di to required location
	mov cx, 5 		; load length of string in cx
	mov ah, [bp+4] 		; load attribute in ah


nextchar1:
	mov al,0XDB		; load next char of string
	mov [es:di],AX  	; show this char on screen
	add di, 2 
	PUSH AX		; move to next screen location
	CALL LOP
	POP AX
	DEC CX 
	CMP CX,0
	JNE nextchar1
	mov cx,5
	sub di,10
	push ax
	mov ax,0x07
	mov [es:di],AX
	pop ax
	add di,10
	CMP DI,1758
	JE next
	SUB DI,10
	ADD DI,2
	MOV CX,5
	JMP nextchar1	
next:
	
	mov al,0XDB		; load next char of string
	mov [es:di],AX  	; show this char on screen
	SUB di, 2 
	PUSH AX		; move to next screen location
	CALL LOP
	POP AX
	DEC CX 
	CMP CX,0
	JNE next
	mov cx,5
	ADD di,10
	push ax
	mov ax,0x07
	mov [es:di],AX
	pop ax
	SUB di,10
 	CMP DI,1600
	JE nextchar1 ; repeat the operation cx times
	ADD DI,10
	SUB DI,2
	MOV CX,5
	
	JMP next

	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 6
LOP:

MOV AX,0
MOV BX,0XFFF
HERE1:
DEC BX 
CMP BX,AX
JNE HERE1
MOV BX,0XFFFF
HERE2:
DEC BX 
CMP BX,AX
JNE HERE2

RET

yellow:

	mov ax, 45
	push ax 		; push x position
	mov ax, 10
	push ax 		; push y position
	mov ax, 6 		; blue on black attribute
	push ax 		; push attribute
	call printyellow 		; call the printstr subroutine

	ret

printyellow:

push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	mov ax, 0xb800
	mov es, ax 		; point es to video base
	mov al, 80 		; load al with columns per row
	mul byte [bp+6] 	; multiply with y position
	add ax, [bp+8] 	; add x position
	shl ax, 1 		; turn into byte offset
	mov di,aX 		; point di to required location
	mov cx, 5 		; load length of string in cx
	mov ah, [bp+4] 		; load attribute in ah
nextchr12:
	mov al,0XDB		; load next char of string
	mov [es:di],AX  	; show this char on screen
	add di, 2 
	PUSH AX		; move to next screen location
	CALL yellowLOP
	POP AX
	DEC CX 
	CMP CX,0
	JNE nextchr12
	mov cx,5
	sub di,10
	push ax
	mov ax,0x07
	mov [es:di],AX
	pop ax
	add di,10
	CMP DI,636
	JE next12
	SUB DI,10
	ADD DI,2
	MOV CX,5
	JMP nextchr12	
next12:
	
	mov al,0XDB		; load next char of string
	mov [es:di],AX  	; show this char on screen
	SUB di, 2 
	PUSH AX		; move to next screen location
	CALL yellowLOP
	POP AX
	DEC CX 
	CMP CX,0
	JNE next12
	mov cx,5
	ADD di,10
	push ax
	mov ax,0x07
	mov [es:di],AX
	pop ax
	SUB di,10
 	CMP DI,480
	JE nextchr12 ; repeat the operation cx times
	ADD DI,10
	SUB DI,2
	MOV CX,5
	
	JMP next12

	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 6

yellowLOP:
MOV AX,0
MOV BX,0XFFFF
HqEREQ1:
DEC BX 
CMP BX,AX
JNE HqEREQ1
MOV BX,0XFFFF
HqEREQ2:
DEC BX 
CMP BX,AX
JNE HqEREQ2
RET


Blue:
	mov ax, 45
	push ax 		; push x position
	mov ax, 10
	push ax 		; push y position
	mov ax, 1 		; blue on black attribute
	push ax 		; push attribute
	call printblue 		; call the printstr subroutine

	ret

red:
	mov ax, 20
	push ax 		; push x position
	mov ax, 3
	push ax 		; push y position
	mov ax, 4 		; blue on black attribute
	push ax 		; push attribute
	call printred 		; call the printstr subroutine
	ret
printred:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	mov ax, 0xb800
	mov es, ax 		; point es to video base
	mov al, 80 		; load al with columns per row
	mul byte [bp+6] 	; multiply with y position
	add ax, [bp+8] 	; add x position
	shl ax, 1 		; turn into byte offset
	mov di,aX 		; point di to required location
	mov cx, 5 		; load length of string in cx
	mov ah, [bp+4] 		; load attribute in ah
nextchr1:
	mov al,0XDB		; load next char of string
	mov [es:di],AX  	; show this char on screen
	add di, 2 
	PUSH AX		; move to next screen location
	CALL REDLOP
	POP AX
	DEC CX 
	CMP CX,0
	JNE nextchr1
	mov cx,5
	sub di,10
	push ax
	mov ax,0x07
	mov [es:di],AX
	pop ax
	add di,10
	CMP DI,636
	JE next1
	SUB DI,10
	ADD DI,2
	MOV CX,5
	JMP nextchr1	
next1:
	
	mov al,0XDB		; load next char of string
	mov [es:di],AX  	; show this char on screen
	SUB di, 2 
	PUSH AX		; move to next screen location
	CALL REDLOP
	POP AX
	DEC CX 
	CMP CX,0
	JNE next1
	mov cx,5
	ADD di,10
	push ax
	mov ax,0x07
	mov [es:di],AX
	pop ax
	SUB di,10
 	CMP DI,480
	JE nextchr1 ; repeat the operation cx times
	ADD DI,10
	SUB DI,2
	MOV CX,5
	
	JMP next1

	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 6
REDLOP:

MOV AX,0
MOV BX,0XFF
HEREQ1:
DEC BX 
CMP BX,AX
JNE HEREQ1
MOV BX,0XFFF
HEREQ2:
DEC BX 
CMP BX,AX
JNE HEREQ2
RET

start:
 
	call CLS 		; call the clrscr subroutine
	call boundary
	;call red	
	CALL Blue		
	mov ax, 0x4c00 		; terminate program
	int 0x21