.686 
.model flat 
 
public _wariancja

.code 

_wariancja PROC
	push ebp ; [ebp]
	mov ebp, esp
	pusha
	sub esp, 8
	mov eax, 0
	mov [esp], eax
	mov eax, 1
	mov [esp + 4], eax

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]

	fild DWORD PTR [esp]

	srednia:
		fld QWORD PTR [ebx + ecx * 8 - 8]
		faddp st(1), st(0)
	loop srednia

	fild DWORD PTR [ebp + 12]
	fdivp st(1), st(0)

	mov ecx, [ebp + 12]
	odejmowanie:
		fld QWORD PTR [ebx + ecx * 8 - 8]
		fsub st(0), st(1)
		fstp QWORD PTR [ebx + ecx * 8 - 8]
	loop odejmowanie

	fstp st(0)

	mov ecx, [ebp + 12]
	potegowanie:
		fld QWORD PTR [ebx + ecx * 8 - 8]
		fmul st(0), st(0)
		fstp QWORD PTR [ebx + ecx * 8 - 8]
	loop potegowanie

	fild DWORD PTR [esp]
	mov ecx, [ebp + 12]
	dodawanie:
		fld QWORD PTR [ebx + ecx * 8 - 8]
		faddp st(1), st(0)
	loop dodawanie

	fild DWORD PTR [ebp + 12]
	fdivp st(1), st(0)
	
	add esp, 8
	popa
	pop ebp
	ret
_wariancja ENDP

END 