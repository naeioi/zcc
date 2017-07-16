	 .section	 .rodata
.S0:
	 .string "*a=%d\n"
	.text
	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$40, %rsp

	 mov	 $4, %eax
	 mov	 %rax, %rdi
	 mov	 $0, %rax
	 call	malloc
	 mov	 %eax, -24(%rbp)

	 mov	 -24(%rbp), %edi
	 mov	 %rdi, -16(%rbp)

	 mov	 $2, %edi
	 mov	 -16(%rbp), %rax
	 mov	 %edi, (%rax)

	 mov	 $.S0, %rax
	 mov	 %rax, %rdi
	 mov	 -16(%rbp), %rax
	 mov	 (%rax), %eax
	 mov	 %rax, %rsi
	 mov	 $0, %rax
	 call	printf
	 mov	 %eax, -32(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

