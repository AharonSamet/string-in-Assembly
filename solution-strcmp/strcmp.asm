include 'win32a.inc'

format PE console
entry start
MAX_STR_SIZE = 0x30

section '.data' data readable writeable
	str1		db	'sometheing', 0
	str2		db	'sometheinx', 0
	same		db	'Identical', 13, 10, 0
	different	db	'Not identical', 13, 10, 0
	
section '.text' code readable executable

start:
	xor   eax, eax
	; Check str1 length
	mov   edi, str1
    mov   ebx, edi            ; mov the addres of the str to register ebx                         
    mov   ecx, 0xffffffff     ; ecx = -1                                           
    repne scasb               ; REPeat while Not Equal [edi] != al
    sub   edi, ebx            ; length = offset of (edi - ebx)  (addres-addres)
	mov   edx, edi			  ; put the length into register edx
	

	; Check str1 length
    xor   eax, eax
	mov   edi, str2
    mov   ebx, edi            ; mov the addres of the str to register ebx                         
    mov   ecx, 0xffffffff     ; ecx = -1                                           
    repne scasb               ; REPeat while Not Equal [edi] != al
    sub   edi, ebx            ; length = offset of (edi - ebx)  (addres-addres)
	mov   ecx, edi			  ; put the length into register ecx
	
	; compare strings lengths
	cmp		ecx, edx
	jne		not_identical
	
	; compare strings
	mov     esi, str1
	mov     edi, str2
	repe	cmpsb  ;compares two data items in memory (if esi == edi)
	jne		not_identical   ; check the flags

identical:
	mov		esi, same
	call 	print_str
	jmp		done	
	
not_identical:
	mov		esi, different
	call 	print_str
	
done:	
	push	0
	call	[ExitProcess]
	
include 	'training.inc'