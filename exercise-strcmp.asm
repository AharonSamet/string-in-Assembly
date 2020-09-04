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
	
	; Check str1 length
	;...
	repne	scasb
	;...
	
	; Check str2 length
	;...
	repne	scasb
	;...
	
	; compare strings lengths
	cmp		ecx, edx
	jne		not_identical
	
	; compare strings
	; ...
	repe	cmpsb
	jne		not_identical

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