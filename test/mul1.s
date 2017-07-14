	.text
	 .globl	mul
	 .type	mul, @function
mul:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$64, %rsp
	 mov	%rdi, -16(%rbp)
	 mov	%rsi, -24(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -40(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -32(%rbp)

.L0:

	 mov	 -32(%rbp), %edi
	 cmp	 -24(%rbp), %edi
	 setl	 %al
	 movzx	 %al, %eax
	 mov	 %eax, -48(%rbp)

	 cmpl	 $1, -48(%rbp)
	 je	 .L1

	 jmp	.L2

.L3:

	 mov	 -32(%rbp), %edi
	 mov	 %edi, -56(%rbp)

	 incl 	 -32(%rbp)

	 jmp	.L0

.L1:

	 mov	 -40(%rbp), %edi
	 add	 -16(%rbp), %edi
	 mov	 %edi, -48(%rbp)

	 mov	 -48(%rbp), %edi
	 mov	 %edi, -40(%rbp)

	 jmp	.L3

.L2:

	 mov	 -40(%rbp), %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

	 .globl	fac
	 .type	fac, @function
fac:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$48, %rsp
	 mov	%rdi, -16(%rbp)

	 mov	 -16(%rbp), %edi
	 cmp	 $1, %edi
	 sete	 %al
	 movzx	 %al, %eax
	 mov	 %eax, -24(%rbp)

	 cmpl	 $1, -24(%rbp)
	 je	 .L4

	 jmp	.L5

.L4:

	 mov	 $1, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

	 jmp	.L6

.L5:

	 mov	 -16(%rbp), %edi
	 sub	 $1, %edi
	 mov	 %edi, -24(%rbp)

	 mov	 -24(%rbp), %ebx
	 mov	 %rbx, %rdi
	 call	fac
	 mov	%eax, -32(%rbp)

	 mov	 -32(%rbp), %ebx
	 mov	 %rbx, %rdi
	 mov	 -16(%rbp), %ebx
	 mov	 %rbx, %rsi
	 call	mul
	 mov	%eax, -40(%rbp)

	 mov	 -40(%rbp), %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

.L6:

	 .globl	fac2
	 .type	fac2, @function
fac2:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$48, %rsp
	 mov	%rdi, -16(%rbp)

	 mov	 $2, %edi
	 mov	 %edi, -24(%rbp)

	 mov	 $1, %edi
	 mov	 %edi, -32(%rbp)

.L7:

	 jmp	.L8

.L8:

	 mov	 -24(%rbp), %edi
	 cmp	 -16(%rbp), %edi
	 setg	 %al
	 movzx	 %al, %eax
	 mov	 %eax, -40(%rbp)

	 cmpl	 $1, -40(%rbp)
	 je	 .L9

	 jmp	.L10

.L9:

	 jmp	.L11

	 jmp	.L10

.L10:

	 mov	 -24(%rbp), %ebx
	 mov	 %rbx, %rdi
	 mov	 -32(%rbp), %ebx
	 mov	 %rbx, %rsi
	 call	mul
	 mov	%eax, -40(%rbp)

	 mov	 -40(%rbp), %edi
	 mov	 %edi, -32(%rbp)

	 jmp	.L7

	 mov	 -32(%rbp), %edi
	 mov	 %edi, -40(%rbp)

	 incl 	 -32(%rbp)

.L11:

	 mov	 -32(%rbp), %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

