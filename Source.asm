TITLE Nikolaos Kladis Kountouris #ergasia arithmos 24
INCLUDE Irvine32.inc


.data

A_poly BYTE 02Dh,0CCh,0E4h,0Fh
m_power DWORD 3

B_poly BYTE 0C7h,04Fh,72h
n_power DWORD 2

P_poly DWORD ?
p_power DWORD ?

m1 BYTE "Polynomial A = ",0
m2 BYTE "Polynomial B = ",0
m3 BYTE "Polynomial P = ",0

char1 BYTE " + ",0
char2 BYTE "x^",0


.code

;int multiply ( int *A, int m, int *B, int n, int *P, int *p)

Multiply PROC

push ebp
mov ebp,esp
push edi

mov eax, [ebp+20]
add eax, [ebp+12]
add eax, 1

mov edi, [ebp+24]

jmp cond

lp:
		mov [edi + esi*4], DWORD PTR 0
		inc esi
cond:
		cmp esi, eax
		jl lp




pop edi
mov esp,ebp
pop ebp

ret 24
Multiply ENDP

;void PrintPoly(int P[], int n)

PrintPoly PROC

push ebp
mov ebp,esp
push esi
push edi
push edx

mov esi, 0
mov edi, [ebp+8]

mov al, [edi]
movzx eax, al
call WriteInt

mov edx, OFFSET char1
call WriteString 

inc esi

jmp cond
lp:	
		mov al, [edi + esi]
		call WriteInt
		mov edx, OFFSET char2
		call WriteString
		mov eax, esi
		call WriteInt
		mov edx, OFFSET char1
		call WriteString 
		inc esi

cond:
		
		cmp esi, [ebp+12]
		jl lp

mov al, [edi +esi]
call WriteInt
mov edx, OFFSET char2
call WriteString
mov eax, esi
call WriteInt

pop edx
pop edi
pop esi
mov esp,ebp
pop ebp

ret
PrintPoly ENDP


main PROC

push ebp
mov ebp,esp
sub esp,4


;void PrintPoly(int P[], int n)

mov edx, OFFSET m1
call WriteString 

push m_power
push OFFSET A_poly
call PrintPoly

call Crlf

mov edx, OFFSET m2
call WriteString 

push n_power
push OFFSET B_poly
call PrintPoly

;int multiply ( int *A, int m, int *B, int n, int *P, int *p)

push p_power
push OFFSET P_poly
push n_power
push OFFSET B_poly
push m_power
push OFFSET A_poly
call Multiply

call Crlf

mov edx, OFFSET m3
call WriteString 

push DWORD PTR [ebp-4]
push OFFSET P_poly
call PrintPoly


exit
main ENDP
END main