.686 
.model flat 
extern __write : PROC 
extern _ExitProcess@4 : PROC 
extern __read : PROC
public _main 

.data 
	znaki   db 12 dup (0)
	obszar  db 12 dup (?) 
	dziesiec  dd 10 ; mno�nik 

.code
	konwersja_EAX PROC
		pusha

		mov ecx, 0
		mov ebx, 10
		konwersja:
			mov edx, 0
			div ebx
			add edx, '0'
			push edx
			inc ecx
			cmp eax, 0
			jne konwersja

		mov eax, 0

		odwrot:
			pop edx
			mov znaki[eax], dl
			inc eax
		loop odwrot

		mov znaki[eax], ' '

		popa
		ret
	konwersja_EAX ENDP

	wczytaj_do_EAX PROC
		push ebx
		push ecx


		; wczytywanie liczby dziesi�tnej z klawiatury � po wprowadzeniu cyfr nale�y nacisn�� klawisz Enter
		; liczba po konwersji na posta� binarn� zostaje wpisana 
		; do rejestru EAX 

		; deklaracja tablicy do przechowywania wprowadzanych cyfr (w obszarze danych) 

 
		; max ilo�� znak�w wczytywanej liczby 
		push  dword PTR 12 
		push  dword PTR OFFSET obszar ; adres obszaru pami�ci 
		push  dword PTR 0; numer urz�dzenia (0 dla klawiatury) 
		call  __read ; odczytywanie znak�w z klawiatury (dwa znaki podkre�lenia przed read) 
		add  esp, 12 ; usuni�cie parametr�w ze stosu 

		; bie��ca warto�� przekszta�canej liczby przechowywana jest 
		; w rejestrze EAX; przyjmujemy 0 jako warto�� pocz�tkow� 
		mov	eax, 0   
		mov ebx, OFFSET obszar ; adres obszaru ze znakami 
 
		pobieraj_znaki: 
			mov  cl, [ebx] ; pobranie kolejnej cyfry w kodzie ASCII 
			inc  ebx  ; zwi�kszenie indeksu 
			cmp  cl,10 ; sprawdzenie czy naci�ni�to Enter 
			je  byl_enter ; skok, gdy naci�ni�to Enter 
			sub  cl, 30H ; zamiana kodu ASCII na warto�� cyfry 
			movzx ecx, cl ; przechowanie warto�ci cyfry w rejestrze ECX 
 
		; mno�enie wcze�niej obliczonej warto�ci razy 10 
		mul  dword PTR dziesiec         
		add  eax, ecx ; dodanie ostatnio odczytanej cyfry 
		jmp  pobieraj_znaki ; skok na pocz�tek p�tli 
 
		byl_enter: 
			; warto�� binarna wprowadzonej liczby znajduje si� teraz w rejestrze EAX

		pop ecx
		pop ebx
		ret
	wczytaj_do_EAX ENDP

	wyswietl_EAX PROC 
		pusha

		call konwersja_EAX

		push dword PTR 12
		push dword PTR OFFSET znaki
		push dword PTR 1
		call __write

		add esp, 12
		popa

		ret
	wyswietl_EAX ENDP

	ciag_aryt PROC
		pusha

		call wczytaj_do_EAX ;N
		push EAX

		call wczytaj_do_EAX ;A0
		push EAX

		call wczytaj_do_EAX ;R
		push EAX

		pop EBX
		pop EAX
		pop ECX

		ptl:
			call wyswietl_EAX
			add EAX, EBX

			loop ptl

		popa
		ret
	ciag_aryt ENDP

	_main PROC
		call ciag_aryt

		push 0 
		call _ExitProcess@4 
	_main ENDP 

END