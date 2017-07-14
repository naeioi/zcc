	.file	"simple.c"
	.comm	a,4,4
	.globl	str
	.section	.rodata
.LC0:
	.string	"c=%d"
	.data
	.align 8
	.type	str, @object
	.size	str, 8
str:
	.quad	.LC0
	.text
	.globl	add
	.type	add, @function
add:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	add, .-add
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	a(%rip), %eax
	cmpl	$2, %eax
	setg	%al
	movzbl	%al, %eax
	movl	%eax, a(%rip)
	movl	a(%rip), %eax
	cmpl	$10, %eax
	jle	.L4
	movl	$0, %eax
	jmp	.L5
.L4:
	movl	a(%rip), %eax
	movl	$2, %esi
	movl	%eax, %edi
	call	add
	movl	%eax, -4(%rbp)
	movq	str(%rip), %rax
	movl	-4(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
