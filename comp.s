	.file	"comp.c"
	.text
	.globl	comp
	.type	comp, @function
comp:
.LFB0:
	.cfi_startproc
	push	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	mov	%edi, -20(%rbp)
	mov	%esi, -24(%rbp)
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	.L2
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	setl	%al
	movzx	%al, %eax
	mov	%eax, -4(%rbp)
.L2:
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jg	.L3
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	setle	%al
	movzbl	%al, %eax
	mov	%eax, -4(%rbp)
.L3:
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.L4
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	sete	%al
	movzbl	%al, %eax
	mov	%eax, -4(%rbp)
.L4:
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L5
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	setge	%al
	movzbl	%al, %eax
	mov	%eax, -4(%rbp)
.L5:
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.L6
	mov	-20(%rbp), %eax
	cmpl	-24(%rbp), %eax
	setg	%al
	movzbl	%al, %eax
	mov	%eax, -4(%rbp)
.L6:
	mov	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	comp, .-comp
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	push	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	mov	$2, %esi
	mov	$1, %edi
	call	comp
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
