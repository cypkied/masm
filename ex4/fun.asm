.686 
.model flat 
 
public _szukaj_max 
 
.code 
 
_szukaj_max PROC 
 push  ebp  ; zapisanie zawartoœci EBP na stosie 
 mov  ebp, esp ; kopiowanie zawartoœci ESP do EBP 
 
mov  eax, [ebp+8] ; liczba x 
cmp  eax, [ebp+12] ; porownanie liczb x i y 
jge  x_wieksza  ; skok, gdy x >= y 
 
; przypadek x < y 
mov  eax, [ebp+12] ; liczba y 
cmp  eax, [ebp+16] ; porownanie liczb y i z 
jge  y_wieksza  ; skok, gdy y >= z 
 
; przypadek y < z 
; zatem z jest liczb¹ najwieksz¹ 
wpisz_z: mov eax, [ebp+16] ; liczba z 
 
zakoncz: 
pop  ebp 
ret 
 
x_wieksza: 
cmp  eax, [ebp+16] ; porownanie x i z 
jge  zakoncz  ; skok, gdy x >= z 
jmp  wpisz_z 
 
y_wieksza: 
mov  eax, [ebp+12] ; liczba y 
jmp  zakoncz 
 
_szukaj_max ENDP

_szukaj4_max PROC 
	push  ebp  ; zapisanie zawartoœci EBP na stosie 
	mov  ebp, esp ; kopiowanie zawartoœci ESP do EBP 
 
	mov eax, [ebp+8] ; liczba a
	jmp b_

	zakoncz: 
		pop  ebp 
		ret

	b_:
		cmp eax, [ebp + 12]
		jg c_
		mov eax, [ebp + 12]
		jmp c_

	c_:
		cmp eax, [ebp + 16]
		jg d_
		mov eax, [ebp + 16]
		jmp d_
	d_:
		cmp eax, [ebp + 20]
		jg zakoncz
		mov eax, [ebp + 20]
		jmp zakoncz
_szukaj4_max ENDP 

_liczba_przeciwna PROC
	push  ebp  ; zapisanie zawartoœci EBP na stosie 
	mov  ebp,esp ; kopiowanie zawartoœci ESP do EBP 
	push  ebx  ; przechowanie zawartoœci rejestru EBX 
 
	; wpisanie do rejestru EBX adresu zmiennej zdefiniowanej 
	; w kodzie w jêzyku C 
	mov    ebx, [ebp+8] 
 
	mov  eax, [ebx] ; odczytanie wartoœci zmiennej 
	neg  eax   ; dodanie 1 
	mov  [ebx], eax ; odes³anie wyniku do zmiennej 
  
	; uwaga: trzy powy¿sze rozkazy mo¿na zast¹piæ jednym rozkazem 
	; w postaci:  inc   dword PTR [ebx] 
  
	pop  ebx 
	pop  ebp 
	ret
_liczba_przeciwna ENDP

_odejmij_jeden PROC
	push ebp
	mov ebp, esp
	push eax
	push ebx

	mov ebx, dword ptr [ebp + 8]
	mov ebx, dword ptr [ebx]
	mov eax, dword ptr [ebx]
	sub eax, 1
	mov [ebx], eax

	pop ebx
	pop eax
	pop ebp
	ret
_odejmij_jeden ENDP

_przestaw PROC 
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]
	dec ecx
	
	ptl:
		mov eax, [ebx]

		cmp eax, [ebx + 4]
		jle gotowe

		mov edx, [ebx + 4]
		mov [ebx], edx
		mov [ebx + 4], eax
	gotowe:
		add ebx, 4
		loop ptl
		pop ebx
		pop ebp
		ret
_przestaw ENDP

_mediana PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp + 12]; n
	
	mov ecx, 2
	mov edx, 0

	div ecx
	cmp edx, 0
	je parzysta
	jmp nieparzysta

	parzysta:
		mov edx, [ebp + 8]
		add edx, eax
		add edx, eax
		add edx, eax
		add edx, eax

		mov eax, [edx]
		add eax, [edx - 4]

		mov ecx, 2
		mov edx, 0

		div ecx
		jmp koniec

	nieparzysta:
		mov edx, [ebp + 8]
		add edx, eax
		add edx, eax
		add edx, eax
		add edx, eax
		
		mov eax, [edx]
		jmp koniec

	koniec:
		pop ebx
		pop ebp
		ret
_mediana ENDP

_bezwzglednij PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp + 8]
	mov ecx, [ebp + 12]
	
	ptl:
		mov edx, [eax]
		cmp edx, 80000000H
		ja minus

	gotowe:
		add eax, 4
		loop ptl

	

		pop ebx
		pop ebp
		ret
	minus:
		neg edx
		mov [eax], edx
		jmp gotowe
_bezwzglednij ENDP
END 