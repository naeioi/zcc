	 .section	 .rodata
.S0:
	 .string "*(a + 1) = %d\n"
	.text
	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$72, %rsp

	 mov	 $40, %eax
	 mov	 %rax, %rdi
	 mov	 $0, %rax
	 call	malloc
	 mov	 %eax, -32(%rbp)

	 mov	 -32(%rbp), %edi
	 mov	 %rdi, -16(%rbp)

	 mov	 $1, %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 %edi, -40(%rbp)

	 mov	 -16(%rbp), %rdi
	 mov	 -40(%rbp), %esi
	 add	 %rdi, %rsi
	 mov	 %rsi, -48(%rbp)

	 mov	 $2, %edi
	 mov	 -48(%rbp), %rax
	 mov	 %edi, (%rax)

	 mov	 $1, %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 %edi, -56(%rbp)

	 mov	 -16(%rbp), %rdi
	 mov	 -56(%rbp), %esi
	 add	 %rdi, %rsi
	 mov	 %rsi, -64(%rbp)

	 mov	 $.S0, %rax
	 mov	 %rax, %rdi
	 mov	 -64(%rbp), %rax
	 mov	 (%rax), %eax
	 mov	 %rax, %rsi
	 mov	 $0, %rax
	 call	printf
	 mov	 %eax, -40(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

