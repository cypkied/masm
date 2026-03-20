.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkrexlenia)
extern __read : PROC ; (dwa znaki podkrexlenia)
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
public _main

.data
tekst_pocz db 10, 'Proszx napisax jakix tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?

.code
_main PROC
; wyxwietlenie tekstu informacyjnego
; liczba znakxw tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1 ; nr urzxdzenia (tu: ekran - nr 1)
 call __write ; wyxwietlenie tekstu poczxtkowego
 add esp, 12 ; usuniecie parametrxw ze stosu
; czytanie wiersza z klawiatury
 push 80 ; maksymalna liczba znakxw
 push OFFSET magazyn
 push 0 ; nr urzxdzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znakxw z klawiatury
 add esp, 12 ; usuniecie parametrxw ze stosu
	; kody ASCII napisanego tekstu zostaxy wprowadzone
	; do obszaru 'magazyn'
	; funkcja read wpisuje do rejestru EAX liczbx
	; wprowadzonych znakxw

	mov liczba_znakow, eax ; rejestr ECX pexni rolx licznika obiegxw pxtli
	mov ecx, eax 
	mov ebx, 0 ; indeks poczxtkowy

cmp eax, 3
jb restofcode

ptl:
	jmp changeSpace
dalej:
	loop ptl ; sterowanie pxtlx

jmp restofcode

changeBigLetter:
	cmp magazyn[ecx - 1], 'A'
	jb dalej

	cmp magazyn[ecx - 1], 'Z'
	ja changeSmallLetter

	mov magazyn[ecx - 1], '*'
	jmp dalej

changeSmallLetter:
	cmp magazyn[ecx - 1], 'a'
	jb dalej

	cmp magazyn[ecx - 1], 'z'
	ja dalej

	mov magazyn[ecx - 1], '*'
	jmp dalej

changeSpace:
	cmp magazyn[ecx - 1], ' '
	jne changeNumber

	mov magazyn[ecx - 1], '!'
	jmp dalej

changeNumber:
	cmp magazyn[ecx - 1], '0'
	jb dalej

	cmp magazyn[ecx - 1], '9'
	ja changeBigLetter

	mov magazyn[ecx - 1], '_'
	jmp dalej

restofcode:
push 0 ; stala MB_OK
push OFFSET 0
push OFFSET magazyn
push 0 ; NULL
call _MessageBoxA@16
push 0 ; kod powrotu programu
call _ExitProcess@4
_main ENDP
END