TITLE Program Template     (a.asm)

; Program Description:
; Author:
; Date Created:
; Last Modification Date:

INCLUDE Irvine32.inc


.data
Roll1	BYTE "Press enter to roll the dice",0
Reroll1	BYTE "Whould you like to reroll ?Please type y for yes & type n for no !",0
Reroll2	BYTE "How many dices you want to reroll ?",0
Roll2	BYTE "Choose the dice that you want to reroll.Please press enter key each time:",0
Roll2A	BYTE "Please enter something between 1-5 !!!",0
Fill	BYTE "Choose the place that you want to fill:",0
Fill2	BYTE "Please enter something between 1-12 or different score label !!! ",0
Welcome	BYTE "Welcome to the yahtzee game",0
Str1	BYTE "Order   Combination   Score",0
Total	BYTE "Your total score :",0
Again	BYTE "Whould you like to play again ?Please type y for yes & type n for no.",0
Order		BYTE			 "1       ",0
			BYTE			 "2       ",0
			BYTE			 "3       ",0
			BYTE			 "4       ",0
			BYTE			 "5       ",0
			BYTE			 "6       ",0
			BYTE			 "7       ",0
			BYTE			 "8       ",0
			BYTE			 "9       ",0
			BYTE			 "10      ",0
			BYTE			 "11      ",0
			BYTE			 "12      ",0
			
Combination BYTE			 "Ones          ",0
			BYTE			 "Twos          ",0
			BYTE			 "Threes        ",0
			BYTE			 "Fours         ",0
			BYTE			 "Fives         ",0
			BYTE			 "Sixes         ",0
			BYTE			 "3 of a kind   ",0
			BYTE			 "4 of a kind   ",0
			BYTE			 "Yahtzee       ",0
			BYTE			 "4 in a row    ",0
			BYTE			 "5 in a row    ",0
			BYTE			 "Anything      ",0

Score 		BYTE    12 DUP(0)
ScoreC		BYTE	12 DUP(0)

Die			BYTE	"Die 1:",0
			BYTE	"Die 2:",0
			BYTE	"Die 3:",0
			BYTE	"Die 4:",0
			BYTE	"Die 5:",0
	
Dices		BYTE  5 DUP(0)
RerollD		BYTE  5 Dup(0)
DiceCount  	BYTE  6 DUP(0)
LoopCount	BYTE  0

.code

;-------------------------------------------
main PROC
l100:
call ClrScr
call Randomize
mov eax,0
mov LoopCount,al

mov edi,0
mov esi,0
l101:
mov eax,0
mov Score[edi],al
inc edi
cmp edi,12
jl l101

l102:
mov eax,0
mov ScoreC[esi],al
inc esi
cmp esi,12
jl l102




call Display
loop1:							
mov edx,OFFSET Roll1
call WriteString
jmp l4					
l3:
mov edx,OFFSET Roll1
call WriteString
l4:
call Readchar
call Crlf
cmp al,13
je l2
jne l3
l2:
call RollADice
call DisplayDices

mov esi,0
loop2:
push esi
mov edx,OFFSET Reroll1
call WriteString
jmp l8
l7:
mov edx,OFFSET Reroll1
call WriteString
l8:
call ReadChar
call Crlf
cmp al,'y'
je l5
cmp al,'n'
je l6
jne l7
l5:
mov edx,OFFSET Reroll2
call WriteString
jmp l13
l12:
mov edx,OFFSET Reroll2
call WriteString
l13:
call ReadInt
cmp eax,0
je l6
cmp eax,1
jge l9
jmp l10
l9:
cmp eax,5
jle l11
l10:
jmp l12 

l11:
mov esi,eax
loop3:
mov edx,OFFSET Roll2
call WriteString
jmp l18
l17:
mov edx,OFFSET Roll2A
call WriteString
l18:
call ReadInt
cmp eax,1
jge l14
jmp l15
l14:
cmp eax,5
jle l16
l15:
jmp l17 
l16:
mov edi,eax
dec edi
mov ebx,1
mov RerollD[edi],bl
dec esi
cmp esi,0
jg loop3
call RerollADice
call DisplayDices
call Crlf

pop esi
inc esi
cmp esi,2
jl loop2



l6:
mov edx,OFFSET Fill
call WriteString
jmp l23
l22:
mov edx,OFFSET Fill2
call WriteString
l23:
call ReadInt
call Crlf
cmp eax,1
jge l24
jmp l20
l24:
cmp eax,12
jle l21
l20:
jmp l22 
l21:
mov esi,eax
dec esi
call ScoreCheck
cmp ebx,1
je l22

mov ScoreC[esi],1

cmp eax,1
je score1
cmp eax,2
je score2
cmp eax,3
je score3
cmp eax,4
je score4
cmp eax,5
je score5
cmp eax,6
je score6
cmp eax,7
je score7
cmp eax,8
je score8
cmp eax,9
je score9
cmp eax,10
je score10
cmp eax,11
je score11
cmp eax,12
je score12


score1:
push esi
call CalOnes
pop esi
mov Score[esi],bl
jmp final

score2:
push esi
call CalTwos
pop esi
mov Score[esi],bl
jmp final

score3:
push esi
call CalThrees
pop esi
mov Score[esi],bl
jmp final

score4:
push esi
call CalFours
pop esi
mov Score[esi],bl
jmp final

score5:
push esi
call CalFives
pop esi
mov Score[esi],bl
jmp final

score6:
push esi
call CalSixes
pop esi
mov Score[esi],bl
jmp final

score7:
push esi
call ThreeOfAKind
pop esi
mov Score[esi],bl
jmp final

score8:
push esi
call FourOfAKind
pop esi
mov Score[esi],bl
jmp final

score9:
push esi
call Yahtzee
pop esi
mov Score[esi],bl
jmp final

score10:
push esi
call FourInARow
pop esi
mov Score[esi],bl
jmp final

score11:
push esi
call FiveInARow
pop esi
mov Score[esi],bl
jmp final

score12:
push esi
call Anything
pop esi
mov Score[esi],bl
jmp final

final:

call Display
mov eax,0
mov al,LoopCount
inc eax
mov LoopCount,al
cmp eax,12
jl loop1


mov ebx,0
mov edi,0
l25:
mov ecx,0
mov cl,Score[edi]
add ebx,ecx
inc edi
cmp edi,12
jl l25

mov edx,OFFSET Total
call WriteString
mov eax,ebx
call WriteDec
call Crlf

mov edx,OFFSET Again
call WriteString
jmp l26
l27:
mov edx,OFFSET Again
call WriteString
l26:
call ReadChar
call Crlf
cmp al,'y'
je l100
cmp al,'n'
je l29
jne l27
l29:


	exit	; exit to operating system
main ENDP
;-------------------------------------------
ScoreCheck PROC
mov ecx,0
mov cl,ScoreC[esi]
cmp ecx,1
je l1
jmp l2
l1:
mov ebx,1
jmp l3
l2:
mov ebx,0
l3:
	ret
ScoreCheck ENDP	
;-------------------------------------------
RerollADice PROC
mov eax,0
mov esi,0
l:
mov al,RerollD[esi]
cmp al,1
je l1
jmp l2
l1:
mov eax,6
call RandomRange
add eax,1
mov Dices[esi],al
l2:

inc esi
cmp esi,5
jl l
mov esi,0

l3:
mov RerollD[esi],0
inc esi
cmp esi,5
jl l3

	ret
RerollADice ENDP	
;-------------------------------------------
RollADice PROC

mov esi,0

l:

mov eax,6
call RandomRange
add eax,1
mov Dices[esi],al
inc esi
cmp esi,5
jl  l


	ret
RollADice ENDP
;------------------------------------
DisplayDices PROC
mov eax,0
mov ebx,0
mov esi,0

l:
mov edx,OFFSET Die
add edx,ebx
call WriteString

mov al,Dices[esi]
call WriteDec
call Crlf
add ebx,7
inc esi
cmp esi,5
jl l


	ret
DisplayDices ENDP
;-------------------------------------
Display PROC

mov edx,OFFSET Welcome
call WriteString
call Crlf
mov edx,OFFSET Str1
call WriteString
call Crlf

mov eax,0
mov ebx,0
mov esi,0


l:
mov edx,OFFSET Order
add edx,eax
call WriteString 

mov edx,OFFSET Combination
add edx,ebx
call WriteString

push eax
mov al,Score[esi]
call WriteDec
call Crlf
pop eax

add eax,9
add ebx,15
inc esi

cmp esi,12
jl l

	ret
Display ENDP
;-------------------------------------
CalOnes	PROC
mov eax,0
mov ebx,0
mov esi,0

l:
mov al,Dices[esi]
cmp al,1
jne r1
add ebx,1
r1:
inc esi
cmp esi,5
jl l
	ret
CalOnes ENDP	

;----------------------------------
CalTwos	PROC
mov eax,0
mov ebx,0
mov esi,0

l:
mov al,Dices[esi]
cmp al,2
jne r1
add ebx,2
r1:
inc esi
cmp esi,5
jl l
	ret
CalTwos ENDP
;-----------------------------------
CalThrees	PROC
mov eax,0
mov ebx,0
mov esi,0

l:
mov al,Dices[esi]
cmp al,3
jne r1
add ebx,3
r1:
inc esi
cmp esi,5
jl l
	ret
CalThrees ENDP	
;---------------------------------------
CalFours	PROC
mov eax,0
mov ebx,0
mov esi,0

l:
mov al,Dices[esi]
cmp al,4
jne r1
add ebx,4
r1:
inc esi
cmp esi,5
jl l
	ret
CalFours ENDP
;------------------------------
CalFives	PROC
mov eax,0
mov ebx,0
mov esi,0

l:
mov al,Dices[esi]
cmp al,5
jne r1
add ebx,5
r1:
inc esi
cmp esi,5
jl l
	ret
CalFives ENDP
;-----------------------------
CalSixes	PROC
mov eax,0
mov ebx,0
mov esi,0

l:
mov al,Dices[esi]
cmp al,6
jne r1
add ebx,6
r1:
inc esi
cmp esi,5
jl l
	ret
CalSixes ENDP
;---------------------------------
ThreeOfAKind PROC
mov esi,0
mov ebx,0

l1:
movzx edi,Dices[esi]
dec edi
mov bl,DiceCount[edi]
inc bl
mov DiceCount[edi],bl
inc esi
cmp esi,5
jl l1

mov esi,0
l3:
mov al,DiceCount[esi]
cmp al,3
jge l4
inc esi
cmp esi,6
jl l3
jmp l6

l4:
mov esi,0
mov ebx,0
mov eax,0
l5:
mov al,Dices[esi]
add ebx,eax
inc esi
cmp esi,5
jl l5
jmp l7

l6:
mov ebx,0
l7:

mov esi,0
l2:
mov DiceCount[esi],0
inc esi
cmp esi,6
jl l2

	ret
ThreeOfAKind ENDP
;--------------------------------
FourOfAKind PROC
mov esi,0
mov ebx,0

l1:
movzx edi,Dices[esi]
dec edi
mov bl,DiceCount[edi]
inc bl
mov DiceCount[edi],bl
inc esi
cmp esi,5
jl l1

mov esi,0
l3:
mov al,DiceCount[esi]
cmp al,4
jge l4
inc esi
cmp esi,6
jl l3
jmp l6

l4:
mov esi,0
mov ebx,0
mov eax,0
l5:
mov al,Dices[esi]
add ebx,eax
inc esi
cmp esi,5
jl l5
jmp l7
l6:
mov ebx,0
l7:

mov esi,0
l2:
mov DiceCount[esi],0
inc esi
cmp esi,6
jl l2
	ret
FourOfAKind ENDP
;--------------------------------
Yahtzee PROC
mov esi,0
mov ebx,0

l1:
movzx edi,Dices[esi]
dec edi
mov bl,DiceCount[edi]
inc bl
mov DiceCount[edi],bl
inc esi
cmp esi,5
jl l1

mov esi,0
l3:
mov al,DiceCount[esi]
cmp al,5
je l4
inc esi
cmp esi,6
jl l3
jmp l6

l4:
mov ebx,50
jmp l7
l6:
mov ebx,0
l7:

mov esi,0
l2:
mov DiceCount[esi],0
inc esi
cmp esi,6
jl l2
	ret
Yahtzee ENDP
;-------------------------------
FourInARow PROC
mov eax,0
mov ebx,0
mov ecx,0
mov esi,0
mov edi,0


l2:
movzx eax,Dices[edi]
cmp eax,1
je l4
cmp eax,2
je l4
cmp eax,3
je l4
inc edi
cmp edi,6
jl l2
jmp l5

l4:
inc eax
inc ecx
mov esi,0
l6:
movzx ebx,Dices[esi]
inc esi
cmp eax,ebx
je l4
cmp esi,6
jl l6

cmp ecx,4
jge l3
mov ecx,0
inc edi
cmp edi,6
jl l2


l5:
mov ebx,0
jmp l1
l3:
mov ebx,20
l1:
	ret
FourInARow ENDP
;--------------------------------
FiveInARow PROC
mov eax,0
mov ebx,0
mov ecx,0
mov esi,0
mov edi,0


l2:
movzx eax,Dices[edi]
cmp eax,1
je l4
cmp eax,2
je l4
inc edi
cmp edi,6
jl l2
jmp l5

l4:
inc eax
inc ecx
mov esi,0
l6:
movzx ebx,Dices[esi]
inc esi
cmp eax,ebx
je l4
cmp esi,6
jl l6

cmp ecx,5
je l3
mov ecx,0
inc edi
cmp edi,6
jl l2


l5:
mov ebx,0
jmp l1
l3:
mov ebx,30
l1:
	ret
FiveInARow ENDP
;-------------------------------
Anything PROC
mov esi,0
mov ebx,0
mov eax,0
l:
mov al,Dices[esi]
add ebx,eax
inc esi
cmp esi,5
jl l
	ret
Anything ENDP
;----------------------------------

	


; (insert additional procedures here)

END main