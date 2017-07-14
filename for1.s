	.file	"for1.c"
	.text
	.globl	mul
	.type	mul, @function
mul:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	.L2
	movl	-20(%rbp), %eax
	addl	%eax, -12(%rbp)
	addl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	cmpl	$9, -4(%rbp)
	jg	.L3
	movl	-4(%rbp), %eax
	addl	%eax, -12(%rbp)
	nop
.L3:
	addl	$1, -12(%rbp)
	nop
.L2:
	movl	-12(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	mul, .-mul
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
