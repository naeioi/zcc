	.text
	 .globl	mul
	 .type	mul, @function
mul:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$72, %rsp
	 mov	%rdi, -8(%rbp)
	 mov	%rsi, -16(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -24(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -32(%rbp)

.L0:

	 mov	 -32(%rbp), %edi
	 cmp	 -16(%rbp), %edi
	 setl	 %al
	 movzx	 %al, %eax
	 mov	 %eax, -48(%rbp)

	 cmpl	 $1, -48(%rbp)
	 je	 .L1

	 jmp	.L2

.L1:

	 mov	 -24(%rbp), %edi
	 add	 -8(%rbp), %edi
	 mov	 %edi, -48(%rbp)

	 mov	 -48(%rbp), %edi
	 mov	 %edi, -24(%rbp)

	 mov	 -32(%rbp), %edi
	 mov	 %edi, -48(%rbp)

	 incl 	 -32(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -40(%rbp)

.L3:

	 mov	 -40(%rbp), %edi
	 cmp	 $10, %edi
	 setl	 %al
	 movzx	 %al, %eax
	 mov	 %eax, -56(%rbp)

	 cmpl	 $1, -56(%rbp)
	 je	 .L4

	 jmp	.L5

.L6:

	 mov	 -40(%rbp), %edi
	 mov	 %edi, -64(%rbp)

	 incl 	 -40(%rbp)

	 jmp	.L3

.L4:

	 mov	 -24(%rbp), %edi
	 add	 -40(%rbp), %edi
	 mov	 %edi, -56(%rbp)

	 mov	 -56(%rbp), %edi
	 mov	 %edi, -24(%rbp)

	 jmp	.L5

	 jmp	.L3

	 jmp	.L6

.L5:

	 mov	 -24(%rbp), %edi
	 add	 $1, %edi
	 mov	 %edi, -56(%rbp)

	 mov	 -56(%rbp), %edi
	 mov	 %edi, -24(%rbp)

	 jmp	.L2

	 jmp	.L0

.L2:

	 mov	 -24(%rbp), %eax
	 leave
	 ret

	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$24, %rsp

	 mov	 $1, %ebx
	 mov	 %rbx, %rdi
	 mov	 $10, %ebx
	 mov	 %rbx, %rsi
	 call	mul
	 mov	%eax, -16(%rbp)

	 mov	 -16(%rbp), %edi
	 mov	 %edi, -8(%rbp)

	 mov	 $0, %eax
	 leave
	 ret

