TITLE Assembly Project
INCLUDE Irvine32.inc

.data

array SWORD 10,20,30,40,50,60,70,80,90,100
message1 BYTE "Mean = ",0
message2 BYTE "Variance = ",0

.code

;int CalculateMean(int *array, int arraysize, int *mean)

CalculateMean PROC

push ebp
mov ebp,esp
push edi
push esi

mov edi, [ebp+8]
mov esi, 0
mov eax, 0

jmp cond1

lp1:
	add ax, [edi+esi*2]
	inc esi
	cond1: 
		cmp esi, [ebp+12]
		jl lp1

movsx eax,ax
cdq
idiv SDWORD PTR [ebp+12]

mov edi, [ebp+16]
mov [edi], eax


pop esi
pop edi
mov esp,ebp
pop ebp

ret 12

CalculateMean ENDP

;int CalculateVariance(int *array, int arraysize, int mean, int *variance)

CalculateVariance PROC

push ebp
mov ebp,esp
push edi
push esi 
push ebx
push edx

mov edi, [ebp+8]
mov ebx, [ebp+16]
mov esi, 0
mov eax, 0


jmp cond2

lp2:
	movsx edx, SWORD PTR [edi+esi*2]
	sub edx, ebx
	imul edx, edx
	add eax, edx
	inc esi
	cond2:
		cmp esi, [ebp+12]
		jl lp2

	cdq
	idiv SDWORD PTR [ebp+12]

	mov edi, [ebp+20]
	mov [edi], eax

pop edx
pop ebx
pop esi
pop edi
mov esp,ebp
pop ebp

ret 16

CalculateVariance ENDP


main PROC


push ebp
mov ebp,esp

sub esp,8
mov [ebp-4], DWORD PTR 0; int mean
mov [ebp-8], DWORD PTR 0; int variance


;int CalculateMean(int *array, int arraysize, int *mean)

lea edi, [ebp-4]
push edi
push LENGTHOF array
push OFFSET array

call CalculateMean

mov edx, OFFSET message1
call WriteString
call WriteInt
call Crlf



;int CalculateVariance(int *array, int arraysize, int mean, int *variance)

lea edi, [ebp-8]
push edi
push SDWORD PTR [ebp-4]
push LENGTHOF array
push OFFSET array

call CalculateVariance
mov edx, OFFSET message2
call WriteString
call WriteInt
call Crlf



exit
main ENDP
END main