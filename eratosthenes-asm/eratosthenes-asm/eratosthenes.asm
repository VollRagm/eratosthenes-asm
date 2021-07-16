mem_alloc PROTO :QWORD
PUBLIC get_primes

.code

get_primes PROC

	push rbp
	mov rbp, rsp
	sub rsp, 18h ; reserve memory for local vars

	mov [rbp-8h], rcx ; store end

	sub rsp, 20h
	call mem_alloc	; allocate the prime array
	add rsp, 20h

	test rax, rax
	jz return	; fail if allocating memory failed

	mov [rbp-10h], rax	; primeArray

	mov rdi, word ptr 2
	loop1:
		mov r8, [rbp-10h]
		add r8, rdi
		mov r8b, [r8]
		test r8b, r8b	; check if number is marked as prime number already
		jnz skipNumber
		jmp eliminateMultiples	; eliminate all multiples of that number
	
	skipNumber:
		cmp rdi, [rbp-8h] ; check if we have reached the end
		jl jumpToLoop1
		jmp return	
	
	jumpToLoop1:
		inc rdi
		jmp loop1

	eliminateMultiples:
		mov [rbp-18h], rdi
		shl rdi, 1	; get next multiple of number
	loop2:
		mov r8, [rbp-10h]
		add r8, rdi
		mov [r8], byte ptr 1	; mark multiple as non-prime
		mov r9, [rbp-8h]
		cmp rdi, r9
		jl jumpToLoop2	; check if we have reached the end
		mov rdi, [rbp-18h]
		jmp jumpToLoop1

	jumpToLoop2:
		mov r9, [rbp-18h]
		add rdi, r9	; get next multiple of number
		jmp loop2

	fail:
		xor rax, rax
		mov rsp, rbp
		pop rbp
		ret

	return:
	
	mov rax, [rbp-10h]
	mov rsp, rbp
	pop rbp
	ret

get_primes ENDP

END