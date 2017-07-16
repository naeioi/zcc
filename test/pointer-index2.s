	 .section	 .rodata
.S0:
	 .string "a[%d]=%d\n"
	.text
	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$144, %rsp

	 mov	 $10, %edi
	 mov	 %edi, -16(%rbp)

	 mov	 -16(%rbp), %edi
	 mov	 $4, %esi
	 imul	 %rdi, %rsi
	 mov	 %esi, -32(%rbp)

	 mov	 -32(%rbp), %eax
	 mov	 %rax, %rdi
	 mov	 $0, %rax
	 call	malloc
	 mov	 %rax, -40(%rbp)

	 mov	 -40(%rbp), %rdi
	 mov	 %rdi, -24(%rbp)

	 mov	 $0, %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -24(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -56(%rbp)

	 mov	 $1, %edi
	 mov	 -56(%rbp), %rax
	 mov	 %edi, (%rax)

	 mov	 $1, %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -24(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -64(%rbp)

	 mov	 $1, %edi
	 mov	 -64(%rbp), %rax
	 mov	 %edi, (%rax)

	 mov	 $2, %edi
	 mov	 %edi, -48(%rbp)

.L0:

	 movsx	 -48(%rbp), %rdi
	 movsx	 -16(%rbp), %rsi
	 cmp	 %rsi, %rdi
	 setl	 %al
	 movzx	 %al, %rax
	 mov	 %eax, -72(%rbp)

	 movzx	 -72(%rbp), %rax
	 cmp	 $1, %rax
	 je	 .L1

	 jmp	.L2

.L3:

	 mov	 -48(%rbp), %edi
	 mov	 %edi, -80(%rbp)

	 mov	 -48(%rbp), %eax
	 inc	 %rax
	 mov	 %eax, -48(%rbp)

	 jmp	.L0

.L1:

	 movsx	 -48(%rbp), %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -24(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -72(%rbp)

	 mov	 -48(%rbp), %edi
	 mov	 $1, %esi
	 sub	 %rsi, %rdi
	 mov	 %edi, -88(%rbp)

	 movsx	 -88(%rbp), %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -24(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -96(%rbp)

	 mov	 -48(%rbp), %edi
	 mov	 $2, %esi
	 sub	 %rsi, %rdi
	 mov	 %edi, -104(%rbp)

	 movsx	 -104(%rbp), %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -24(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -112(%rbp)

	 mov	 -96(%rbp), %rdi
	 mov	 (%rdi), %edi
	 mov	 -112(%rbp), %rsi
	 mov	 (%rsi), %esi
	 add	 %rdi, %rsi
	 mov	 %esi, -120(%rbp)

	 mov	 -120(%rbp), %edi
	 mov	 -72(%rbp), %rax
	 mov	 %edi, (%rax)

	 jmp	.L3

.L2:

	 mov	 $0, %edi
	 mov	 %edi, -48(%rbp)

.L4:

	 movsx	 -48(%rbp), %rdi
	 movsx	 -16(%rbp), %rsi
	 cmp	 %rsi, %rdi
	 setl	 %al
	 movzx	 %al, %rax
	 mov	 %eax, -120(%rbp)

	 movzx	 -120(%rbp), %rax
	 cmp	 $1, %rax
	 je	 .L5

	 jmp	.L6

.L7:

	 mov	 -48(%rbp), %edi
	 mov	 %edi, -128(%rbp)

	 mov	 -48(%rbp), %eax
	 inc	 %rax
	 mov	 %eax, -48(%rbp)

	 jmp	.L4

.L5:

	 movsx	 -48(%rbp), %rax
	 leaq	 0(,%rax,4), %rdi
	 mov	 -24(%rbp), %rax
	 add	 %rax, %rdi
	 mov	 %rdi, -120(%rbp)

	 mov	 $.S0, %rax
	 mov	 %rax, %rdi
	 mov	 -48(%rbp), %eax
	 mov	 %rax, %rsi
	 mov	 -120(%rbp), %rax
	 mov	 (%rax), %eax
	 mov	 %rax, %rdx
	 mov	 $0, %rax
	 call	printf
	 mov	 %eax, -136(%rbp)

	 jmp	.L7

.L6:

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

