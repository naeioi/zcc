	 .section	 .rodata
.S0:
	 .string "==== Nested Test ====\n"
.S1:
	 .string "scope1[a=%d]\n"
.S2:
	 .string "scope2[a=%d]\n"
.S3:
	 .string "scope3[a=%d]\n"
.S4:
	 .string "\n"
.S5:
	 .string "=== Expr Text ===\n"
.S6:
	 .string "1 * 2 + 3 - (2 * (1 + 2)) = %d. (should be -1)\n\n"
	.text
	 .globl	nested
	 .type	nested, @function
nested:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$80, %rsp

	 mov	 $1, %edi
	 mov	 %edi, -16(%rbp)

	 mov	 $.S0, %rdi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -24(%rbp)

	 mov	 $.S1, %rdi
	 mov	 -16(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -32(%rbp)

	 jmp	.L0

.L0:

	 mov	 $2, %edi
	 mov	 %edi, -40(%rbp)

	 mov	 $.S2, %rdi
	 mov	 -40(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -48(%rbp)

	 jmp	.L1

.L1:

	 mov	 $3, %edi
	 mov	 %edi, -56(%rbp)

	 mov	 $.S3, %rdi
	 mov	 -56(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -64(%rbp)

	 jmp	.L2

.L2:

	 jmp	.L3

.L3:

	 mov	 $.S4, %rdi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -72(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

	 .globl	expr
	 .type	expr, @function
expr:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$56, %rsp

	 mov	 $.S5, %rdi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -16(%rbp)

	 mov	 $1, %edi
	 imull	 $2, %edi
	 mov	 %edi, -24(%rbp)

	 mov	 -24(%rbp), %edi
	 add	 $3, %edi
	 mov	 %edi, -24(%rbp)

	 mov	 $1, %edi
	 add	 $2, %edi
	 mov	 %edi, -32(%rbp)

	 mov	 $2, %edi
	 imull	 -32(%rbp), %edi
	 mov	 %edi, -40(%rbp)

	 mov	 -24(%rbp), %edi
	 sub	 -40(%rbp), %edi
	 mov	 %edi, -24(%rbp)

	 mov	 $.S6, %rdi
	 mov	 -24(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -48(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

	 .globl	main
	 .type	main, @function
main:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$32, %rsp

	 mov $0, %rax
	 call	nested
	 mov	%eax, -16(%rbp)

	 mov $0, %rax
	 call	expr
	 mov	%eax, -24(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

