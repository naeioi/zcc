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
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	popq	%rbp
	ret
	.size	add, .-add
	
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$1, a(%rip)
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
	leave
	ret
	.size	main, .-main
	
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
