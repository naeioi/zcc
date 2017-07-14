	 .section	 .rodata
.S0:
	 .string "a=%d, b=%d\n"
	.text
	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$32, %rsp

	 mov	 $1, %edi
	 mov	 %edi, -16(%rbp)

	 mov	 $.S0, %rdi
	 mov	 -16(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov	 $10, %rdx
	 call	printf
	 mov	%eax, -24(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

