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
	 .string "=== Expr Test ===\n"
.S6:
	 .string "1 * 2 + 3 - (2 * (1 + 2)) = %d. (should be -1)\n\n"
.S7:
	 .string "=== Loop Test ===\n"
.S8:
	 .string "4 * 5: \n"
.S9:
	 .string "    mul_for(4, 5) = %d\n"
.S10:
	 .string "  mul_while(4, 5) = %d\n"
.S11:
	 .string "           4 * 5  = %d\n"
.S12:
	 .string "\n"
.S13:
	 .string "=== Recursive Test ===\n"
.S14:
	 .string "10! = %d. (should be %d)\n\n"
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

	 .globl	mul_for
	 .type	mul_for, @function
mul_for:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$64, %rsp
	 mov	%rdi, -16(%rbp)
	 mov	%rsi, -24(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -40(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -32(%rbp)

.L4:

	 mov	 -32(%rbp), %edi
	 cmp	 -24(%rbp), %edi
	 setl	 %al
	 movzx	 %al, %eax
	 mov	 %eax, -48(%rbp)

	 cmpl	 $1, -48(%rbp)
	 je	 .L5

	 jmp	.L6

.L7:

	 mov	 -32(%rbp), %edi
	 mov	 %edi, -56(%rbp)

	 incl 	 -32(%rbp)

	 jmp	.L4

.L5:

	 mov	 -40(%rbp), %edi
	 add	 -16(%rbp), %edi
	 mov	 %edi, -48(%rbp)

	 mov	 -48(%rbp), %edi
	 mov	 %edi, -40(%rbp)

	 jmp	.L7

.L6:

	 mov	 -40(%rbp), %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

	 .globl	mul_while
	 .type	mul_while, @function
mul_while:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$56, %rsp
	 mov	%rdi, -16(%rbp)
	 mov	%rsi, -24(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -32(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -40(%rbp)

.L8:

	 jmp	.L9

.L9:

	 mov	 -32(%rbp), %edi
	 cmp	 -24(%rbp), %edi
	 setge	 %al
	 movzx	 %al, %eax
	 mov	 %eax, -48(%rbp)

	 cmpl	 $1, -48(%rbp)
	 je	 .L10

	 jmp	.L11

.L10:

	 jmp	.L12

	 jmp	.L11

.L11:

	 mov	 -40(%rbp), %edi
	 add	 -16(%rbp), %edi
	 mov	 %edi, -48(%rbp)

	 mov	 -48(%rbp), %edi
	 mov	 %edi, -40(%rbp)

	 mov	 -32(%rbp), %edi
	 mov	 %edi, -48(%rbp)

	 incl 	 -32(%rbp)

	 jmp	.L8

	 mov	 $1234, %edi
	 mov	 %edi, -40(%rbp)

.L12:

	 mov	 -40(%rbp), %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

	 .globl	loop
	 .type	loop, @function
loop:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$88, %rsp

	 mov	 $.S7, %rdi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -16(%rbp)

	 mov	 $.S8, %rdi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -24(%rbp)

	 mov	 $4, %rdi
	 mov	 $5, %rsi
	 mov $0, %rax
	 call	mul_for
	 mov	%eax, -32(%rbp)

	 mov	 $.S9, %rdi
	 mov	 -32(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -40(%rbp)

	 mov	 $4, %rdi
	 mov	 $5, %rsi
	 mov $0, %rax
	 call	mul_while
	 mov	%eax, -48(%rbp)

	 mov	 $.S10, %rdi
	 mov	 -48(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -56(%rbp)

	 mov	 $4, %edi
	 imull	 $5, %edi
	 mov	 %edi, -64(%rbp)

	 mov	 $.S11, %rdi
	 mov	 -64(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -72(%rbp)

	 mov	 $.S12, %rdi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -80(%rbp)

	 mov	 $0, %edi
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
	 je	 .L13

	 jmp	.L14

.L13:

	 mov	 $1, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

	 jmp	.L15

.L14:

	 mov	 -16(%rbp), %edi
	 sub	 $1, %edi
	 mov	 %edi, -24(%rbp)

	 mov	 -24(%rbp), %ebx
	 mov	 %rbx, %rdi
	 mov $0, %rax
	 call	fac
	 mov	%eax, -32(%rbp)

	 mov	 -32(%rbp), %ebx
	 mov	 %rbx, %rdi
	 mov	 -16(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov $0, %rax
	 call	mul_for
	 mov	%eax, -40(%rbp)

	 mov	 -40(%rbp), %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

.L15:

	 .globl	recursive
	 .type	recursive, @function
recursive:
	 pushq	%rbp
	 movq	%rsp, %rbp
	 subq	$40, %rsp

	 mov	 $.S13, %rdi
	 mov $0, %rax
	 call	printf
	 mov	%eax, -16(%rbp)

	 mov	 $10, %rdi
	 mov $0, %rax
	 call	fac
	 mov	%eax, -24(%rbp)

	 mov	 $.S14, %rdi
	 mov	 -24(%rbp), %ebx
	 mov	 %rbx, %rsi
	 mov	 $3628800, %rdx
	 mov $0, %rax
	 call	printf
	 mov	%eax, -32(%rbp)

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
	 subq	$48, %rsp

	 mov $0, %rax
	 call	nested
	 mov	%eax, -16(%rbp)

	 mov $0, %rax
	 call	expr
	 mov	%eax, -24(%rbp)

	 mov $0, %rax
	 call	loop
	 mov	%eax, -32(%rbp)

	 mov $0, %rax
	 call	recursive
	 mov	%eax, -40(%rbp)

	 mov	 $0, %edi
	 mov	 %edi, -8(%rbp)

	 mov	 -8(%rbp), %eax
	 leave
	 ret

