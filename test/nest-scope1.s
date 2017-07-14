	 .section	 .rodata
.S0:
	 .string "scope1[a=%d]\n"
.S1:
	 .string "scope2[a=%d]\n"
.S2:
	 .string "scope3[a=%d]\n"
	.text
	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$64, %rsp

	 mov	 $1, %edi
	 mov	 %edi, -16(%rbp)

	 mov	 $.S0, %rdi
	 mov	 -16(%rbp), %ebx
	 mov	 %rbx, %rsi
	 call	printf
	 mov	%eax, -24(%rbp)

	 jmp	.L0

.L0:

	 mov	 $2, %edi
	 mov	 %edi, -32(%rbp)

	 mov	 $.S1, %rdi
	 mov	 -32(%rbp), %ebx
	 mov	 %rbx, %rsi
	 call	printf
	 mov	%eax, -40(%rbp)

	 jmp	.L1

.L1:

	 mov	 $3, %edi
	 mov	 %edi, -48(%rbp)

	 mov	 $.S2, %rdi
	 mov	 -48(%rbp), %ebx
	 mov	 %rbx, %rsi
	 call	printf
	 mov	%eax, -56(%rbp)

	 jmp	.L2

.L2:

	 jmp	.L3

.L3:

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

