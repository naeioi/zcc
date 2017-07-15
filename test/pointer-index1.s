	 .section	 .rodata
.S0:
	 .string "c[5]=%d\n"
	.text
	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$56, %rsp

	 mov	 $5, %edi
	 mov	 %edi, -24(%rbp)

	 mov	 $40, %eax
	 mov	 %rax, %rdi
	 mov	 $0, %rax
	 call	malloc
	 mov	 %rax, -32(%rbp)

	 mov	 -32(%rbp), %rdi
	 mov	 %rdi, -16(%rbp)

	 movsx	 -24(%rbp), %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -16(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -32(%rbp)

	 mov	 $10, %edi
	 mov	 -32(%rbp), %rax
	 mov	 %edi, (%rax)

	 mov	 $5, %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -16(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -40(%rbp)

	 mov	 $.S0, %rax
	 mov	 %rax, %rdi
	 mov	 -40(%rbp), %rax
	 mov	 (%rax), %eax
	 mov	 %rax, %rsi
	 mov	 $0, %rax
	 call	printf
	 mov	 %eax, -48(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

