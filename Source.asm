TITLE Assembly Project
INCLUDE Irvine32.inc

.data

string BYTE "message",0

.code


main PROC


mov eax, 12
call WriteInt

call Crlf

mov edx, OFFSET string
call WriteString



exit
main ENDP
END main