TITLE Assembly Project
INCLUDE Irvine32.inc

.data


array SWORD 10d,20d,30d,40d,50d,60d,70d,80d,90d,100d
message1 BYTE "Mean = ",0
message2 BYTE "Variance = ",0

.code


CalculateMean PROC





ret
CalculateMean ENDP


CalculateVariance PROC




ret
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