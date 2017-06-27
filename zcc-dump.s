
zcc:     file format elf64-x86-64


Disassembly of section .init:

00000000004005c8 <_init>:
  4005c8:	48 83 ec 08          	sub    $0x8,%rsp
  4005cc:	48 8b 05 25 3a 20 00 	mov    0x203a25(%rip),%rax        # 603ff8 <_DYNAMIC+0x1d0>
  4005d3:	48 85 c0             	test   %rax,%rax
  4005d6:	74 05                	je     4005dd <_init+0x15>
  4005d8:	e8 d3 00 00 00       	callq  4006b0 <exit@plt+0x10>
  4005dd:	48 83 c4 08          	add    $0x8,%rsp
  4005e1:	c3                   	retq   

Disassembly of section .plt:

00000000004005f0 <putchar@plt-0x10>:
  4005f0:	ff 35 12 3a 20 00    	pushq  0x203a12(%rip)        # 604008 <_GLOBAL_OFFSET_TABLE_+0x8>
  4005f6:	ff 25 14 3a 20 00    	jmpq   *0x203a14(%rip)        # 604010 <_GLOBAL_OFFSET_TABLE_+0x10>
  4005fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400600 <putchar@plt>:
  400600:	ff 25 12 3a 20 00    	jmpq   *0x203a12(%rip)        # 604018 <_GLOBAL_OFFSET_TABLE_+0x18>
  400606:	68 00 00 00 00       	pushq  $0x0
  40060b:	e9 e0 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400610 <puts@plt>:
  400610:	ff 25 0a 3a 20 00    	jmpq   *0x203a0a(%rip)        # 604020 <_GLOBAL_OFFSET_TABLE_+0x20>
  400616:	68 01 00 00 00       	pushq  $0x1
  40061b:	e9 d0 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400620 <printf@plt>:
  400620:	ff 25 02 3a 20 00    	jmpq   *0x203a02(%rip)        # 604028 <_GLOBAL_OFFSET_TABLE_+0x28>
  400626:	68 02 00 00 00       	pushq  $0x2
  40062b:	e9 c0 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400630 <__assert_fail@plt>:
  400630:	ff 25 fa 39 20 00    	jmpq   *0x2039fa(%rip)        # 604030 <_GLOBAL_OFFSET_TABLE_+0x30>
  400636:	68 03 00 00 00       	pushq  $0x3
  40063b:	e9 b0 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400640 <fgetc@plt>:
  400640:	ff 25 f2 39 20 00    	jmpq   *0x2039f2(%rip)        # 604038 <_GLOBAL_OFFSET_TABLE_+0x38>
  400646:	68 04 00 00 00       	pushq  $0x4
  40064b:	e9 a0 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400650 <__libc_start_main@plt>:
  400650:	ff 25 ea 39 20 00    	jmpq   *0x2039ea(%rip)        # 604040 <_GLOBAL_OFFSET_TABLE_+0x40>
  400656:	68 05 00 00 00       	pushq  $0x5
  40065b:	e9 90 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400660 <strcmp@plt>:
  400660:	ff 25 e2 39 20 00    	jmpq   *0x2039e2(%rip)        # 604048 <_GLOBAL_OFFSET_TABLE_+0x48>
  400666:	68 06 00 00 00       	pushq  $0x6
  40066b:	e9 80 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400670 <feof@plt>:
  400670:	ff 25 da 39 20 00    	jmpq   *0x2039da(%rip)        # 604050 <_GLOBAL_OFFSET_TABLE_+0x50>
  400676:	68 07 00 00 00       	pushq  $0x7
  40067b:	e9 70 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400680 <ungetc@plt>:
  400680:	ff 25 d2 39 20 00    	jmpq   *0x2039d2(%rip)        # 604058 <_GLOBAL_OFFSET_TABLE_+0x58>
  400686:	68 08 00 00 00       	pushq  $0x8
  40068b:	e9 60 ff ff ff       	jmpq   4005f0 <_init+0x28>

0000000000400690 <fopen@plt>:
  400690:	ff 25 ca 39 20 00    	jmpq   *0x2039ca(%rip)        # 604060 <_GLOBAL_OFFSET_TABLE_+0x60>
  400696:	68 09 00 00 00       	pushq  $0x9
  40069b:	e9 50 ff ff ff       	jmpq   4005f0 <_init+0x28>

00000000004006a0 <exit@plt>:
  4006a0:	ff 25 c2 39 20 00    	jmpq   *0x2039c2(%rip)        # 604068 <_GLOBAL_OFFSET_TABLE_+0x68>
  4006a6:	68 0a 00 00 00       	pushq  $0xa
  4006ab:	e9 40 ff ff ff       	jmpq   4005f0 <_init+0x28>

Disassembly of section .plt.got:

00000000004006b0 <.plt.got>:
  4006b0:	ff 25 42 39 20 00    	jmpq   *0x203942(%rip)        # 603ff8 <_DYNAMIC+0x1d0>
  4006b6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000004006c0 <_start>:
  4006c0:	31 ed                	xor    %ebp,%ebp
  4006c2:	49 89 d1             	mov    %rdx,%r9
  4006c5:	5e                   	pop    %rsi
  4006c6:	48 89 e2             	mov    %rsp,%rdx
  4006c9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  4006cd:	50                   	push   %rax
  4006ce:	54                   	push   %rsp
  4006cf:	49 c7 c0 50 27 40 00 	mov    $0x402750,%r8
  4006d6:	48 c7 c1 e0 26 40 00 	mov    $0x4026e0,%rcx
  4006dd:	48 c7 c7 40 26 40 00 	mov    $0x402640,%rdi
  4006e4:	e8 67 ff ff ff       	callq  400650 <__libc_start_main@plt>
  4006e9:	f4                   	hlt    
  4006ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000004006f0 <deregister_tm_clones>:
  4006f0:	b8 87 40 60 00       	mov    $0x604087,%eax
  4006f5:	55                   	push   %rbp
  4006f6:	48 2d 80 40 60 00    	sub    $0x604080,%rax
  4006fc:	48 83 f8 0e          	cmp    $0xe,%rax
  400700:	48 89 e5             	mov    %rsp,%rbp
  400703:	76 1b                	jbe    400720 <deregister_tm_clones+0x30>
  400705:	b8 00 00 00 00       	mov    $0x0,%eax
  40070a:	48 85 c0             	test   %rax,%rax
  40070d:	74 11                	je     400720 <deregister_tm_clones+0x30>
  40070f:	5d                   	pop    %rbp
  400710:	bf 80 40 60 00       	mov    $0x604080,%edi
  400715:	ff e0                	jmpq   *%rax
  400717:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40071e:	00 00 
  400720:	5d                   	pop    %rbp
  400721:	c3                   	retq   
  400722:	0f 1f 40 00          	nopl   0x0(%rax)
  400726:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40072d:	00 00 00 

0000000000400730 <register_tm_clones>:
  400730:	be 80 40 60 00       	mov    $0x604080,%esi
  400735:	55                   	push   %rbp
  400736:	48 81 ee 80 40 60 00 	sub    $0x604080,%rsi
  40073d:	48 c1 fe 03          	sar    $0x3,%rsi
  400741:	48 89 e5             	mov    %rsp,%rbp
  400744:	48 89 f0             	mov    %rsi,%rax
  400747:	48 c1 e8 3f          	shr    $0x3f,%rax
  40074b:	48 01 c6             	add    %rax,%rsi
  40074e:	48 d1 fe             	sar    %rsi
  400751:	74 15                	je     400768 <register_tm_clones+0x38>
  400753:	b8 00 00 00 00       	mov    $0x0,%eax
  400758:	48 85 c0             	test   %rax,%rax
  40075b:	74 0b                	je     400768 <register_tm_clones+0x38>
  40075d:	5d                   	pop    %rbp
  40075e:	bf 80 40 60 00       	mov    $0x604080,%edi
  400763:	ff e0                	jmpq   *%rax
  400765:	0f 1f 00             	nopl   (%rax)
  400768:	5d                   	pop    %rbp
  400769:	c3                   	retq   
  40076a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400770 <__do_global_dtors_aux>:
  400770:	80 3d 09 39 20 00 00 	cmpb   $0x0,0x203909(%rip)        # 604080 <__TMC_END__>
  400777:	75 11                	jne    40078a <__do_global_dtors_aux+0x1a>
  400779:	55                   	push   %rbp
  40077a:	48 89 e5             	mov    %rsp,%rbp
  40077d:	e8 6e ff ff ff       	callq  4006f0 <deregister_tm_clones>
  400782:	5d                   	pop    %rbp
  400783:	c6 05 f6 38 20 00 01 	movb   $0x1,0x2038f6(%rip)        # 604080 <__TMC_END__>
  40078a:	f3 c3                	repz retq 
  40078c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400790 <frame_dummy>:
  400790:	bf 20 3e 60 00       	mov    $0x603e20,%edi
  400795:	48 83 3f 00          	cmpq   $0x0,(%rdi)
  400799:	75 05                	jne    4007a0 <frame_dummy+0x10>
  40079b:	eb 93                	jmp    400730 <register_tm_clones>
  40079d:	0f 1f 00             	nopl   (%rax)
  4007a0:	b8 00 00 00 00       	mov    $0x0,%eax
  4007a5:	48 85 c0             	test   %rax,%rax
  4007a8:	74 f1                	je     40079b <frame_dummy+0xb>
  4007aa:	55                   	push   %rbp
  4007ab:	48 89 e5             	mov    %rsp,%rbp
  4007ae:	ff d0                	callq  *%rax
  4007b0:	5d                   	pop    %rbp
  4007b1:	e9 7a ff ff ff       	jmpq   400730 <register_tm_clones>

00000000004007b6 <fexit>:
  4007b6:	55                   	push   %rbp
  4007b7:	48 89 e5             	mov    %rsp,%rbp
  4007ba:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
  4007c1:	48 89 bd 48 ff ff ff 	mov    %rdi,-0xb8(%rbp)
  4007c8:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
  4007cf:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
  4007d6:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
  4007dd:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
  4007e4:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
  4007eb:	84 c0                	test   %al,%al
  4007ed:	74 20                	je     40080f <fexit+0x59>
  4007ef:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
  4007f3:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
  4007f7:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
  4007fb:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
  4007ff:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
  400803:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
  400807:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
  40080b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  40080f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
  400816:	48 89 c7             	mov    %rax,%rdi
  400819:	e8 f2 fd ff ff       	callq  400610 <puts@plt>
  40081e:	bf 0a 00 00 00       	mov    $0xa,%edi
  400823:	e8 d8 fd ff ff       	callq  400600 <putchar@plt>
  400828:	bf 00 00 00 00       	mov    $0x0,%edi
  40082d:	e8 6e fe ff ff       	callq  4006a0 <exit@plt>

0000000000400832 <lex_load_file>:
  400832:	55                   	push   %rbp
  400833:	48 89 e5             	mov    %rsp,%rbp
  400836:	48 83 ec 10          	sub    $0x10,%rsp
  40083a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40083e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400842:	be 70 27 40 00       	mov    $0x402770,%esi
  400847:	48 89 c7             	mov    %rax,%rdi
  40084a:	e8 41 fe ff ff       	callq  400690 <fopen@plt>
  40084f:	48 89 05 72 3c 20 00 	mov    %rax,0x203c72(%rip)        # 6044c8 <lex_fp>
  400856:	48 8b 05 6b 3c 20 00 	mov    0x203c6b(%rip),%rax        # 6044c8 <lex_fp>
  40085d:	48 85 c0             	test   %rax,%rax
  400860:	75 16                	jne    400878 <lex_load_file+0x46>
  400862:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400866:	48 89 c6             	mov    %rax,%rsi
  400869:	bf 72 27 40 00       	mov    $0x402772,%edi
  40086e:	b8 00 00 00 00       	mov    $0x0,%eax
  400873:	e8 3e ff ff ff       	callq  4007b6 <fexit>
  400878:	b8 00 00 00 00       	mov    $0x0,%eax
  40087d:	c9                   	leaveq 
  40087e:	c3                   	retq   

000000000040087f <lex_isspace>:
  40087f:	55                   	push   %rbp
  400880:	48 89 e5             	mov    %rsp,%rbp
  400883:	89 f8                	mov    %edi,%eax
  400885:	88 45 fc             	mov    %al,-0x4(%rbp)
  400888:	80 7d fc 20          	cmpb   $0x20,-0x4(%rbp)
  40088c:	74 12                	je     4008a0 <lex_isspace+0x21>
  40088e:	80 7d fc 0d          	cmpb   $0xd,-0x4(%rbp)
  400892:	74 0c                	je     4008a0 <lex_isspace+0x21>
  400894:	80 7d fc 0a          	cmpb   $0xa,-0x4(%rbp)
  400898:	74 06                	je     4008a0 <lex_isspace+0x21>
  40089a:	80 7d fc 09          	cmpb   $0x9,-0x4(%rbp)
  40089e:	75 07                	jne    4008a7 <lex_isspace+0x28>
  4008a0:	b8 01 00 00 00       	mov    $0x1,%eax
  4008a5:	eb 05                	jmp    4008ac <lex_isspace+0x2d>
  4008a7:	b8 00 00 00 00       	mov    $0x0,%eax
  4008ac:	5d                   	pop    %rbp
  4008ad:	c3                   	retq   

00000000004008ae <lex_isbinaryop>:
  4008ae:	55                   	push   %rbp
  4008af:	48 89 e5             	mov    %rsp,%rbp
  4008b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4008b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4008ba:	8b 00                	mov    (%rax),%eax
  4008bc:	83 f8 0d             	cmp    $0xd,%eax
  4008bf:	76 12                	jbe    4008d3 <lex_isbinaryop+0x25>
  4008c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4008c5:	8b 00                	mov    (%rax),%eax
  4008c7:	83 f8 1d             	cmp    $0x1d,%eax
  4008ca:	77 07                	ja     4008d3 <lex_isbinaryop+0x25>
  4008cc:	b8 01 00 00 00       	mov    $0x1,%eax
  4008d1:	eb 05                	jmp    4008d8 <lex_isbinaryop+0x2a>
  4008d3:	b8 00 00 00 00       	mov    $0x0,%eax
  4008d8:	5d                   	pop    %rbp
  4008d9:	c3                   	retq   

00000000004008da <lex_isunaryop>:
  4008da:	55                   	push   %rbp
  4008db:	48 89 e5             	mov    %rsp,%rbp
  4008de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4008e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4008e6:	8b 00                	mov    (%rax),%eax
  4008e8:	83 f8 0c             	cmp    $0xc,%eax
  4008eb:	74 42                	je     40092f <lex_isunaryop+0x55>
  4008ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4008f1:	8b 00                	mov    (%rax),%eax
  4008f3:	83 f8 0d             	cmp    $0xd,%eax
  4008f6:	74 37                	je     40092f <lex_isunaryop+0x55>
  4008f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4008fc:	8b 00                	mov    (%rax),%eax
  4008fe:	83 f8 18             	cmp    $0x18,%eax
  400901:	74 2c                	je     40092f <lex_isunaryop+0x55>
  400903:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400907:	8b 00                	mov    (%rax),%eax
  400909:	83 f8 16             	cmp    $0x16,%eax
  40090c:	74 21                	je     40092f <lex_isunaryop+0x55>
  40090e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400912:	8b 00                	mov    (%rax),%eax
  400914:	83 f8 14             	cmp    $0x14,%eax
  400917:	74 16                	je     40092f <lex_isunaryop+0x55>
  400919:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  40091d:	8b 00                	mov    (%rax),%eax
  40091f:	83 f8 15             	cmp    $0x15,%eax
  400922:	74 0b                	je     40092f <lex_isunaryop+0x55>
  400924:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  400928:	8b 00                	mov    (%rax),%eax
  40092a:	83 f8 1e             	cmp    $0x1e,%eax
  40092d:	75 07                	jne    400936 <lex_isunaryop+0x5c>
  40092f:	b8 01 00 00 00       	mov    $0x1,%eax
  400934:	eb 05                	jmp    40093b <lex_isunaryop+0x61>
  400936:	b8 00 00 00 00       	mov    $0x0,%eax
  40093b:	5d                   	pop    %rbp
  40093c:	c3                   	retq   

000000000040093d <lex_peek>:
  40093d:	55                   	push   %rbp
  40093e:	48 89 e5             	mov    %rsp,%rbp
  400941:	8b 05 79 3b 20 00    	mov    0x203b79(%rip),%eax        # 6044c0 <lex_nextc>
  400947:	83 f8 ff             	cmp    $0xffffffff,%eax
  40094a:	75 34                	jne    400980 <lex_peek+0x43>
  40094c:	48 8b 05 75 3b 20 00 	mov    0x203b75(%rip),%rax        # 6044c8 <lex_fp>
  400953:	48 89 c7             	mov    %rax,%rdi
  400956:	e8 15 fd ff ff       	callq  400670 <feof@plt>
  40095b:	85 c0                	test   %eax,%eax
  40095d:	74 0c                	je     40096b <lex_peek+0x2e>
  40095f:	c7 05 57 3b 20 00 ff 	movl   $0xffffffff,0x203b57(%rip)        # 6044c0 <lex_nextc>
  400966:	ff ff ff 
  400969:	eb 15                	jmp    400980 <lex_peek+0x43>
  40096b:	48 8b 05 56 3b 20 00 	mov    0x203b56(%rip),%rax        # 6044c8 <lex_fp>
  400972:	48 89 c7             	mov    %rax,%rdi
  400975:	e8 c6 fc ff ff       	callq  400640 <fgetc@plt>
  40097a:	89 05 40 3b 20 00    	mov    %eax,0x203b40(%rip)        # 6044c0 <lex_nextc>
  400980:	8b 05 3a 3b 20 00    	mov    0x203b3a(%rip),%eax        # 6044c0 <lex_nextc>
  400986:	5d                   	pop    %rbp
  400987:	c3                   	retq   

0000000000400988 <lex_getc>:
  400988:	55                   	push   %rbp
  400989:	48 89 e5             	mov    %rsp,%rbp
  40098c:	48 83 ec 10          	sub    $0x10,%rsp
  400990:	b8 00 00 00 00       	mov    $0x0,%eax
  400995:	e8 a3 ff ff ff       	callq  40093d <lex_peek>
  40099a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  40099d:	c7 05 19 3b 20 00 ff 	movl   $0xffffffff,0x203b19(%rip)        # 6044c0 <lex_nextc>
  4009a4:	ff ff ff 
  4009a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4009aa:	c9                   	leaveq 
  4009ab:	c3                   	retq   

00000000004009ac <lex_unget>:
  4009ac:	55                   	push   %rbp
  4009ad:	48 89 e5             	mov    %rsp,%rbp
  4009b0:	48 83 ec 10          	sub    $0x10,%rsp
  4009b4:	89 7d fc             	mov    %edi,-0x4(%rbp)
  4009b7:	8b 05 03 3b 20 00    	mov    0x203b03(%rip),%eax        # 6044c0 <lex_nextc>
  4009bd:	83 f8 ff             	cmp    $0xffffffff,%eax
  4009c0:	74 17                	je     4009d9 <lex_unget+0x2d>
  4009c2:	48 8b 15 ff 3a 20 00 	mov    0x203aff(%rip),%rdx        # 6044c8 <lex_fp>
  4009c9:	8b 05 f1 3a 20 00    	mov    0x203af1(%rip),%eax        # 6044c0 <lex_nextc>
  4009cf:	48 89 d6             	mov    %rdx,%rsi
  4009d2:	89 c7                	mov    %eax,%edi
  4009d4:	e8 a7 fc ff ff       	callq  400680 <ungetc@plt>
  4009d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4009dc:	89 05 de 3a 20 00    	mov    %eax,0x203ade(%rip)        # 6044c0 <lex_nextc>
  4009e2:	b8 00 00 00 00       	mov    $0x0,%eax
  4009e7:	c9                   	leaveq 
  4009e8:	c3                   	retq   

00000000004009e9 <lex_next>:
  4009e9:	55                   	push   %rbp
  4009ea:	48 89 e5             	mov    %rsp,%rbp
  4009ed:	53                   	push   %rbx
  4009ee:	48 83 ec 28          	sub    $0x28,%rsp
  4009f2:	48 c7 45 e8 a0 40 60 	movq   $0x6040a0,-0x18(%rbp)
  4009f9:	00 
  4009fa:	48 c7 05 e3 42 20 00 	movq   $0x0,0x2042e3(%rip)        # 604ce8 <lex_token+0x8>
  400a01:	00 00 00 00 
  400a05:	48 c7 05 e0 42 20 00 	movq   $0x0,0x2042e0(%rip)        # 604cf0 <lex_token+0x10>
  400a0c:	00 00 00 00 
  400a10:	c7 05 c6 42 20 00 00 	movl   $0x0,0x2042c6(%rip)        # 604ce0 <lex_token>
  400a17:	00 00 00 
  400a1a:	eb 0a                	jmp    400a26 <lex_next+0x3d>
  400a1c:	b8 00 00 00 00       	mov    $0x0,%eax
  400a21:	e8 62 ff ff ff       	callq  400988 <lex_getc>
  400a26:	b8 00 00 00 00       	mov    $0x0,%eax
  400a2b:	e8 0d ff ff ff       	callq  40093d <lex_peek>
  400a30:	88 45 df             	mov    %al,-0x21(%rbp)
  400a33:	80 7d df ff          	cmpb   $0xff,-0x21(%rbp)
  400a37:	74 0f                	je     400a48 <lex_next+0x5f>
  400a39:	0f be 45 df          	movsbl -0x21(%rbp),%eax
  400a3d:	89 c7                	mov    %eax,%edi
  400a3f:	e8 3b fe ff ff       	callq  40087f <lex_isspace>
  400a44:	85 c0                	test   %eax,%eax
  400a46:	75 d4                	jne    400a1c <lex_next+0x33>
  400a48:	80 7d df ff          	cmpb   $0xff,-0x21(%rbp)
  400a4c:	75 0a                	jne    400a58 <lex_next+0x6f>
  400a4e:	b8 02 00 00 00       	mov    $0x2,%eax
  400a53:	e9 d2 07 00 00       	jmpq   40122a <lex_next+0x841>
  400a58:	48 c7 05 85 42 20 00 	movq   $0x6040a0,0x204285(%rip)        # 604ce8 <lex_token+0x8>
  400a5f:	a0 40 60 00 
  400a63:	80 7d df 2f          	cmpb   $0x2f,-0x21(%rbp)
  400a67:	0f 85 b1 00 00 00    	jne    400b1e <lex_next+0x135>
  400a6d:	b8 00 00 00 00       	mov    $0x0,%eax
  400a72:	e8 11 ff ff ff       	callq  400988 <lex_getc>
  400a77:	b8 00 00 00 00       	mov    $0x0,%eax
  400a7c:	e8 bc fe ff ff       	callq  40093d <lex_peek>
  400a81:	88 45 df             	mov    %al,-0x21(%rbp)
  400a84:	80 7d df 00          	cmpb   $0x0,-0x21(%rbp)
  400a88:	0f 88 90 00 00 00    	js     400b1e <lex_next+0x135>
  400a8e:	80 7d df 2f          	cmpb   $0x2f,-0x21(%rbp)
  400a92:	75 21                	jne    400ab5 <lex_next+0xcc>
  400a94:	eb 0a                	jmp    400aa0 <lex_next+0xb7>
  400a96:	b8 00 00 00 00       	mov    $0x0,%eax
  400a9b:	e8 e8 fe ff ff       	callq  400988 <lex_getc>
  400aa0:	b8 00 00 00 00       	mov    $0x0,%eax
  400aa5:	e8 de fe ff ff       	callq  400988 <lex_getc>
  400aaa:	88 45 df             	mov    %al,-0x21(%rbp)
  400aad:	80 7d df 0a          	cmpb   $0xa,-0x21(%rbp)
  400ab1:	75 e3                	jne    400a96 <lex_next+0xad>
  400ab3:	eb 69                	jmp    400b1e <lex_next+0x135>
  400ab5:	80 7d df 2a          	cmpb   $0x2a,-0x21(%rbp)
  400ab9:	75 55                	jne    400b10 <lex_next+0x127>
  400abb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  400ac2:	eb 37                	jmp    400afb <lex_next+0x112>
  400ac4:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
  400ac8:	75 0f                	jne    400ad9 <lex_next+0xf0>
  400aca:	80 7d df 2a          	cmpb   $0x2a,-0x21(%rbp)
  400ace:	75 09                	jne    400ad9 <lex_next+0xf0>
  400ad0:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%rbp)
  400ad7:	eb 22                	jmp    400afb <lex_next+0x112>
  400ad9:	83 7d e0 01          	cmpl   $0x1,-0x20(%rbp)
  400add:	75 1c                	jne    400afb <lex_next+0x112>
  400adf:	80 7d df 2a          	cmpb   $0x2a,-0x21(%rbp)
  400ae3:	75 09                	jne    400aee <lex_next+0x105>
  400ae5:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%rbp)
  400aec:	eb 0d                	jmp    400afb <lex_next+0x112>
  400aee:	80 7d df 2f          	cmpb   $0x2f,-0x21(%rbp)
  400af2:	74 29                	je     400b1d <lex_next+0x134>
  400af4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
  400afb:	b8 00 00 00 00       	mov    $0x0,%eax
  400b00:	e8 83 fe ff ff       	callq  400988 <lex_getc>
  400b05:	88 45 df             	mov    %al,-0x21(%rbp)
  400b08:	80 7d df 00          	cmpb   $0x0,-0x21(%rbp)
  400b0c:	79 b6                	jns    400ac4 <lex_next+0xdb>
  400b0e:	eb 0e                	jmp    400b1e <lex_next+0x135>
  400b10:	0f be 45 df          	movsbl -0x21(%rbp),%eax
  400b14:	89 c7                	mov    %eax,%edi
  400b16:	e8 91 fe ff ff       	callq  4009ac <lex_unget>
  400b1b:	eb 01                	jmp    400b1e <lex_next+0x135>
  400b1d:	90                   	nop
  400b1e:	b8 00 00 00 00       	mov    $0x0,%eax
  400b23:	e8 15 fe ff ff       	callq  40093d <lex_peek>
  400b28:	83 f8 ff             	cmp    $0xffffffff,%eax
  400b2b:	75 0a                	jne    400b37 <lex_next+0x14e>
  400b2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  400b32:	e9 f3 06 00 00       	jmpq   40122a <lex_next+0x841>
  400b37:	b8 00 00 00 00       	mov    $0x0,%eax
  400b3c:	e8 47 fe ff ff       	callq  400988 <lex_getc>
  400b41:	88 05 59 35 20 00    	mov    %al,0x203559(%rip)        # 6040a0 <buf.3076>
  400b47:	b8 00 00 00 00       	mov    $0x0,%eax
  400b4c:	e8 ec fd ff ff       	callq  40093d <lex_peek>
  400b51:	88 45 df             	mov    %al,-0x21(%rbp)
  400b54:	80 7d df ff          	cmpb   $0xff,-0x21(%rbp)
  400b58:	0f 84 65 02 00 00    	je     400dc3 <lex_next+0x3da>
  400b5e:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
  400b62:	88 05 39 35 20 00    	mov    %al,0x203539(%rip)        # 6040a1 <buf.3076+0x1>
  400b68:	c6 05 33 35 20 00 00 	movb   $0x0,0x203533(%rip)        # 6040a2 <buf.3076+0x2>
  400b6f:	be 89 27 40 00       	mov    $0x402789,%esi
  400b74:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400b79:	e8 e2 fa ff ff       	callq  400660 <strcmp@plt>
  400b7e:	85 c0                	test   %eax,%eax
  400b80:	75 2d                	jne    400baf <lex_next+0x1c6>
  400b82:	8b 05 58 41 20 00    	mov    0x204158(%rip),%eax        # 604ce0 <lex_token>
  400b88:	85 c0                	test   %eax,%eax
  400b8a:	74 19                	je     400ba5 <lex_next+0x1bc>
  400b8c:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400b91:	ba 08 00 00 00       	mov    $0x8,%edx
  400b96:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400b9b:	bf 98 27 40 00       	mov    $0x402798,%edi
  400ba0:	e8 8b fa ff ff       	callq  400630 <__assert_fail@plt>
  400ba5:	c7 05 31 41 20 00 0b 	movl   $0xb,0x204131(%rip)        # 604ce0 <lex_token>
  400bac:	00 00 00 
  400baf:	be b0 27 40 00       	mov    $0x4027b0,%esi
  400bb4:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400bb9:	e8 a2 fa ff ff       	callq  400660 <strcmp@plt>
  400bbe:	85 c0                	test   %eax,%eax
  400bc0:	75 2d                	jne    400bef <lex_next+0x206>
  400bc2:	8b 05 18 41 20 00    	mov    0x204118(%rip),%eax        # 604ce0 <lex_token>
  400bc8:	85 c0                	test   %eax,%eax
  400bca:	74 19                	je     400be5 <lex_next+0x1fc>
  400bcc:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400bd1:	ba 09 00 00 00       	mov    $0x9,%edx
  400bd6:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400bdb:	bf 98 27 40 00       	mov    $0x402798,%edi
  400be0:	e8 4b fa ff ff       	callq  400630 <__assert_fail@plt>
  400be5:	c7 05 f1 40 20 00 0c 	movl   $0xc,0x2040f1(%rip)        # 604ce0 <lex_token>
  400bec:	00 00 00 
  400bef:	be b3 27 40 00       	mov    $0x4027b3,%esi
  400bf4:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400bf9:	e8 62 fa ff ff       	callq  400660 <strcmp@plt>
  400bfe:	85 c0                	test   %eax,%eax
  400c00:	75 2d                	jne    400c2f <lex_next+0x246>
  400c02:	8b 05 d8 40 20 00    	mov    0x2040d8(%rip),%eax        # 604ce0 <lex_token>
  400c08:	85 c0                	test   %eax,%eax
  400c0a:	74 19                	je     400c25 <lex_next+0x23c>
  400c0c:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400c11:	ba 0a 00 00 00       	mov    $0xa,%edx
  400c16:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400c1b:	bf 98 27 40 00       	mov    $0x402798,%edi
  400c20:	e8 0b fa ff ff       	callq  400630 <__assert_fail@plt>
  400c25:	c7 05 b1 40 20 00 0d 	movl   $0xd,0x2040b1(%rip)        # 604ce0 <lex_token>
  400c2c:	00 00 00 
  400c2f:	be b6 27 40 00       	mov    $0x4027b6,%esi
  400c34:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400c39:	e8 22 fa ff ff       	callq  400660 <strcmp@plt>
  400c3e:	85 c0                	test   %eax,%eax
  400c40:	75 2d                	jne    400c6f <lex_next+0x286>
  400c42:	8b 05 98 40 20 00    	mov    0x204098(%rip),%eax        # 604ce0 <lex_token>
  400c48:	85 c0                	test   %eax,%eax
  400c4a:	74 19                	je     400c65 <lex_next+0x27c>
  400c4c:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400c51:	ba 0b 00 00 00       	mov    $0xb,%edx
  400c56:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400c5b:	bf 98 27 40 00       	mov    $0x402798,%edi
  400c60:	e8 cb f9 ff ff       	callq  400630 <__assert_fail@plt>
  400c65:	c7 05 71 40 20 00 0e 	movl   $0xe,0x204071(%rip)        # 604ce0 <lex_token>
  400c6c:	00 00 00 
  400c6f:	be b9 27 40 00       	mov    $0x4027b9,%esi
  400c74:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400c79:	e8 e2 f9 ff ff       	callq  400660 <strcmp@plt>
  400c7e:	85 c0                	test   %eax,%eax
  400c80:	75 2d                	jne    400caf <lex_next+0x2c6>
  400c82:	8b 05 58 40 20 00    	mov    0x204058(%rip),%eax        # 604ce0 <lex_token>
  400c88:	85 c0                	test   %eax,%eax
  400c8a:	74 19                	je     400ca5 <lex_next+0x2bc>
  400c8c:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400c91:	ba 0c 00 00 00       	mov    $0xc,%edx
  400c96:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400c9b:	bf 98 27 40 00       	mov    $0x402798,%edi
  400ca0:	e8 8b f9 ff ff       	callq  400630 <__assert_fail@plt>
  400ca5:	c7 05 31 40 20 00 0f 	movl   $0xf,0x204031(%rip)        # 604ce0 <lex_token>
  400cac:	00 00 00 
  400caf:	be bc 27 40 00       	mov    $0x4027bc,%esi
  400cb4:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400cb9:	e8 a2 f9 ff ff       	callq  400660 <strcmp@plt>
  400cbe:	85 c0                	test   %eax,%eax
  400cc0:	75 2d                	jne    400cef <lex_next+0x306>
  400cc2:	8b 05 18 40 20 00    	mov    0x204018(%rip),%eax        # 604ce0 <lex_token>
  400cc8:	85 c0                	test   %eax,%eax
  400cca:	74 19                	je     400ce5 <lex_next+0x2fc>
  400ccc:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400cd1:	ba 0d 00 00 00       	mov    $0xd,%edx
  400cd6:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400cdb:	bf 98 27 40 00       	mov    $0x402798,%edi
  400ce0:	e8 4b f9 ff ff       	callq  400630 <__assert_fail@plt>
  400ce5:	c7 05 f1 3f 20 00 10 	movl   $0x10,0x203ff1(%rip)        # 604ce0 <lex_token>
  400cec:	00 00 00 
  400cef:	be bf 27 40 00       	mov    $0x4027bf,%esi
  400cf4:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400cf9:	e8 62 f9 ff ff       	callq  400660 <strcmp@plt>
  400cfe:	85 c0                	test   %eax,%eax
  400d00:	75 2d                	jne    400d2f <lex_next+0x346>
  400d02:	8b 05 d8 3f 20 00    	mov    0x203fd8(%rip),%eax        # 604ce0 <lex_token>
  400d08:	85 c0                	test   %eax,%eax
  400d0a:	74 19                	je     400d25 <lex_next+0x33c>
  400d0c:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400d11:	ba 0e 00 00 00       	mov    $0xe,%edx
  400d16:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400d1b:	bf 98 27 40 00       	mov    $0x402798,%edi
  400d20:	e8 0b f9 ff ff       	callq  400630 <__assert_fail@plt>
  400d25:	c7 05 b1 3f 20 00 11 	movl   $0x11,0x203fb1(%rip)        # 604ce0 <lex_token>
  400d2c:	00 00 00 
  400d2f:	be c2 27 40 00       	mov    $0x4027c2,%esi
  400d34:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400d39:	e8 22 f9 ff ff       	callq  400660 <strcmp@plt>
  400d3e:	85 c0                	test   %eax,%eax
  400d40:	75 2d                	jne    400d6f <lex_next+0x386>
  400d42:	8b 05 98 3f 20 00    	mov    0x203f98(%rip),%eax        # 604ce0 <lex_token>
  400d48:	85 c0                	test   %eax,%eax
  400d4a:	74 19                	je     400d65 <lex_next+0x37c>
  400d4c:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400d51:	ba 0f 00 00 00       	mov    $0xf,%edx
  400d56:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400d5b:	bf 98 27 40 00       	mov    $0x402798,%edi
  400d60:	e8 cb f8 ff ff       	callq  400630 <__assert_fail@plt>
  400d65:	c7 05 71 3f 20 00 12 	movl   $0x12,0x203f71(%rip)        # 604ce0 <lex_token>
  400d6c:	00 00 00 
  400d6f:	be c5 27 40 00       	mov    $0x4027c5,%esi
  400d74:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  400d79:	e8 e2 f8 ff ff       	callq  400660 <strcmp@plt>
  400d7e:	85 c0                	test   %eax,%eax
  400d80:	75 2d                	jne    400daf <lex_next+0x3c6>
  400d82:	8b 05 58 3f 20 00    	mov    0x203f58(%rip),%eax        # 604ce0 <lex_token>
  400d88:	85 c0                	test   %eax,%eax
  400d8a:	74 19                	je     400da5 <lex_next+0x3bc>
  400d8c:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  400d91:	ba 10 00 00 00       	mov    $0x10,%edx
  400d96:	be 8c 27 40 00       	mov    $0x40278c,%esi
  400d9b:	bf 98 27 40 00       	mov    $0x402798,%edi
  400da0:	e8 8b f8 ff ff       	callq  400630 <__assert_fail@plt>
  400da5:	c7 05 31 3f 20 00 13 	movl   $0x13,0x203f31(%rip)        # 604ce0 <lex_token>
  400dac:	00 00 00 
  400daf:	8b 05 2b 3f 20 00    	mov    0x203f2b(%rip),%eax        # 604ce0 <lex_token>
  400db5:	85 c0                	test   %eax,%eax
  400db7:	74 0a                	je     400dc3 <lex_next+0x3da>
  400db9:	b8 00 00 00 00       	mov    $0x0,%eax
  400dbe:	e9 67 04 00 00       	jmpq   40122a <lex_next+0x841>
  400dc3:	0f b6 05 d6 32 20 00 	movzbl 0x2032d6(%rip),%eax        # 6040a0 <buf.3076>
  400dca:	0f be c0             	movsbl %al,%eax
  400dcd:	89 c7                	mov    %eax,%edi
  400dcf:	e8 d8 fb ff ff       	callq  4009ac <lex_unget>
  400dd4:	b8 00 00 00 00       	mov    $0x0,%eax
  400dd9:	e8 5f fb ff ff       	callq  40093d <lex_peek>
  400dde:	88 45 df             	mov    %al,-0x21(%rbp)
  400de1:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
  400de5:	88 05 b5 32 20 00    	mov    %al,0x2032b5(%rip)        # 6040a0 <buf.3076>
  400deb:	c6 05 af 32 20 00 00 	movb   $0x0,0x2032af(%rip)        # 6040a1 <buf.3076+0x1>
  400df2:	80 7d df 2b          	cmpb   $0x2b,-0x21(%rbp)
  400df6:	75 0a                	jne    400e02 <lex_next+0x419>
  400df8:	c7 05 de 3e 20 00 14 	movl   $0x14,0x203ede(%rip)        # 604ce0 <lex_token>
  400dff:	00 00 00 
  400e02:	80 7d df 2d          	cmpb   $0x2d,-0x21(%rbp)
  400e06:	75 0a                	jne    400e12 <lex_next+0x429>
  400e08:	c7 05 ce 3e 20 00 15 	movl   $0x15,0x203ece(%rip)        # 604ce0 <lex_token>
  400e0f:	00 00 00 
  400e12:	80 7d df 2a          	cmpb   $0x2a,-0x21(%rbp)
  400e16:	75 0a                	jne    400e22 <lex_next+0x439>
  400e18:	c7 05 be 3e 20 00 16 	movl   $0x16,0x203ebe(%rip)        # 604ce0 <lex_token>
  400e1f:	00 00 00 
  400e22:	80 7d df 2f          	cmpb   $0x2f,-0x21(%rbp)
  400e26:	75 0a                	jne    400e32 <lex_next+0x449>
  400e28:	c7 05 ae 3e 20 00 17 	movl   $0x17,0x203eae(%rip)        # 604ce0 <lex_token>
  400e2f:	00 00 00 
  400e32:	80 7d df 26          	cmpb   $0x26,-0x21(%rbp)
  400e36:	75 0a                	jne    400e42 <lex_next+0x459>
  400e38:	c7 05 9e 3e 20 00 18 	movl   $0x18,0x203e9e(%rip)        # 604ce0 <lex_token>
  400e3f:	00 00 00 
  400e42:	80 7d df 5e          	cmpb   $0x5e,-0x21(%rbp)
  400e46:	75 0a                	jne    400e52 <lex_next+0x469>
  400e48:	c7 05 8e 3e 20 00 19 	movl   $0x19,0x203e8e(%rip)        # 604ce0 <lex_token>
  400e4f:	00 00 00 
  400e52:	80 7d df 7c          	cmpb   $0x7c,-0x21(%rbp)
  400e56:	75 0a                	jne    400e62 <lex_next+0x479>
  400e58:	c7 05 7e 3e 20 00 1a 	movl   $0x1a,0x203e7e(%rip)        # 604ce0 <lex_token>
  400e5f:	00 00 00 
  400e62:	80 7d df 25          	cmpb   $0x25,-0x21(%rbp)
  400e66:	75 0a                	jne    400e72 <lex_next+0x489>
  400e68:	c7 05 6e 3e 20 00 1b 	movl   $0x1b,0x203e6e(%rip)        # 604ce0 <lex_token>
  400e6f:	00 00 00 
  400e72:	80 7d df 3c          	cmpb   $0x3c,-0x21(%rbp)
  400e76:	75 0a                	jne    400e82 <lex_next+0x499>
  400e78:	c7 05 5e 3e 20 00 1c 	movl   $0x1c,0x203e5e(%rip)        # 604ce0 <lex_token>
  400e7f:	00 00 00 
  400e82:	80 7d df 3e          	cmpb   $0x3e,-0x21(%rbp)
  400e86:	75 0a                	jne    400e92 <lex_next+0x4a9>
  400e88:	c7 05 4e 3e 20 00 1d 	movl   $0x1d,0x203e4e(%rip)        # 604ce0 <lex_token>
  400e8f:	00 00 00 
  400e92:	80 7d df 21          	cmpb   $0x21,-0x21(%rbp)
  400e96:	75 0a                	jne    400ea2 <lex_next+0x4b9>
  400e98:	c7 05 3e 3e 20 00 1e 	movl   $0x1e,0x203e3e(%rip)        # 604ce0 <lex_token>
  400e9f:	00 00 00 
  400ea2:	80 7d df 7e          	cmpb   $0x7e,-0x21(%rbp)
  400ea6:	75 0a                	jne    400eb2 <lex_next+0x4c9>
  400ea8:	c7 05 2e 3e 20 00 1f 	movl   $0x1f,0x203e2e(%rip)        # 604ce0 <lex_token>
  400eaf:	00 00 00 
  400eb2:	80 7d df 2e          	cmpb   $0x2e,-0x21(%rbp)
  400eb6:	75 0a                	jne    400ec2 <lex_next+0x4d9>
  400eb8:	c7 05 1e 3e 20 00 20 	movl   $0x20,0x203e1e(%rip)        # 604ce0 <lex_token>
  400ebf:	00 00 00 
  400ec2:	80 7d df 3d          	cmpb   $0x3d,-0x21(%rbp)
  400ec6:	75 0a                	jne    400ed2 <lex_next+0x4e9>
  400ec8:	c7 05 0e 3e 20 00 21 	movl   $0x21,0x203e0e(%rip)        # 604ce0 <lex_token>
  400ecf:	00 00 00 
  400ed2:	80 7d df 5b          	cmpb   $0x5b,-0x21(%rbp)
  400ed6:	75 0a                	jne    400ee2 <lex_next+0x4f9>
  400ed8:	c7 05 fe 3d 20 00 22 	movl   $0x22,0x203dfe(%rip)        # 604ce0 <lex_token>
  400edf:	00 00 00 
  400ee2:	80 7d df 5d          	cmpb   $0x5d,-0x21(%rbp)
  400ee6:	75 0a                	jne    400ef2 <lex_next+0x509>
  400ee8:	c7 05 ee 3d 20 00 22 	movl   $0x22,0x203dee(%rip)        # 604ce0 <lex_token>
  400eef:	00 00 00 
  400ef2:	80 7d df 28          	cmpb   $0x28,-0x21(%rbp)
  400ef6:	75 0a                	jne    400f02 <lex_next+0x519>
  400ef8:	c7 05 de 3d 20 00 22 	movl   $0x22,0x203dde(%rip)        # 604ce0 <lex_token>
  400eff:	00 00 00 
  400f02:	80 7d df 29          	cmpb   $0x29,-0x21(%rbp)
  400f06:	75 0a                	jne    400f12 <lex_next+0x529>
  400f08:	c7 05 ce 3d 20 00 22 	movl   $0x22,0x203dce(%rip)        # 604ce0 <lex_token>
  400f0f:	00 00 00 
  400f12:	80 7d df 7b          	cmpb   $0x7b,-0x21(%rbp)
  400f16:	75 0a                	jne    400f22 <lex_next+0x539>
  400f18:	c7 05 be 3d 20 00 22 	movl   $0x22,0x203dbe(%rip)        # 604ce0 <lex_token>
  400f1f:	00 00 00 
  400f22:	80 7d df 7d          	cmpb   $0x7d,-0x21(%rbp)
  400f26:	75 0a                	jne    400f32 <lex_next+0x549>
  400f28:	c7 05 ae 3d 20 00 22 	movl   $0x22,0x203dae(%rip)        # 604ce0 <lex_token>
  400f2f:	00 00 00 
  400f32:	80 7d df 3b          	cmpb   $0x3b,-0x21(%rbp)
  400f36:	75 0a                	jne    400f42 <lex_next+0x559>
  400f38:	c7 05 9e 3d 20 00 22 	movl   $0x22,0x203d9e(%rip)        # 604ce0 <lex_token>
  400f3f:	00 00 00 
  400f42:	80 7d df 2c          	cmpb   $0x2c,-0x21(%rbp)
  400f46:	75 0a                	jne    400f52 <lex_next+0x569>
  400f48:	c7 05 8e 3d 20 00 22 	movl   $0x22,0x203d8e(%rip)        # 604ce0 <lex_token>
  400f4f:	00 00 00 
  400f52:	8b 05 88 3d 20 00    	mov    0x203d88(%rip),%eax        # 604ce0 <lex_token>
  400f58:	85 c0                	test   %eax,%eax
  400f5a:	74 14                	je     400f70 <lex_next+0x587>
  400f5c:	b8 00 00 00 00       	mov    $0x0,%eax
  400f61:	e8 22 fa ff ff       	callq  400988 <lex_getc>
  400f66:	b8 00 00 00 00       	mov    $0x0,%eax
  400f6b:	e9 ba 02 00 00       	jmpq   40122a <lex_next+0x841>
  400f70:	b8 00 00 00 00       	mov    $0x0,%eax
  400f75:	e8 c3 f9 ff ff       	callq  40093d <lex_peek>
  400f7a:	88 45 df             	mov    %al,-0x21(%rbp)
  400f7d:	80 7d df 2f          	cmpb   $0x2f,-0x21(%rbp)
  400f81:	0f 8e 99 00 00 00    	jle    401020 <lex_next+0x637>
  400f87:	80 7d df 39          	cmpb   $0x39,-0x21(%rbp)
  400f8b:	0f 8f 8f 00 00 00    	jg     401020 <lex_next+0x637>
  400f91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  400f98:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  400f9b:	89 d0                	mov    %edx,%eax
  400f9d:	c1 e0 02             	shl    $0x2,%eax
  400fa0:	01 d0                	add    %edx,%eax
  400fa2:	01 c0                	add    %eax,%eax
  400fa4:	89 c2                	mov    %eax,%edx
  400fa6:	0f be 45 df          	movsbl -0x21(%rbp),%eax
  400faa:	01 d0                	add    %edx,%eax
  400fac:	83 e8 30             	sub    $0x30,%eax
  400faf:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  400fb2:	48 8b 5d e8          	mov    -0x18(%rbp),%rbx
  400fb6:	48 8d 43 01          	lea    0x1(%rbx),%rax
  400fba:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  400fbe:	b8 00 00 00 00       	mov    $0x0,%eax
  400fc3:	e8 c0 f9 ff ff       	callq  400988 <lex_getc>
  400fc8:	88 03                	mov    %al,(%rbx)
  400fca:	b8 00 00 00 00       	mov    $0x0,%eax
  400fcf:	e8 69 f9 ff ff       	callq  40093d <lex_peek>
  400fd4:	88 45 df             	mov    %al,-0x21(%rbp)
  400fd7:	80 7d df 00          	cmpb   $0x0,-0x21(%rbp)
  400fdb:	7e 0c                	jle    400fe9 <lex_next+0x600>
  400fdd:	80 7d df 2f          	cmpb   $0x2f,-0x21(%rbp)
  400fe1:	7e 06                	jle    400fe9 <lex_next+0x600>
  400fe3:	80 7d df 39          	cmpb   $0x39,-0x21(%rbp)
  400fe7:	7e af                	jle    400f98 <lex_next+0x5af>
  400fe9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  400fed:	48 8d 50 01          	lea    0x1(%rax),%rdx
  400ff1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  400ff5:	c6 00 00             	movb   $0x0,(%rax)
  400ff8:	c7 05 de 3c 20 00 06 	movl   $0x6,0x203cde(%rip)        # 604ce0 <lex_token>
  400fff:	00 00 00 
  401002:	48 c7 05 e3 3c 20 00 	movq   $0x6044a0,0x203ce3(%rip)        # 604cf0 <lex_token+0x10>
  401009:	a0 44 60 00 
  40100d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  401010:	89 05 8a 34 20 00    	mov    %eax,0x20348a(%rip)        # 6044a0 <value.3077>
  401016:	b8 00 00 00 00       	mov    $0x0,%eax
  40101b:	e9 0a 02 00 00       	jmpq   40122a <lex_next+0x841>
  401020:	b8 00 00 00 00       	mov    $0x0,%eax
  401025:	e8 13 f9 ff ff       	callq  40093d <lex_peek>
  40102a:	88 45 df             	mov    %al,-0x21(%rbp)
  40102d:	48 8b 5d e8          	mov    -0x18(%rbp),%rbx
  401031:	48 8d 43 01          	lea    0x1(%rbx),%rax
  401035:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  401039:	b8 00 00 00 00       	mov    $0x0,%eax
  40103e:	e8 45 f9 ff ff       	callq  400988 <lex_getc>
  401043:	88 03                	mov    %al,(%rbx)
  401045:	b8 00 00 00 00       	mov    $0x0,%eax
  40104a:	e8 ee f8 ff ff       	callq  40093d <lex_peek>
  40104f:	88 45 df             	mov    %al,-0x21(%rbp)
  401052:	80 7d df 00          	cmpb   $0x0,-0x21(%rbp)
  401056:	7e 2a                	jle    401082 <lex_next+0x699>
  401058:	80 7d df 5f          	cmpb   $0x5f,-0x21(%rbp)
  40105c:	74 cf                	je     40102d <lex_next+0x644>
  40105e:	80 7d df 60          	cmpb   $0x60,-0x21(%rbp)
  401062:	7e 06                	jle    40106a <lex_next+0x681>
  401064:	80 7d df 7a          	cmpb   $0x7a,-0x21(%rbp)
  401068:	7e c3                	jle    40102d <lex_next+0x644>
  40106a:	80 7d df 40          	cmpb   $0x40,-0x21(%rbp)
  40106e:	7e 06                	jle    401076 <lex_next+0x68d>
  401070:	80 7d df 5a          	cmpb   $0x5a,-0x21(%rbp)
  401074:	7e b7                	jle    40102d <lex_next+0x644>
  401076:	80 7d df 2f          	cmpb   $0x2f,-0x21(%rbp)
  40107a:	7e 06                	jle    401082 <lex_next+0x699>
  40107c:	80 7d df 39          	cmpb   $0x39,-0x21(%rbp)
  401080:	7e ab                	jle    40102d <lex_next+0x644>
  401082:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401086:	48 8d 50 01          	lea    0x1(%rax),%rdx
  40108a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  40108e:	c6 00 00             	movb   $0x0,(%rax)
  401091:	be c8 27 40 00       	mov    $0x4027c8,%esi
  401096:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  40109b:	e8 c0 f5 ff ff       	callq  400660 <strcmp@plt>
  4010a0:	85 c0                	test   %eax,%eax
  4010a2:	75 2d                	jne    4010d1 <lex_next+0x6e8>
  4010a4:	8b 05 36 3c 20 00    	mov    0x203c36(%rip),%eax        # 604ce0 <lex_token>
  4010aa:	85 c0                	test   %eax,%eax
  4010ac:	74 19                	je     4010c7 <lex_next+0x6de>
  4010ae:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  4010b3:	ba 01 00 00 00       	mov    $0x1,%edx
  4010b8:	be cc 27 40 00       	mov    $0x4027cc,%esi
  4010bd:	bf 98 27 40 00       	mov    $0x402798,%edi
  4010c2:	e8 69 f5 ff ff       	callq  400630 <__assert_fail@plt>
  4010c7:	c7 05 0f 3c 20 00 01 	movl   $0x1,0x203c0f(%rip)        # 604ce0 <lex_token>
  4010ce:	00 00 00 
  4010d1:	be d7 27 40 00       	mov    $0x4027d7,%esi
  4010d6:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  4010db:	e8 80 f5 ff ff       	callq  400660 <strcmp@plt>
  4010e0:	85 c0                	test   %eax,%eax
  4010e2:	75 2d                	jne    401111 <lex_next+0x728>
  4010e4:	8b 05 f6 3b 20 00    	mov    0x203bf6(%rip),%eax        # 604ce0 <lex_token>
  4010ea:	85 c0                	test   %eax,%eax
  4010ec:	74 19                	je     401107 <lex_next+0x71e>
  4010ee:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  4010f3:	ba 02 00 00 00       	mov    $0x2,%edx
  4010f8:	be cc 27 40 00       	mov    $0x4027cc,%esi
  4010fd:	bf 98 27 40 00       	mov    $0x402798,%edi
  401102:	e8 29 f5 ff ff       	callq  400630 <__assert_fail@plt>
  401107:	c7 05 cf 3b 20 00 02 	movl   $0x2,0x203bcf(%rip)        # 604ce0 <lex_token>
  40110e:	00 00 00 
  401111:	be dc 27 40 00       	mov    $0x4027dc,%esi
  401116:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  40111b:	e8 40 f5 ff ff       	callq  400660 <strcmp@plt>
  401120:	85 c0                	test   %eax,%eax
  401122:	75 2d                	jne    401151 <lex_next+0x768>
  401124:	8b 05 b6 3b 20 00    	mov    0x203bb6(%rip),%eax        # 604ce0 <lex_token>
  40112a:	85 c0                	test   %eax,%eax
  40112c:	74 19                	je     401147 <lex_next+0x75e>
  40112e:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  401133:	ba 03 00 00 00       	mov    $0x3,%edx
  401138:	be cc 27 40 00       	mov    $0x4027cc,%esi
  40113d:	bf 98 27 40 00       	mov    $0x402798,%edi
  401142:	e8 e9 f4 ff ff       	callq  400630 <__assert_fail@plt>
  401147:	c7 05 8f 3b 20 00 05 	movl   $0x5,0x203b8f(%rip)        # 604ce0 <lex_token>
  40114e:	00 00 00 
  401151:	be e2 27 40 00       	mov    $0x4027e2,%esi
  401156:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  40115b:	e8 00 f5 ff ff       	callq  400660 <strcmp@plt>
  401160:	85 c0                	test   %eax,%eax
  401162:	75 2d                	jne    401191 <lex_next+0x7a8>
  401164:	8b 05 76 3b 20 00    	mov    0x203b76(%rip),%eax        # 604ce0 <lex_token>
  40116a:	85 c0                	test   %eax,%eax
  40116c:	74 19                	je     401187 <lex_next+0x79e>
  40116e:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  401173:	ba 04 00 00 00       	mov    $0x4,%edx
  401178:	be cc 27 40 00       	mov    $0x4027cc,%esi
  40117d:	bf 98 27 40 00       	mov    $0x402798,%edi
  401182:	e8 a9 f4 ff ff       	callq  400630 <__assert_fail@plt>
  401187:	c7 05 4f 3b 20 00 03 	movl   $0x3,0x203b4f(%rip)        # 604ce0 <lex_token>
  40118e:	00 00 00 
  401191:	be e7 27 40 00       	mov    $0x4027e7,%esi
  401196:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  40119b:	e8 c0 f4 ff ff       	callq  400660 <strcmp@plt>
  4011a0:	85 c0                	test   %eax,%eax
  4011a2:	75 2d                	jne    4011d1 <lex_next+0x7e8>
  4011a4:	8b 05 36 3b 20 00    	mov    0x203b36(%rip),%eax        # 604ce0 <lex_token>
  4011aa:	85 c0                	test   %eax,%eax
  4011ac:	74 19                	je     4011c7 <lex_next+0x7de>
  4011ae:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  4011b3:	ba 05 00 00 00       	mov    $0x5,%edx
  4011b8:	be cc 27 40 00       	mov    $0x4027cc,%esi
  4011bd:	bf 98 27 40 00       	mov    $0x402798,%edi
  4011c2:	e8 69 f4 ff ff       	callq  400630 <__assert_fail@plt>
  4011c7:	c7 05 0f 3b 20 00 04 	movl   $0x4,0x203b0f(%rip)        # 604ce0 <lex_token>
  4011ce:	00 00 00 
  4011d1:	be ee 27 40 00       	mov    $0x4027ee,%esi
  4011d6:	bf a0 40 60 00       	mov    $0x6040a0,%edi
  4011db:	e8 80 f4 ff ff       	callq  400660 <strcmp@plt>
  4011e0:	85 c0                	test   %eax,%eax
  4011e2:	75 2d                	jne    401211 <lex_next+0x828>
  4011e4:	8b 05 f6 3a 20 00    	mov    0x203af6(%rip),%eax        # 604ce0 <lex_token>
  4011ea:	85 c0                	test   %eax,%eax
  4011ec:	74 19                	je     401207 <lex_next+0x81e>
  4011ee:	b9 d8 2a 40 00       	mov    $0x402ad8,%ecx
  4011f3:	ba 06 00 00 00       	mov    $0x6,%edx
  4011f8:	be cc 27 40 00       	mov    $0x4027cc,%esi
  4011fd:	bf 98 27 40 00       	mov    $0x402798,%edi
  401202:	e8 29 f4 ff ff       	callq  400630 <__assert_fail@plt>
  401207:	c7 05 cf 3a 20 00 0a 	movl   $0xa,0x203acf(%rip)        # 604ce0 <lex_token>
  40120e:	00 00 00 
  401211:	8b 05 c9 3a 20 00    	mov    0x203ac9(%rip),%eax        # 604ce0 <lex_token>
  401217:	85 c0                	test   %eax,%eax
  401219:	75 0a                	jne    401225 <lex_next+0x83c>
  40121b:	c7 05 bb 3a 20 00 23 	movl   $0x23,0x203abb(%rip)        # 604ce0 <lex_token>
  401222:	00 00 00 
  401225:	b8 00 00 00 00       	mov    $0x0,%eax
  40122a:	48 83 c4 28          	add    $0x28,%rsp
  40122e:	5b                   	pop    %rbx
  40122f:	5d                   	pop    %rbp
  401230:	c3                   	retq   

0000000000401231 <lex_print_token>:
  401231:	55                   	push   %rbp
  401232:	48 89 e5             	mov    %rsp,%rbp
  401235:	48 83 ec 20          	sub    $0x20,%rsp
  401239:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  40123d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  401244:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401248:	8b 00                	mov    (%rax),%eax
  40124a:	83 f8 01             	cmp    $0x1,%eax
  40124d:	75 72                	jne    4012c1 <lex_print_token+0x90>
  40124f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401253:	74 19                	je     40126e <lex_print_token+0x3d>
  401255:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40125a:	ba 01 00 00 00       	mov    $0x1,%edx
  40125f:	be f5 27 40 00       	mov    $0x4027f5,%esi
  401264:	bf 01 28 40 00       	mov    $0x402801,%edi
  401269:	e8 c2 f3 ff ff       	callq  400630 <__assert_fail@plt>
  40126e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401275:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401279:	48 8b 40 08          	mov    0x8(%rax),%rax
  40127d:	48 89 c6             	mov    %rax,%rsi
  401280:	bf 0f 28 40 00       	mov    $0x40280f,%edi
  401285:	b8 00 00 00 00       	mov    $0x0,%eax
  40128a:	e8 91 f3 ff ff       	callq  400620 <printf@plt>
  40128f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401293:	8b 00                	mov    (%rax),%eax
  401295:	83 f8 06             	cmp    $0x6,%eax
  401298:	75 1d                	jne    4012b7 <lex_print_token+0x86>
  40129a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40129e:	48 8b 40 10          	mov    0x10(%rax),%rax
  4012a2:	8b 00                	mov    (%rax),%eax
  4012a4:	89 c6                	mov    %eax,%esi
  4012a6:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  4012ab:	b8 00 00 00 00       	mov    $0x0,%eax
  4012b0:	e8 6b f3 ff ff       	callq  400620 <printf@plt>
  4012b5:	eb 0a                	jmp    4012c1 <lex_print_token+0x90>
  4012b7:	bf 24 28 40 00       	mov    $0x402824,%edi
  4012bc:	e8 4f f3 ff ff       	callq  400610 <puts@plt>
  4012c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4012c5:	8b 00                	mov    (%rax),%eax
  4012c7:	83 f8 02             	cmp    $0x2,%eax
  4012ca:	75 72                	jne    40133e <lex_print_token+0x10d>
  4012cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4012d0:	74 19                	je     4012eb <lex_print_token+0xba>
  4012d2:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4012d7:	ba 02 00 00 00       	mov    $0x2,%edx
  4012dc:	be f5 27 40 00       	mov    $0x4027f5,%esi
  4012e1:	bf 01 28 40 00       	mov    $0x402801,%edi
  4012e6:	e8 45 f3 ff ff       	callq  400630 <__assert_fail@plt>
  4012eb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4012f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4012f6:	48 8b 40 08          	mov    0x8(%rax),%rax
  4012fa:	48 89 c6             	mov    %rax,%rsi
  4012fd:	bf 26 28 40 00       	mov    $0x402826,%edi
  401302:	b8 00 00 00 00       	mov    $0x0,%eax
  401307:	e8 14 f3 ff ff       	callq  400620 <printf@plt>
  40130c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401310:	8b 00                	mov    (%rax),%eax
  401312:	83 f8 06             	cmp    $0x6,%eax
  401315:	75 1d                	jne    401334 <lex_print_token+0x103>
  401317:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40131b:	48 8b 40 10          	mov    0x10(%rax),%rax
  40131f:	8b 00                	mov    (%rax),%eax
  401321:	89 c6                	mov    %eax,%esi
  401323:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  401328:	b8 00 00 00 00       	mov    $0x0,%eax
  40132d:	e8 ee f2 ff ff       	callq  400620 <printf@plt>
  401332:	eb 0a                	jmp    40133e <lex_print_token+0x10d>
  401334:	bf 24 28 40 00       	mov    $0x402824,%edi
  401339:	e8 d2 f2 ff ff       	callq  400610 <puts@plt>
  40133e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401342:	8b 00                	mov    (%rax),%eax
  401344:	83 f8 03             	cmp    $0x3,%eax
  401347:	75 72                	jne    4013bb <lex_print_token+0x18a>
  401349:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  40134d:	74 19                	je     401368 <lex_print_token+0x137>
  40134f:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401354:	ba 03 00 00 00       	mov    $0x3,%edx
  401359:	be f5 27 40 00       	mov    $0x4027f5,%esi
  40135e:	bf 01 28 40 00       	mov    $0x402801,%edi
  401363:	e8 c8 f2 ff ff       	callq  400630 <__assert_fail@plt>
  401368:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40136f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401373:	48 8b 40 08          	mov    0x8(%rax),%rax
  401377:	48 89 c6             	mov    %rax,%rsi
  40137a:	bf 35 28 40 00       	mov    $0x402835,%edi
  40137f:	b8 00 00 00 00       	mov    $0x0,%eax
  401384:	e8 97 f2 ff ff       	callq  400620 <printf@plt>
  401389:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40138d:	8b 00                	mov    (%rax),%eax
  40138f:	83 f8 06             	cmp    $0x6,%eax
  401392:	75 1d                	jne    4013b1 <lex_print_token+0x180>
  401394:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401398:	48 8b 40 10          	mov    0x10(%rax),%rax
  40139c:	8b 00                	mov    (%rax),%eax
  40139e:	89 c6                	mov    %eax,%esi
  4013a0:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  4013a5:	b8 00 00 00 00       	mov    $0x0,%eax
  4013aa:	e8 71 f2 ff ff       	callq  400620 <printf@plt>
  4013af:	eb 0a                	jmp    4013bb <lex_print_token+0x18a>
  4013b1:	bf 24 28 40 00       	mov    $0x402824,%edi
  4013b6:	e8 55 f2 ff ff       	callq  400610 <puts@plt>
  4013bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4013bf:	8b 00                	mov    (%rax),%eax
  4013c1:	83 f8 04             	cmp    $0x4,%eax
  4013c4:	75 72                	jne    401438 <lex_print_token+0x207>
  4013c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4013ca:	74 19                	je     4013e5 <lex_print_token+0x1b4>
  4013cc:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4013d1:	ba 04 00 00 00       	mov    $0x4,%edx
  4013d6:	be f5 27 40 00       	mov    $0x4027f5,%esi
  4013db:	bf 01 28 40 00       	mov    $0x402801,%edi
  4013e0:	e8 4b f2 ff ff       	callq  400630 <__assert_fail@plt>
  4013e5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4013ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4013f0:	48 8b 40 08          	mov    0x8(%rax),%rax
  4013f4:	48 89 c6             	mov    %rax,%rsi
  4013f7:	bf 44 28 40 00       	mov    $0x402844,%edi
  4013fc:	b8 00 00 00 00       	mov    $0x0,%eax
  401401:	e8 1a f2 ff ff       	callq  400620 <printf@plt>
  401406:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40140a:	8b 00                	mov    (%rax),%eax
  40140c:	83 f8 06             	cmp    $0x6,%eax
  40140f:	75 1d                	jne    40142e <lex_print_token+0x1fd>
  401411:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401415:	48 8b 40 10          	mov    0x10(%rax),%rax
  401419:	8b 00                	mov    (%rax),%eax
  40141b:	89 c6                	mov    %eax,%esi
  40141d:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  401422:	b8 00 00 00 00       	mov    $0x0,%eax
  401427:	e8 f4 f1 ff ff       	callq  400620 <printf@plt>
  40142c:	eb 0a                	jmp    401438 <lex_print_token+0x207>
  40142e:	bf 24 28 40 00       	mov    $0x402824,%edi
  401433:	e8 d8 f1 ff ff       	callq  400610 <puts@plt>
  401438:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40143c:	8b 00                	mov    (%rax),%eax
  40143e:	83 f8 06             	cmp    $0x6,%eax
  401441:	75 72                	jne    4014b5 <lex_print_token+0x284>
  401443:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401447:	74 19                	je     401462 <lex_print_token+0x231>
  401449:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40144e:	ba 05 00 00 00       	mov    $0x5,%edx
  401453:	be f5 27 40 00       	mov    $0x4027f5,%esi
  401458:	bf 01 28 40 00       	mov    $0x402801,%edi
  40145d:	e8 ce f1 ff ff       	callq  400630 <__assert_fail@plt>
  401462:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401469:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40146d:	48 8b 40 08          	mov    0x8(%rax),%rax
  401471:	48 89 c6             	mov    %rax,%rsi
  401474:	bf 55 28 40 00       	mov    $0x402855,%edi
  401479:	b8 00 00 00 00       	mov    $0x0,%eax
  40147e:	e8 9d f1 ff ff       	callq  400620 <printf@plt>
  401483:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401487:	8b 00                	mov    (%rax),%eax
  401489:	83 f8 06             	cmp    $0x6,%eax
  40148c:	75 1d                	jne    4014ab <lex_print_token+0x27a>
  40148e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401492:	48 8b 40 10          	mov    0x10(%rax),%rax
  401496:	8b 00                	mov    (%rax),%eax
  401498:	89 c6                	mov    %eax,%esi
  40149a:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  40149f:	b8 00 00 00 00       	mov    $0x0,%eax
  4014a4:	e8 77 f1 ff ff       	callq  400620 <printf@plt>
  4014a9:	eb 0a                	jmp    4014b5 <lex_print_token+0x284>
  4014ab:	bf 24 28 40 00       	mov    $0x402824,%edi
  4014b0:	e8 5b f1 ff ff       	callq  400610 <puts@plt>
  4014b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4014b9:	8b 00                	mov    (%rax),%eax
  4014bb:	83 f8 07             	cmp    $0x7,%eax
  4014be:	75 72                	jne    401532 <lex_print_token+0x301>
  4014c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4014c4:	74 19                	je     4014df <lex_print_token+0x2ae>
  4014c6:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4014cb:	ba 06 00 00 00       	mov    $0x6,%edx
  4014d0:	be f5 27 40 00       	mov    $0x4027f5,%esi
  4014d5:	bf 01 28 40 00       	mov    $0x402801,%edi
  4014da:	e8 51 f1 ff ff       	callq  400630 <__assert_fail@plt>
  4014df:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4014e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4014ea:	48 8b 40 08          	mov    0x8(%rax),%rax
  4014ee:	48 89 c6             	mov    %rax,%rsi
  4014f1:	bf 69 28 40 00       	mov    $0x402869,%edi
  4014f6:	b8 00 00 00 00       	mov    $0x0,%eax
  4014fb:	e8 20 f1 ff ff       	callq  400620 <printf@plt>
  401500:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401504:	8b 00                	mov    (%rax),%eax
  401506:	83 f8 06             	cmp    $0x6,%eax
  401509:	75 1d                	jne    401528 <lex_print_token+0x2f7>
  40150b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40150f:	48 8b 40 10          	mov    0x10(%rax),%rax
  401513:	8b 00                	mov    (%rax),%eax
  401515:	89 c6                	mov    %eax,%esi
  401517:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  40151c:	b8 00 00 00 00       	mov    $0x0,%eax
  401521:	e8 fa f0 ff ff       	callq  400620 <printf@plt>
  401526:	eb 0a                	jmp    401532 <lex_print_token+0x301>
  401528:	bf 24 28 40 00       	mov    $0x402824,%edi
  40152d:	e8 de f0 ff ff       	callq  400610 <puts@plt>
  401532:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401536:	8b 00                	mov    (%rax),%eax
  401538:	83 f8 08             	cmp    $0x8,%eax
  40153b:	75 72                	jne    4015af <lex_print_token+0x37e>
  40153d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401541:	74 19                	je     40155c <lex_print_token+0x32b>
  401543:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401548:	ba 07 00 00 00       	mov    $0x7,%edx
  40154d:	be f5 27 40 00       	mov    $0x4027f5,%esi
  401552:	bf 01 28 40 00       	mov    $0x402801,%edi
  401557:	e8 d4 f0 ff ff       	callq  400630 <__assert_fail@plt>
  40155c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401563:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401567:	48 8b 40 08          	mov    0x8(%rax),%rax
  40156b:	48 89 c6             	mov    %rax,%rsi
  40156e:	bf 7e 28 40 00       	mov    $0x40287e,%edi
  401573:	b8 00 00 00 00       	mov    $0x0,%eax
  401578:	e8 a3 f0 ff ff       	callq  400620 <printf@plt>
  40157d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401581:	8b 00                	mov    (%rax),%eax
  401583:	83 f8 06             	cmp    $0x6,%eax
  401586:	75 1d                	jne    4015a5 <lex_print_token+0x374>
  401588:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40158c:	48 8b 40 10          	mov    0x10(%rax),%rax
  401590:	8b 00                	mov    (%rax),%eax
  401592:	89 c6                	mov    %eax,%esi
  401594:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  401599:	b8 00 00 00 00       	mov    $0x0,%eax
  40159e:	e8 7d f0 ff ff       	callq  400620 <printf@plt>
  4015a3:	eb 0a                	jmp    4015af <lex_print_token+0x37e>
  4015a5:	bf 24 28 40 00       	mov    $0x402824,%edi
  4015aa:	e8 61 f0 ff ff       	callq  400610 <puts@plt>
  4015af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4015b3:	8b 00                	mov    (%rax),%eax
  4015b5:	83 f8 09             	cmp    $0x9,%eax
  4015b8:	75 72                	jne    40162c <lex_print_token+0x3fb>
  4015ba:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4015be:	74 19                	je     4015d9 <lex_print_token+0x3a8>
  4015c0:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4015c5:	ba 08 00 00 00       	mov    $0x8,%edx
  4015ca:	be f5 27 40 00       	mov    $0x4027f5,%esi
  4015cf:	bf 01 28 40 00       	mov    $0x402801,%edi
  4015d4:	e8 57 f0 ff ff       	callq  400630 <__assert_fail@plt>
  4015d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4015e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4015e4:	48 8b 40 08          	mov    0x8(%rax),%rax
  4015e8:	48 89 c6             	mov    %rax,%rsi
  4015eb:	bf 95 28 40 00       	mov    $0x402895,%edi
  4015f0:	b8 00 00 00 00       	mov    $0x0,%eax
  4015f5:	e8 26 f0 ff ff       	callq  400620 <printf@plt>
  4015fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4015fe:	8b 00                	mov    (%rax),%eax
  401600:	83 f8 06             	cmp    $0x6,%eax
  401603:	75 1d                	jne    401622 <lex_print_token+0x3f1>
  401605:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401609:	48 8b 40 10          	mov    0x10(%rax),%rax
  40160d:	8b 00                	mov    (%rax),%eax
  40160f:	89 c6                	mov    %eax,%esi
  401611:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  401616:	b8 00 00 00 00       	mov    $0x0,%eax
  40161b:	e8 00 f0 ff ff       	callq  400620 <printf@plt>
  401620:	eb 0a                	jmp    40162c <lex_print_token+0x3fb>
  401622:	bf 24 28 40 00       	mov    $0x402824,%edi
  401627:	e8 e4 ef ff ff       	callq  400610 <puts@plt>
  40162c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401630:	8b 00                	mov    (%rax),%eax
  401632:	83 f8 23             	cmp    $0x23,%eax
  401635:	75 72                	jne    4016a9 <lex_print_token+0x478>
  401637:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  40163b:	74 19                	je     401656 <lex_print_token+0x425>
  40163d:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401642:	ba 09 00 00 00       	mov    $0x9,%edx
  401647:	be f5 27 40 00       	mov    $0x4027f5,%esi
  40164c:	bf 01 28 40 00       	mov    $0x402801,%edi
  401651:	e8 da ef ff ff       	callq  400630 <__assert_fail@plt>
  401656:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40165d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401661:	48 8b 40 08          	mov    0x8(%rax),%rax
  401665:	48 89 c6             	mov    %rax,%rsi
  401668:	bf a2 28 40 00       	mov    $0x4028a2,%edi
  40166d:	b8 00 00 00 00       	mov    $0x0,%eax
  401672:	e8 a9 ef ff ff       	callq  400620 <printf@plt>
  401677:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40167b:	8b 00                	mov    (%rax),%eax
  40167d:	83 f8 06             	cmp    $0x6,%eax
  401680:	75 1d                	jne    40169f <lex_print_token+0x46e>
  401682:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401686:	48 8b 40 10          	mov    0x10(%rax),%rax
  40168a:	8b 00                	mov    (%rax),%eax
  40168c:	89 c6                	mov    %eax,%esi
  40168e:	bf 1d 28 40 00       	mov    $0x40281d,%edi
  401693:	b8 00 00 00 00       	mov    $0x0,%eax
  401698:	e8 83 ef ff ff       	callq  400620 <printf@plt>
  40169d:	eb 0a                	jmp    4016a9 <lex_print_token+0x478>
  40169f:	bf 24 28 40 00       	mov    $0x402824,%edi
  4016a4:	e8 67 ef ff ff       	callq  400610 <puts@plt>
  4016a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4016ad:	8b 00                	mov    (%rax),%eax
  4016af:	83 f8 0b             	cmp    $0xb,%eax
  4016b2:	75 45                	jne    4016f9 <lex_print_token+0x4c8>
  4016b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4016b8:	74 19                	je     4016d3 <lex_print_token+0x4a2>
  4016ba:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4016bf:	ba 08 00 00 00       	mov    $0x8,%edx
  4016c4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  4016c9:	bf 01 28 40 00       	mov    $0x402801,%edi
  4016ce:	e8 5d ef ff ff       	callq  400630 <__assert_fail@plt>
  4016d3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4016da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4016de:	48 8b 40 08          	mov    0x8(%rax),%rax
  4016e2:	48 89 c6             	mov    %rax,%rsi
  4016e5:	bf b7 28 40 00       	mov    $0x4028b7,%edi
  4016ea:	b8 00 00 00 00       	mov    $0x0,%eax
  4016ef:	e8 2c ef ff ff       	callq  400620 <printf@plt>
  4016f4:	e9 59 09 00 00       	jmpq   402052 <lex_print_token+0xe21>
  4016f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4016fd:	8b 00                	mov    (%rax),%eax
  4016ff:	83 f8 0c             	cmp    $0xc,%eax
  401702:	75 45                	jne    401749 <lex_print_token+0x518>
  401704:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401708:	74 19                	je     401723 <lex_print_token+0x4f2>
  40170a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40170f:	ba 09 00 00 00       	mov    $0x9,%edx
  401714:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401719:	bf 01 28 40 00       	mov    $0x402801,%edi
  40171e:	e8 0d ef ff ff       	callq  400630 <__assert_fail@plt>
  401723:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40172a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40172e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401732:	48 89 c6             	mov    %rax,%rsi
  401735:	bf cc 28 40 00       	mov    $0x4028cc,%edi
  40173a:	b8 00 00 00 00       	mov    $0x0,%eax
  40173f:	e8 dc ee ff ff       	callq  400620 <printf@plt>
  401744:	e9 09 09 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401749:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40174d:	8b 00                	mov    (%rax),%eax
  40174f:	83 f8 0d             	cmp    $0xd,%eax
  401752:	75 45                	jne    401799 <lex_print_token+0x568>
  401754:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401758:	74 19                	je     401773 <lex_print_token+0x542>
  40175a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40175f:	ba 0a 00 00 00       	mov    $0xa,%edx
  401764:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401769:	bf 01 28 40 00       	mov    $0x402801,%edi
  40176e:	e8 bd ee ff ff       	callq  400630 <__assert_fail@plt>
  401773:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40177a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40177e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401782:	48 89 c6             	mov    %rax,%rsi
  401785:	bf df 28 40 00       	mov    $0x4028df,%edi
  40178a:	b8 00 00 00 00       	mov    $0x0,%eax
  40178f:	e8 8c ee ff ff       	callq  400620 <printf@plt>
  401794:	e9 b9 08 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401799:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40179d:	8b 00                	mov    (%rax),%eax
  40179f:	83 f8 0e             	cmp    $0xe,%eax
  4017a2:	75 45                	jne    4017e9 <lex_print_token+0x5b8>
  4017a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4017a8:	74 19                	je     4017c3 <lex_print_token+0x592>
  4017aa:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4017af:	ba 0b 00 00 00       	mov    $0xb,%edx
  4017b4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  4017b9:	bf 01 28 40 00       	mov    $0x402801,%edi
  4017be:	e8 6d ee ff ff       	callq  400630 <__assert_fail@plt>
  4017c3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4017ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4017ce:	48 8b 40 08          	mov    0x8(%rax),%rax
  4017d2:	48 89 c6             	mov    %rax,%rsi
  4017d5:	bf f2 28 40 00       	mov    $0x4028f2,%edi
  4017da:	b8 00 00 00 00       	mov    $0x0,%eax
  4017df:	e8 3c ee ff ff       	callq  400620 <printf@plt>
  4017e4:	e9 69 08 00 00       	jmpq   402052 <lex_print_token+0xe21>
  4017e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4017ed:	8b 00                	mov    (%rax),%eax
  4017ef:	83 f8 0f             	cmp    $0xf,%eax
  4017f2:	75 45                	jne    401839 <lex_print_token+0x608>
  4017f4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4017f8:	74 19                	je     401813 <lex_print_token+0x5e2>
  4017fa:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4017ff:	ba 0c 00 00 00       	mov    $0xc,%edx
  401804:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401809:	bf 01 28 40 00       	mov    $0x402801,%edi
  40180e:	e8 1d ee ff ff       	callq  400630 <__assert_fail@plt>
  401813:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40181a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40181e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401822:	48 89 c6             	mov    %rax,%rsi
  401825:	bf 06 29 40 00       	mov    $0x402906,%edi
  40182a:	b8 00 00 00 00       	mov    $0x0,%eax
  40182f:	e8 ec ed ff ff       	callq  400620 <printf@plt>
  401834:	e9 19 08 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401839:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40183d:	8b 00                	mov    (%rax),%eax
  40183f:	83 f8 10             	cmp    $0x10,%eax
  401842:	75 45                	jne    401889 <lex_print_token+0x658>
  401844:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401848:	74 19                	je     401863 <lex_print_token+0x632>
  40184a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40184f:	ba 0d 00 00 00       	mov    $0xd,%edx
  401854:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401859:	bf 01 28 40 00       	mov    $0x402801,%edi
  40185e:	e8 cd ed ff ff       	callq  400630 <__assert_fail@plt>
  401863:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40186a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40186e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401872:	48 89 c6             	mov    %rax,%rsi
  401875:	bf 19 29 40 00       	mov    $0x402919,%edi
  40187a:	b8 00 00 00 00       	mov    $0x0,%eax
  40187f:	e8 9c ed ff ff       	callq  400620 <printf@plt>
  401884:	e9 c9 07 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401889:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40188d:	8b 00                	mov    (%rax),%eax
  40188f:	83 f8 11             	cmp    $0x11,%eax
  401892:	75 45                	jne    4018d9 <lex_print_token+0x6a8>
  401894:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401898:	74 19                	je     4018b3 <lex_print_token+0x682>
  40189a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40189f:	ba 0e 00 00 00       	mov    $0xe,%edx
  4018a4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  4018a9:	bf 01 28 40 00       	mov    $0x402801,%edi
  4018ae:	e8 7d ed ff ff       	callq  400630 <__assert_fail@plt>
  4018b3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4018ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4018be:	48 8b 40 08          	mov    0x8(%rax),%rax
  4018c2:	48 89 c6             	mov    %rax,%rsi
  4018c5:	bf 2b 29 40 00       	mov    $0x40292b,%edi
  4018ca:	b8 00 00 00 00       	mov    $0x0,%eax
  4018cf:	e8 4c ed ff ff       	callq  400620 <printf@plt>
  4018d4:	e9 79 07 00 00       	jmpq   402052 <lex_print_token+0xe21>
  4018d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4018dd:	8b 00                	mov    (%rax),%eax
  4018df:	83 f8 12             	cmp    $0x12,%eax
  4018e2:	75 45                	jne    401929 <lex_print_token+0x6f8>
  4018e4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4018e8:	74 19                	je     401903 <lex_print_token+0x6d2>
  4018ea:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4018ef:	ba 0f 00 00 00       	mov    $0xf,%edx
  4018f4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  4018f9:	bf 01 28 40 00       	mov    $0x402801,%edi
  4018fe:	e8 2d ed ff ff       	callq  400630 <__assert_fail@plt>
  401903:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40190a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40190e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401912:	48 89 c6             	mov    %rax,%rsi
  401915:	bf 3e 29 40 00       	mov    $0x40293e,%edi
  40191a:	b8 00 00 00 00       	mov    $0x0,%eax
  40191f:	e8 fc ec ff ff       	callq  400620 <printf@plt>
  401924:	e9 29 07 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401929:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40192d:	8b 00                	mov    (%rax),%eax
  40192f:	83 f8 13             	cmp    $0x13,%eax
  401932:	75 45                	jne    401979 <lex_print_token+0x748>
  401934:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401938:	74 19                	je     401953 <lex_print_token+0x722>
  40193a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40193f:	ba 10 00 00 00       	mov    $0x10,%edx
  401944:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401949:	bf 01 28 40 00       	mov    $0x402801,%edi
  40194e:	e8 dd ec ff ff       	callq  400630 <__assert_fail@plt>
  401953:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  40195a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40195e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401962:	48 89 c6             	mov    %rax,%rsi
  401965:	bf 50 29 40 00       	mov    $0x402950,%edi
  40196a:	b8 00 00 00 00       	mov    $0x0,%eax
  40196f:	e8 ac ec ff ff       	callq  400620 <printf@plt>
  401974:	e9 d9 06 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401979:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40197d:	8b 00                	mov    (%rax),%eax
  40197f:	83 f8 14             	cmp    $0x14,%eax
  401982:	75 45                	jne    4019c9 <lex_print_token+0x798>
  401984:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401988:	74 19                	je     4019a3 <lex_print_token+0x772>
  40198a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40198f:	ba 12 00 00 00       	mov    $0x12,%edx
  401994:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401999:	bf 01 28 40 00       	mov    $0x402801,%edi
  40199e:	e8 8d ec ff ff       	callq  400630 <__assert_fail@plt>
  4019a3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4019aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4019ae:	48 8b 40 08          	mov    0x8(%rax),%rax
  4019b2:	48 89 c6             	mov    %rax,%rsi
  4019b5:	bf 62 29 40 00       	mov    $0x402962,%edi
  4019ba:	b8 00 00 00 00       	mov    $0x0,%eax
  4019bf:	e8 5c ec ff ff       	callq  400620 <printf@plt>
  4019c4:	e9 89 06 00 00       	jmpq   402052 <lex_print_token+0xe21>
  4019c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4019cd:	8b 00                	mov    (%rax),%eax
  4019cf:	83 f8 15             	cmp    $0x15,%eax
  4019d2:	75 45                	jne    401a19 <lex_print_token+0x7e8>
  4019d4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  4019d8:	74 19                	je     4019f3 <lex_print_token+0x7c2>
  4019da:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  4019df:	ba 13 00 00 00       	mov    $0x13,%edx
  4019e4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  4019e9:	bf 01 28 40 00       	mov    $0x402801,%edi
  4019ee:	e8 3d ec ff ff       	callq  400630 <__assert_fail@plt>
  4019f3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  4019fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4019fe:	48 8b 40 08          	mov    0x8(%rax),%rax
  401a02:	48 89 c6             	mov    %rax,%rsi
  401a05:	bf 75 29 40 00       	mov    $0x402975,%edi
  401a0a:	b8 00 00 00 00       	mov    $0x0,%eax
  401a0f:	e8 0c ec ff ff       	callq  400620 <printf@plt>
  401a14:	e9 39 06 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401a19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401a1d:	8b 00                	mov    (%rax),%eax
  401a1f:	83 f8 16             	cmp    $0x16,%eax
  401a22:	75 45                	jne    401a69 <lex_print_token+0x838>
  401a24:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401a28:	74 19                	je     401a43 <lex_print_token+0x812>
  401a2a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401a2f:	ba 14 00 00 00       	mov    $0x14,%edx
  401a34:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401a39:	bf 01 28 40 00       	mov    $0x402801,%edi
  401a3e:	e8 ed eb ff ff       	callq  400630 <__assert_fail@plt>
  401a43:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401a4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401a4e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401a52:	48 89 c6             	mov    %rax,%rsi
  401a55:	bf 88 29 40 00       	mov    $0x402988,%edi
  401a5a:	b8 00 00 00 00       	mov    $0x0,%eax
  401a5f:	e8 bc eb ff ff       	callq  400620 <printf@plt>
  401a64:	e9 e9 05 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401a69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401a6d:	8b 00                	mov    (%rax),%eax
  401a6f:	83 f8 17             	cmp    $0x17,%eax
  401a72:	75 45                	jne    401ab9 <lex_print_token+0x888>
  401a74:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401a78:	74 19                	je     401a93 <lex_print_token+0x862>
  401a7a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401a7f:	ba 15 00 00 00       	mov    $0x15,%edx
  401a84:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401a89:	bf 01 28 40 00       	mov    $0x402801,%edi
  401a8e:	e8 9d eb ff ff       	callq  400630 <__assert_fail@plt>
  401a93:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401a9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401a9e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401aa2:	48 89 c6             	mov    %rax,%rsi
  401aa5:	bf 9b 29 40 00       	mov    $0x40299b,%edi
  401aaa:	b8 00 00 00 00       	mov    $0x0,%eax
  401aaf:	e8 6c eb ff ff       	callq  400620 <printf@plt>
  401ab4:	e9 99 05 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401ab9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401abd:	8b 00                	mov    (%rax),%eax
  401abf:	83 f8 18             	cmp    $0x18,%eax
  401ac2:	75 45                	jne    401b09 <lex_print_token+0x8d8>
  401ac4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401ac8:	74 19                	je     401ae3 <lex_print_token+0x8b2>
  401aca:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401acf:	ba 16 00 00 00       	mov    $0x16,%edx
  401ad4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401ad9:	bf 01 28 40 00       	mov    $0x402801,%edi
  401ade:	e8 4d eb ff ff       	callq  400630 <__assert_fail@plt>
  401ae3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401aea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401aee:	48 8b 40 08          	mov    0x8(%rax),%rax
  401af2:	48 89 c6             	mov    %rax,%rsi
  401af5:	bf ae 29 40 00       	mov    $0x4029ae,%edi
  401afa:	b8 00 00 00 00       	mov    $0x0,%eax
  401aff:	e8 1c eb ff ff       	callq  400620 <printf@plt>
  401b04:	e9 49 05 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401b09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401b0d:	8b 00                	mov    (%rax),%eax
  401b0f:	83 f8 19             	cmp    $0x19,%eax
  401b12:	75 45                	jne    401b59 <lex_print_token+0x928>
  401b14:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401b18:	74 19                	je     401b33 <lex_print_token+0x902>
  401b1a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401b1f:	ba 17 00 00 00       	mov    $0x17,%edx
  401b24:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401b29:	bf 01 28 40 00       	mov    $0x402801,%edi
  401b2e:	e8 fd ea ff ff       	callq  400630 <__assert_fail@plt>
  401b33:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401b3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401b3e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401b42:	48 89 c6             	mov    %rax,%rsi
  401b45:	bf c2 29 40 00       	mov    $0x4029c2,%edi
  401b4a:	b8 00 00 00 00       	mov    $0x0,%eax
  401b4f:	e8 cc ea ff ff       	callq  400620 <printf@plt>
  401b54:	e9 f9 04 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401b59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401b5d:	8b 00                	mov    (%rax),%eax
  401b5f:	83 f8 1a             	cmp    $0x1a,%eax
  401b62:	75 45                	jne    401ba9 <lex_print_token+0x978>
  401b64:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401b68:	74 19                	je     401b83 <lex_print_token+0x952>
  401b6a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401b6f:	ba 18 00 00 00       	mov    $0x18,%edx
  401b74:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401b79:	bf 01 28 40 00       	mov    $0x402801,%edi
  401b7e:	e8 ad ea ff ff       	callq  400630 <__assert_fail@plt>
  401b83:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401b8a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401b8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401b92:	48 89 c6             	mov    %rax,%rsi
  401b95:	bf d6 29 40 00       	mov    $0x4029d6,%edi
  401b9a:	b8 00 00 00 00       	mov    $0x0,%eax
  401b9f:	e8 7c ea ff ff       	callq  400620 <printf@plt>
  401ba4:	e9 a9 04 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401ba9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401bad:	8b 00                	mov    (%rax),%eax
  401baf:	83 f8 1b             	cmp    $0x1b,%eax
  401bb2:	75 45                	jne    401bf9 <lex_print_token+0x9c8>
  401bb4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401bb8:	74 19                	je     401bd3 <lex_print_token+0x9a2>
  401bba:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401bbf:	ba 19 00 00 00       	mov    $0x19,%edx
  401bc4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401bc9:	bf 01 28 40 00       	mov    $0x402801,%edi
  401bce:	e8 5d ea ff ff       	callq  400630 <__assert_fail@plt>
  401bd3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401bda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401bde:	48 8b 40 08          	mov    0x8(%rax),%rax
  401be2:	48 89 c6             	mov    %rax,%rsi
  401be5:	bf e9 29 40 00       	mov    $0x4029e9,%edi
  401bea:	b8 00 00 00 00       	mov    $0x0,%eax
  401bef:	e8 2c ea ff ff       	callq  400620 <printf@plt>
  401bf4:	e9 59 04 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401bf9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401bfd:	8b 00                	mov    (%rax),%eax
  401bff:	83 f8 1c             	cmp    $0x1c,%eax
  401c02:	75 45                	jne    401c49 <lex_print_token+0xa18>
  401c04:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401c08:	74 19                	je     401c23 <lex_print_token+0x9f2>
  401c0a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401c0f:	ba 1a 00 00 00       	mov    $0x1a,%edx
  401c14:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401c19:	bf 01 28 40 00       	mov    $0x402801,%edi
  401c1e:	e8 0d ea ff ff       	callq  400630 <__assert_fail@plt>
  401c23:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401c2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401c2e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401c32:	48 89 c6             	mov    %rax,%rsi
  401c35:	bf fc 29 40 00       	mov    $0x4029fc,%edi
  401c3a:	b8 00 00 00 00       	mov    $0x0,%eax
  401c3f:	e8 dc e9 ff ff       	callq  400620 <printf@plt>
  401c44:	e9 09 04 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401c49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401c4d:	8b 00                	mov    (%rax),%eax
  401c4f:	83 f8 1d             	cmp    $0x1d,%eax
  401c52:	75 45                	jne    401c99 <lex_print_token+0xa68>
  401c54:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401c58:	74 19                	je     401c73 <lex_print_token+0xa42>
  401c5a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401c5f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  401c64:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401c69:	bf 01 28 40 00       	mov    $0x402801,%edi
  401c6e:	e8 bd e9 ff ff       	callq  400630 <__assert_fail@plt>
  401c73:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401c7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401c7e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401c82:	48 89 c6             	mov    %rax,%rsi
  401c85:	bf 0e 2a 40 00       	mov    $0x402a0e,%edi
  401c8a:	b8 00 00 00 00       	mov    $0x0,%eax
  401c8f:	e8 8c e9 ff ff       	callq  400620 <printf@plt>
  401c94:	e9 b9 03 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401c99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401c9d:	8b 00                	mov    (%rax),%eax
  401c9f:	83 f8 1e             	cmp    $0x1e,%eax
  401ca2:	75 45                	jne    401ce9 <lex_print_token+0xab8>
  401ca4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401ca8:	74 19                	je     401cc3 <lex_print_token+0xa92>
  401caa:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401caf:	ba 1c 00 00 00       	mov    $0x1c,%edx
  401cb4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401cb9:	bf 01 28 40 00       	mov    $0x402801,%edi
  401cbe:	e8 6d e9 ff ff       	callq  400630 <__assert_fail@plt>
  401cc3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401cca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401cce:	48 8b 40 08          	mov    0x8(%rax),%rax
  401cd2:	48 89 c6             	mov    %rax,%rsi
  401cd5:	bf 20 2a 40 00       	mov    $0x402a20,%edi
  401cda:	b8 00 00 00 00       	mov    $0x0,%eax
  401cdf:	e8 3c e9 ff ff       	callq  400620 <printf@plt>
  401ce4:	e9 69 03 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401ce9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401ced:	8b 00                	mov    (%rax),%eax
  401cef:	83 f8 1f             	cmp    $0x1f,%eax
  401cf2:	75 45                	jne    401d39 <lex_print_token+0xb08>
  401cf4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401cf8:	74 19                	je     401d13 <lex_print_token+0xae2>
  401cfa:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401cff:	ba 1d 00 00 00       	mov    $0x1d,%edx
  401d04:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401d09:	bf 01 28 40 00       	mov    $0x402801,%edi
  401d0e:	e8 1d e9 ff ff       	callq  400630 <__assert_fail@plt>
  401d13:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401d1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401d1e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401d22:	48 89 c6             	mov    %rax,%rsi
  401d25:	bf 34 2a 40 00       	mov    $0x402a34,%edi
  401d2a:	b8 00 00 00 00       	mov    $0x0,%eax
  401d2f:	e8 ec e8 ff ff       	callq  400620 <printf@plt>
  401d34:	e9 19 03 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401d39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401d3d:	8b 00                	mov    (%rax),%eax
  401d3f:	83 f8 20             	cmp    $0x20,%eax
  401d42:	75 45                	jne    401d89 <lex_print_token+0xb58>
  401d44:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401d48:	74 19                	je     401d63 <lex_print_token+0xb32>
  401d4a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401d4f:	ba 1e 00 00 00       	mov    $0x1e,%edx
  401d54:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401d59:	bf 01 28 40 00       	mov    $0x402801,%edi
  401d5e:	e8 cd e8 ff ff       	callq  400630 <__assert_fail@plt>
  401d63:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401d6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401d6e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401d72:	48 89 c6             	mov    %rax,%rsi
  401d75:	bf 48 2a 40 00       	mov    $0x402a48,%edi
  401d7a:	b8 00 00 00 00       	mov    $0x0,%eax
  401d7f:	e8 9c e8 ff ff       	callq  400620 <printf@plt>
  401d84:	e9 c9 02 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401d89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401d8d:	8b 00                	mov    (%rax),%eax
  401d8f:	83 f8 21             	cmp    $0x21,%eax
  401d92:	75 45                	jne    401dd9 <lex_print_token+0xba8>
  401d94:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401d98:	74 19                	je     401db3 <lex_print_token+0xb82>
  401d9a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401d9f:	ba 20 00 00 00       	mov    $0x20,%edx
  401da4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401da9:	bf 01 28 40 00       	mov    $0x402801,%edi
  401dae:	e8 7d e8 ff ff       	callq  400630 <__assert_fail@plt>
  401db3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401dba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401dbe:	48 8b 40 08          	mov    0x8(%rax),%rax
  401dc2:	48 89 c6             	mov    %rax,%rsi
  401dc5:	bf 5b 2a 40 00       	mov    $0x402a5b,%edi
  401dca:	b8 00 00 00 00       	mov    $0x0,%eax
  401dcf:	e8 4c e8 ff ff       	callq  400620 <printf@plt>
  401dd4:	e9 79 02 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401dd9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401ddd:	8b 00                	mov    (%rax),%eax
  401ddf:	83 f8 22             	cmp    $0x22,%eax
  401de2:	75 45                	jne    401e29 <lex_print_token+0xbf8>
  401de4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401de8:	74 19                	je     401e03 <lex_print_token+0xbd2>
  401dea:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401def:	ba 23 00 00 00       	mov    $0x23,%edx
  401df4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401df9:	bf 01 28 40 00       	mov    $0x402801,%edi
  401dfe:	e8 2d e8 ff ff       	callq  400630 <__assert_fail@plt>
  401e03:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401e0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401e0e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401e12:	48 89 c6             	mov    %rax,%rsi
  401e15:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401e1a:	b8 00 00 00 00       	mov    $0x0,%eax
  401e1f:	e8 fc e7 ff ff       	callq  400620 <printf@plt>
  401e24:	e9 29 02 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401e29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401e2d:	8b 00                	mov    (%rax),%eax
  401e2f:	83 f8 22             	cmp    $0x22,%eax
  401e32:	75 45                	jne    401e79 <lex_print_token+0xc48>
  401e34:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401e38:	74 19                	je     401e53 <lex_print_token+0xc22>
  401e3a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401e3f:	ba 24 00 00 00       	mov    $0x24,%edx
  401e44:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401e49:	bf 01 28 40 00       	mov    $0x402801,%edi
  401e4e:	e8 dd e7 ff ff       	callq  400630 <__assert_fail@plt>
  401e53:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401e5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401e5e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401e62:	48 89 c6             	mov    %rax,%rsi
  401e65:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401e6a:	b8 00 00 00 00       	mov    $0x0,%eax
  401e6f:	e8 ac e7 ff ff       	callq  400620 <printf@plt>
  401e74:	e9 d9 01 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401e79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401e7d:	8b 00                	mov    (%rax),%eax
  401e7f:	83 f8 22             	cmp    $0x22,%eax
  401e82:	75 45                	jne    401ec9 <lex_print_token+0xc98>
  401e84:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401e88:	74 19                	je     401ea3 <lex_print_token+0xc72>
  401e8a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401e8f:	ba 25 00 00 00       	mov    $0x25,%edx
  401e94:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401e99:	bf 01 28 40 00       	mov    $0x402801,%edi
  401e9e:	e8 8d e7 ff ff       	callq  400630 <__assert_fail@plt>
  401ea3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401eaa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401eae:	48 8b 40 08          	mov    0x8(%rax),%rax
  401eb2:	48 89 c6             	mov    %rax,%rsi
  401eb5:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401eba:	b8 00 00 00 00       	mov    $0x0,%eax
  401ebf:	e8 5c e7 ff ff       	callq  400620 <printf@plt>
  401ec4:	e9 89 01 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401ec9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401ecd:	8b 00                	mov    (%rax),%eax
  401ecf:	83 f8 22             	cmp    $0x22,%eax
  401ed2:	75 45                	jne    401f19 <lex_print_token+0xce8>
  401ed4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401ed8:	74 19                	je     401ef3 <lex_print_token+0xcc2>
  401eda:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401edf:	ba 26 00 00 00       	mov    $0x26,%edx
  401ee4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401ee9:	bf 01 28 40 00       	mov    $0x402801,%edi
  401eee:	e8 3d e7 ff ff       	callq  400630 <__assert_fail@plt>
  401ef3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401efa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401efe:	48 8b 40 08          	mov    0x8(%rax),%rax
  401f02:	48 89 c6             	mov    %rax,%rsi
  401f05:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401f0a:	b8 00 00 00 00       	mov    $0x0,%eax
  401f0f:	e8 0c e7 ff ff       	callq  400620 <printf@plt>
  401f14:	e9 39 01 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401f19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401f1d:	8b 00                	mov    (%rax),%eax
  401f1f:	83 f8 22             	cmp    $0x22,%eax
  401f22:	75 45                	jne    401f69 <lex_print_token+0xd38>
  401f24:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401f28:	74 19                	je     401f43 <lex_print_token+0xd12>
  401f2a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401f2f:	ba 27 00 00 00       	mov    $0x27,%edx
  401f34:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401f39:	bf 01 28 40 00       	mov    $0x402801,%edi
  401f3e:	e8 ed e6 ff ff       	callq  400630 <__assert_fail@plt>
  401f43:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401f4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401f4e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401f52:	48 89 c6             	mov    %rax,%rsi
  401f55:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401f5a:	b8 00 00 00 00       	mov    $0x0,%eax
  401f5f:	e8 bc e6 ff ff       	callq  400620 <printf@plt>
  401f64:	e9 e9 00 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401f69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401f6d:	8b 00                	mov    (%rax),%eax
  401f6f:	83 f8 22             	cmp    $0x22,%eax
  401f72:	75 45                	jne    401fb9 <lex_print_token+0xd88>
  401f74:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401f78:	74 19                	je     401f93 <lex_print_token+0xd62>
  401f7a:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401f7f:	ba 28 00 00 00       	mov    $0x28,%edx
  401f84:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401f89:	bf 01 28 40 00       	mov    $0x402801,%edi
  401f8e:	e8 9d e6 ff ff       	callq  400630 <__assert_fail@plt>
  401f93:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401f9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401f9e:	48 8b 40 08          	mov    0x8(%rax),%rax
  401fa2:	48 89 c6             	mov    %rax,%rsi
  401fa5:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401faa:	b8 00 00 00 00       	mov    $0x0,%eax
  401faf:	e8 6c e6 ff ff       	callq  400620 <printf@plt>
  401fb4:	e9 99 00 00 00       	jmpq   402052 <lex_print_token+0xe21>
  401fb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401fbd:	8b 00                	mov    (%rax),%eax
  401fbf:	83 f8 22             	cmp    $0x22,%eax
  401fc2:	75 42                	jne    402006 <lex_print_token+0xdd5>
  401fc4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  401fc8:	74 19                	je     401fe3 <lex_print_token+0xdb2>
  401fca:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  401fcf:	ba 29 00 00 00       	mov    $0x29,%edx
  401fd4:	be 8c 27 40 00       	mov    $0x40278c,%esi
  401fd9:	bf 01 28 40 00       	mov    $0x402801,%edi
  401fde:	e8 4d e6 ff ff       	callq  400630 <__assert_fail@plt>
  401fe3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  401fea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  401fee:	48 8b 40 08          	mov    0x8(%rax),%rax
  401ff2:	48 89 c6             	mov    %rax,%rsi
  401ff5:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  401ffa:	b8 00 00 00 00       	mov    $0x0,%eax
  401fff:	e8 1c e6 ff ff       	callq  400620 <printf@plt>
  402004:	eb 4c                	jmp    402052 <lex_print_token+0xe21>
  402006:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40200a:	8b 00                	mov    (%rax),%eax
  40200c:	83 f8 22             	cmp    $0x22,%eax
  40200f:	75 41                	jne    402052 <lex_print_token+0xe21>
  402011:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  402015:	74 19                	je     402030 <lex_print_token+0xdff>
  402017:	b9 f0 2a 40 00       	mov    $0x402af0,%ecx
  40201c:	ba 2a 00 00 00       	mov    $0x2a,%edx
  402021:	be 8c 27 40 00       	mov    $0x40278c,%esi
  402026:	bf 01 28 40 00       	mov    $0x402801,%edi
  40202b:	e8 00 e6 ff ff       	callq  400630 <__assert_fail@plt>
  402030:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  402037:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  40203b:	48 8b 40 08          	mov    0x8(%rax),%rax
  40203f:	48 89 c6             	mov    %rax,%rsi
  402042:	bf 71 2a 40 00       	mov    $0x402a71,%edi
  402047:	b8 00 00 00 00       	mov    $0x0,%eax
  40204c:	e8 cf e5 ff ff       	callq  400620 <printf@plt>
  402051:	90                   	nop
  402052:	c9                   	leaveq 
  402053:	c3                   	retq   

0000000000402054 <lex_init>:
  402054:	55                   	push   %rbp
  402055:	48 89 e5             	mov    %rsp,%rbp
  402058:	c7 05 5e 24 20 00 ff 	movl   $0xffffffff,0x20245e(%rip)        # 6044c0 <lex_nextc>
  40205f:	ff ff ff 
  402062:	48 c7 05 5b 24 20 00 	movq   $0x0,0x20245b(%rip)        # 6044c8 <lex_fp>
  402069:	00 00 00 00 
  40206d:	90                   	nop
  40206e:	5d                   	pop    %rbp
  40206f:	c3                   	retq   

0000000000402070 <prs_init>:
  402070:	55                   	push   %rbp
  402071:	48 89 e5             	mov    %rsp,%rbp
  402074:	c7 05 8e 28 20 00 00 	movl   $0x0,0x20288e(%rip)        # 60490c <prs_prec+0x2c>
  40207b:	00 00 00 
  40207e:	c7 05 84 24 20 00 00 	movl   $0x0,0x202484(%rip)        # 60450c <prs_asso+0x2c>
  402085:	00 00 00 
  402088:	c7 05 7e 28 20 00 0e 	movl   $0xe,0x20287e(%rip)        # 604910 <prs_prec+0x30>
  40208f:	00 00 00 
  402092:	c7 05 74 24 20 00 00 	movl   $0x0,0x202474(%rip)        # 604510 <prs_asso+0x30>
  402099:	00 00 00 
  40209c:	c7 05 6e 28 20 00 0e 	movl   $0xe,0x20286e(%rip)        # 604914 <prs_prec+0x34>
  4020a3:	00 00 00 
  4020a6:	c7 05 64 24 20 00 00 	movl   $0x0,0x202464(%rip)        # 604514 <prs_asso+0x34>
  4020ad:	00 00 00 
  4020b0:	c7 05 5e 28 20 00 05 	movl   $0x5,0x20285e(%rip)        # 604918 <prs_prec+0x38>
  4020b7:	00 00 00 
  4020ba:	c7 05 54 24 20 00 00 	movl   $0x0,0x202454(%rip)        # 604518 <prs_asso+0x38>
  4020c1:	00 00 00 
  4020c4:	c7 05 4e 28 20 00 04 	movl   $0x4,0x20284e(%rip)        # 60491c <prs_prec+0x3c>
  4020cb:	00 00 00 
  4020ce:	c7 05 44 24 20 00 00 	movl   $0x0,0x202444(%rip)        # 60451c <prs_asso+0x3c>
  4020d5:	00 00 00 
  4020d8:	c7 05 3e 28 20 00 09 	movl   $0x9,0x20283e(%rip)        # 604920 <prs_prec+0x40>
  4020df:	00 00 00 
  4020e2:	c7 05 34 24 20 00 00 	movl   $0x0,0x202434(%rip)        # 604520 <prs_asso+0x40>
  4020e9:	00 00 00 
  4020ec:	c7 05 2e 28 20 00 09 	movl   $0x9,0x20282e(%rip)        # 604924 <prs_prec+0x44>
  4020f3:	00 00 00 
  4020f6:	c7 05 24 24 20 00 00 	movl   $0x0,0x202424(%rip)        # 604524 <prs_asso+0x44>
  4020fd:	00 00 00 
  402100:	c7 05 1e 28 20 00 0a 	movl   $0xa,0x20281e(%rip)        # 604928 <prs_prec+0x48>
  402107:	00 00 00 
  40210a:	c7 05 14 24 20 00 00 	movl   $0x0,0x202414(%rip)        # 604528 <prs_asso+0x48>
  402111:	00 00 00 
  402114:	c7 05 0e 28 20 00 0a 	movl   $0xa,0x20280e(%rip)        # 60492c <prs_prec+0x4c>
  40211b:	00 00 00 
  40211e:	c7 05 04 24 20 00 00 	movl   $0x0,0x202404(%rip)        # 60452c <prs_asso+0x4c>
  402125:	00 00 00 
  402128:	c7 05 fe 27 20 00 0c 	movl   $0xc,0x2027fe(%rip)        # 604930 <prs_prec+0x50>
  40212f:	00 00 00 
  402132:	c7 05 f4 23 20 00 00 	movl   $0x0,0x2023f4(%rip)        # 604530 <prs_asso+0x50>
  402139:	00 00 00 
  40213c:	c7 05 ee 27 20 00 0c 	movl   $0xc,0x2027ee(%rip)        # 604934 <prs_prec+0x54>
  402143:	00 00 00 
  402146:	c7 05 e4 23 20 00 00 	movl   $0x0,0x2023e4(%rip)        # 604534 <prs_asso+0x54>
  40214d:	00 00 00 
  402150:	c7 05 de 27 20 00 0d 	movl   $0xd,0x2027de(%rip)        # 604938 <prs_prec+0x58>
  402157:	00 00 00 
  40215a:	c7 05 d4 23 20 00 00 	movl   $0x0,0x2023d4(%rip)        # 604538 <prs_asso+0x58>
  402161:	00 00 00 
  402164:	c7 05 ce 27 20 00 0d 	movl   $0xd,0x2027ce(%rip)        # 60493c <prs_prec+0x5c>
  40216b:	00 00 00 
  40216e:	c7 05 c4 23 20 00 00 	movl   $0x0,0x2023c4(%rip)        # 60453c <prs_asso+0x5c>
  402175:	00 00 00 
  402178:	c7 05 be 27 20 00 08 	movl   $0x8,0x2027be(%rip)        # 604940 <prs_prec+0x60>
  40217f:	00 00 00 
  402182:	c7 05 b4 23 20 00 00 	movl   $0x0,0x2023b4(%rip)        # 604540 <prs_asso+0x60>
  402189:	00 00 00 
  40218c:	c7 05 ae 27 20 00 07 	movl   $0x7,0x2027ae(%rip)        # 604944 <prs_prec+0x64>
  402193:	00 00 00 
  402196:	c7 05 a4 23 20 00 00 	movl   $0x0,0x2023a4(%rip)        # 604544 <prs_asso+0x64>
  40219d:	00 00 00 
  4021a0:	c7 05 9e 27 20 00 06 	movl   $0x6,0x20279e(%rip)        # 604948 <prs_prec+0x68>
  4021a7:	00 00 00 
  4021aa:	c7 05 94 23 20 00 00 	movl   $0x0,0x202394(%rip)        # 604548 <prs_asso+0x68>
  4021b1:	00 00 00 
  4021b4:	c7 05 8e 27 20 00 0d 	movl   $0xd,0x20278e(%rip)        # 60494c <prs_prec+0x6c>
  4021bb:	00 00 00 
  4021be:	c7 05 84 23 20 00 00 	movl   $0x0,0x202384(%rip)        # 60454c <prs_asso+0x6c>
  4021c5:	00 00 00 
  4021c8:	c7 05 7e 27 20 00 0a 	movl   $0xa,0x20277e(%rip)        # 604950 <prs_prec+0x70>
  4021cf:	00 00 00 
  4021d2:	c7 05 74 23 20 00 00 	movl   $0x0,0x202374(%rip)        # 604550 <prs_asso+0x70>
  4021d9:	00 00 00 
  4021dc:	c7 05 6e 27 20 00 0a 	movl   $0xa,0x20276e(%rip)        # 604954 <prs_prec+0x74>
  4021e3:	00 00 00 
  4021e6:	c7 05 64 23 20 00 00 	movl   $0x0,0x202364(%rip)        # 604554 <prs_asso+0x74>
  4021ed:	00 00 00 
  4021f0:	c7 05 5e 27 20 00 0e 	movl   $0xe,0x20275e(%rip)        # 604958 <prs_prec+0x78>
  4021f7:	00 00 00 
  4021fa:	c7 05 54 23 20 00 00 	movl   $0x0,0x202354(%rip)        # 604558 <prs_asso+0x78>
  402201:	00 00 00 
  402204:	c7 05 4e 27 20 00 0e 	movl   $0xe,0x20274e(%rip)        # 60495c <prs_prec+0x7c>
  40220b:	00 00 00 
  40220e:	c7 05 44 23 20 00 00 	movl   $0x0,0x202344(%rip)        # 60455c <prs_asso+0x7c>
  402215:	00 00 00 
  402218:	c7 05 3e 27 20 00 00 	movl   $0x0,0x20273e(%rip)        # 604960 <prs_prec+0x80>
  40221f:	00 00 00 
  402222:	c7 05 34 23 20 00 00 	movl   $0x0,0x202334(%rip)        # 604560 <prs_asso+0x80>
  402229:	00 00 00 
  40222c:	c7 05 2e 27 20 00 02 	movl   $0x2,0x20272e(%rip)        # 604964 <prs_prec+0x84>
  402233:	00 00 00 
  402236:	c7 05 24 23 20 00 01 	movl   $0x1,0x202324(%rip)        # 604564 <prs_asso+0x84>
  40223d:	00 00 00 
  402240:	90                   	nop
  402241:	5d                   	pop    %rbp
  402242:	c3                   	retq   

0000000000402243 <prs_expect_char>:
  402243:	55                   	push   %rbp
  402244:	48 89 e5             	mov    %rsp,%rbp
  402247:	48 83 ec 10          	sub    $0x10,%rsp
  40224b:	89 f8                	mov    %edi,%eax
  40224d:	88 45 fc             	mov    %al,-0x4(%rbp)
  402250:	48 8b 05 91 2a 20 00 	mov    0x202a91(%rip),%rax        # 604ce8 <lex_token+0x8>
  402257:	0f b6 00             	movzbl (%rax),%eax
  40225a:	3a 45 fc             	cmp    -0x4(%rbp),%al
  40225d:	74 19                	je     402278 <prs_expect_char+0x35>
  40225f:	b9 00 2b 40 00       	mov    $0x402b00,%ecx
  402264:	ba 3d 01 00 00       	mov    $0x13d,%edx
  402269:	be 87 2a 40 00       	mov    $0x402a87,%esi
  40226e:	bf 8d 2a 40 00       	mov    $0x402a8d,%edi
  402273:	e8 b8 e3 ff ff       	callq  400630 <__assert_fail@plt>
  402278:	b8 00 00 00 00       	mov    $0x0,%eax
  40227d:	c9                   	leaveq 
  40227e:	c3                   	retq   

000000000040227f <prs_expr>:
  40227f:	55                   	push   %rbp
  402280:	48 89 e5             	mov    %rsp,%rbp
  402283:	8b 05 db 26 20 00    	mov    0x2026db(%rip),%eax        # 604964 <prs_prec+0x84>
  402289:	89 c7                	mov    %eax,%edi
  40228b:	b8 00 00 00 00       	mov    $0x0,%eax
  402290:	e8 07 00 00 00       	callq  40229c <prs_binary>
  402295:	b8 00 00 00 00       	mov    $0x0,%eax
  40229a:	5d                   	pop    %rbp
  40229b:	c3                   	retq   

000000000040229c <prs_binary>:
  40229c:	55                   	push   %rbp
  40229d:	48 89 e5             	mov    %rsp,%rbp
  4022a0:	48 83 ec 20          	sub    $0x20,%rsp
  4022a4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  4022a7:	b8 00 00 00 00       	mov    $0x0,%eax
  4022ac:	e8 52 00 00 00       	callq  402303 <prs_unary>
  4022b1:	8b 05 29 2a 20 00    	mov    0x202a29(%rip),%eax        # 604ce0 <lex_token>
  4022b7:	89 c0                	mov    %eax,%eax
  4022b9:	8b 04 85 e0 48 60 00 	mov    0x6048e0(,%rax,4),%eax
  4022c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  4022c3:	eb 2f                	jmp    4022f4 <prs_binary+0x58>
  4022c5:	b8 00 00 00 00       	mov    $0x0,%eax
  4022ca:	e8 1a e7 ff ff       	callq  4009e9 <lex_next>
  4022cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4022d2:	83 c0 01             	add    $0x1,%eax
  4022d5:	89 c7                	mov    %eax,%edi
  4022d7:	e8 c0 ff ff ff       	callq  40229c <prs_binary>
  4022dc:	8b 05 fe 29 20 00    	mov    0x2029fe(%rip),%eax        # 604ce0 <lex_token>
  4022e2:	89 c0                	mov    %eax,%eax
  4022e4:	8b 04 85 e0 48 60 00 	mov    0x6048e0(,%rax,4),%eax
  4022eb:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  4022ee:	74 d5                	je     4022c5 <prs_binary+0x29>
  4022f0:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
  4022f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4022f7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  4022fa:	7d e0                	jge    4022dc <prs_binary+0x40>
  4022fc:	b8 00 00 00 00       	mov    $0x0,%eax
  402301:	c9                   	leaveq 
  402302:	c3                   	retq   

0000000000402303 <prs_unary>:
  402303:	55                   	push   %rbp
  402304:	48 89 e5             	mov    %rsp,%rbp
  402307:	8b 05 d3 29 20 00    	mov    0x2029d3(%rip),%eax        # 604ce0 <lex_token>
  40230d:	83 f8 0a             	cmp    $0xa,%eax
  402310:	75 76                	jne    402388 <prs_unary+0x85>
  402312:	b8 00 00 00 00       	mov    $0x0,%eax
  402317:	e8 cd e6 ff ff       	callq  4009e9 <lex_next>
  40231c:	48 8b 05 c5 29 20 00 	mov    0x2029c5(%rip),%rax        # 604ce8 <lex_token+0x8>
  402323:	0f b6 00             	movzbl (%rax),%eax
  402326:	3c 28                	cmp    $0x28,%al
  402328:	75 4f                	jne    402379 <prs_unary+0x76>
  40232a:	b8 00 00 00 00       	mov    $0x0,%eax
  40232f:	e8 b5 e6 ff ff       	callq  4009e9 <lex_next>
  402334:	bf e0 4c 60 00       	mov    $0x604ce0,%edi
  402339:	e8 6e 02 00 00       	callq  4025ac <sym_hasid>
  40233e:	85 c0                	test   %eax,%eax
  402340:	75 14                	jne    402356 <prs_unary+0x53>
  402342:	bf a6 2a 40 00       	mov    $0x402aa6,%edi
  402347:	b8 00 00 00 00       	mov    $0x0,%eax
  40234c:	e8 65 e4 ff ff       	callq  4007b6 <fexit>
  402351:	e9 da 00 00 00       	jmpq   402430 <prs_unary+0x12d>
  402356:	b8 00 00 00 00       	mov    $0x0,%eax
  40235b:	e8 89 e6 ff ff       	callq  4009e9 <lex_next>
  402360:	bf 29 00 00 00       	mov    $0x29,%edi
  402365:	e8 d9 fe ff ff       	callq  402243 <prs_expect_char>
  40236a:	b8 00 00 00 00       	mov    $0x0,%eax
  40236f:	e8 75 e6 ff ff       	callq  4009e9 <lex_next>
  402374:	e9 b7 00 00 00       	jmpq   402430 <prs_unary+0x12d>
  402379:	b8 00 00 00 00       	mov    $0x0,%eax
  40237e:	e8 80 ff ff ff       	callq  402303 <prs_unary>
  402383:	e9 a8 00 00 00       	jmpq   402430 <prs_unary+0x12d>
  402388:	48 8b 05 59 29 20 00 	mov    0x202959(%rip),%rax        # 604ce8 <lex_token+0x8>
  40238f:	0f b6 00             	movzbl (%rax),%eax
  402392:	3c 28                	cmp    $0x28,%al
  402394:	75 6c                	jne    402402 <prs_unary+0xff>
  402396:	b8 00 00 00 00       	mov    $0x0,%eax
  40239b:	e8 49 e6 ff ff       	callq  4009e9 <lex_next>
  4023a0:	bf e0 4c 60 00       	mov    $0x604ce0,%edi
  4023a5:	e8 02 02 00 00       	callq  4025ac <sym_hasid>
  4023aa:	85 c0                	test   %eax,%eax
  4023ac:	74 2a                	je     4023d8 <prs_unary+0xd5>
  4023ae:	b8 00 00 00 00       	mov    $0x0,%eax
  4023b3:	e8 31 e6 ff ff       	callq  4009e9 <lex_next>
  4023b8:	bf 29 00 00 00       	mov    $0x29,%edi
  4023bd:	e8 81 fe ff ff       	callq  402243 <prs_expect_char>
  4023c2:	b8 00 00 00 00       	mov    $0x0,%eax
  4023c7:	e8 1d e6 ff ff       	callq  4009e9 <lex_next>
  4023cc:	b8 00 00 00 00       	mov    $0x0,%eax
  4023d1:	e8 2d ff ff ff       	callq  402303 <prs_unary>
  4023d6:	eb 58                	jmp    402430 <prs_unary+0x12d>
  4023d8:	b8 00 00 00 00       	mov    $0x0,%eax
  4023dd:	e8 9d fe ff ff       	callq  40227f <prs_expr>
  4023e2:	bf 29 00 00 00       	mov    $0x29,%edi
  4023e7:	e8 57 fe ff ff       	callq  402243 <prs_expect_char>
  4023ec:	b8 00 00 00 00       	mov    $0x0,%eax
  4023f1:	e8 f3 e5 ff ff       	callq  4009e9 <lex_next>
  4023f6:	bf 01 00 00 00       	mov    $0x1,%edi
  4023fb:	e8 37 00 00 00       	callq  402437 <prs_pst>
  402400:	eb 2e                	jmp    402430 <prs_unary+0x12d>
  402402:	bf e0 4c 60 00       	mov    $0x604ce0,%edi
  402407:	e8 ce e4 ff ff       	callq  4008da <lex_isunaryop>
  40240c:	85 c0                	test   %eax,%eax
  40240e:	74 16                	je     402426 <prs_unary+0x123>
  402410:	b8 00 00 00 00       	mov    $0x0,%eax
  402415:	e8 cf e5 ff ff       	callq  4009e9 <lex_next>
  40241a:	b8 00 00 00 00       	mov    $0x0,%eax
  40241f:	e8 df fe ff ff       	callq  402303 <prs_unary>
  402424:	eb 0a                	jmp    402430 <prs_unary+0x12d>
  402426:	bf 00 00 00 00       	mov    $0x0,%edi
  40242b:	e8 07 00 00 00       	callq  402437 <prs_pst>
  402430:	b8 00 00 00 00       	mov    $0x0,%eax
  402435:	5d                   	pop    %rbp
  402436:	c3                   	retq   

0000000000402437 <prs_pst>:
  402437:	55                   	push   %rbp
  402438:	48 89 e5             	mov    %rsp,%rbp
  40243b:	48 83 ec 10          	sub    $0x10,%rsp
  40243f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  402442:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  402446:	75 0a                	jne    402452 <prs_pst+0x1b>
  402448:	b8 00 00 00 00       	mov    $0x0,%eax
  40244d:	e8 d0 00 00 00       	callq  402522 <prs_primary>
  402452:	48 8b 05 8f 28 20 00 	mov    0x20288f(%rip),%rax        # 604ce8 <lex_token+0x8>
  402459:	0f b6 00             	movzbl (%rax),%eax
  40245c:	3c 5b                	cmp    $0x5b,%al
  40245e:	75 2a                	jne    40248a <prs_pst+0x53>
  402460:	b8 00 00 00 00       	mov    $0x0,%eax
  402465:	e8 7f e5 ff ff       	callq  4009e9 <lex_next>
  40246a:	b8 00 00 00 00       	mov    $0x0,%eax
  40246f:	e8 0b fe ff ff       	callq  40227f <prs_expr>
  402474:	bf 5d 00 00 00       	mov    $0x5d,%edi
  402479:	e8 c5 fd ff ff       	callq  402243 <prs_expect_char>
  40247e:	b8 00 00 00 00       	mov    $0x0,%eax
  402483:	e8 61 e5 ff ff       	callq  4009e9 <lex_next>
  402488:	eb c8                	jmp    402452 <prs_pst+0x1b>
  40248a:	48 8b 05 57 28 20 00 	mov    0x202857(%rip),%rax        # 604ce8 <lex_token+0x8>
  402491:	0f b6 00             	movzbl (%rax),%eax
  402494:	3c 2e                	cmp    $0x2e,%al
  402496:	75 20                	jne    4024b8 <prs_pst+0x81>
  402498:	b8 00 00 00 00       	mov    $0x0,%eax
  40249d:	e8 47 e5 ff ff       	callq  4009e9 <lex_next>
  4024a2:	bf e0 4c 60 00       	mov    $0x604ce0,%edi
  4024a7:	e8 00 01 00 00       	callq  4025ac <sym_hasid>
  4024ac:	b8 00 00 00 00       	mov    $0x0,%eax
  4024b1:	e8 33 e5 ff ff       	callq  4009e9 <lex_next>
  4024b6:	eb 9a                	jmp    402452 <prs_pst+0x1b>
  4024b8:	8b 05 22 28 20 00    	mov    0x202822(%rip),%eax        # 604ce0 <lex_token>
  4024be:	83 f8 0b             	cmp    $0xb,%eax
  4024c1:	75 23                	jne    4024e6 <prs_pst+0xaf>
  4024c3:	b8 00 00 00 00       	mov    $0x0,%eax
  4024c8:	e8 1c e5 ff ff       	callq  4009e9 <lex_next>
  4024cd:	bf e0 4c 60 00       	mov    $0x604ce0,%edi
  4024d2:	e8 d5 00 00 00       	callq  4025ac <sym_hasid>
  4024d7:	b8 00 00 00 00       	mov    $0x0,%eax
  4024dc:	e8 08 e5 ff ff       	callq  4009e9 <lex_next>
  4024e1:	e9 6c ff ff ff       	jmpq   402452 <prs_pst+0x1b>
  4024e6:	8b 05 f4 27 20 00    	mov    0x2027f4(%rip),%eax        # 604ce0 <lex_token>
  4024ec:	83 f8 0c             	cmp    $0xc,%eax
  4024ef:	75 0f                	jne    402500 <prs_pst+0xc9>
  4024f1:	b8 00 00 00 00       	mov    $0x0,%eax
  4024f6:	e8 ee e4 ff ff       	callq  4009e9 <lex_next>
  4024fb:	e9 52 ff ff ff       	jmpq   402452 <prs_pst+0x1b>
  402500:	8b 05 da 27 20 00    	mov    0x2027da(%rip),%eax        # 604ce0 <lex_token>
  402506:	83 f8 0d             	cmp    $0xd,%eax
  402509:	75 0f                	jne    40251a <prs_pst+0xe3>
  40250b:	b8 00 00 00 00       	mov    $0x0,%eax
  402510:	e8 d4 e4 ff ff       	callq  4009e9 <lex_next>
  402515:	e9 38 ff ff ff       	jmpq   402452 <prs_pst+0x1b>
  40251a:	90                   	nop
  40251b:	b8 00 00 00 00       	mov    $0x0,%eax
  402520:	c9                   	leaveq 
  402521:	c3                   	retq   

0000000000402522 <prs_primary>:
  402522:	55                   	push   %rbp
  402523:	48 89 e5             	mov    %rsp,%rbp
  402526:	8b 05 b4 27 20 00    	mov    0x2027b4(%rip),%eax        # 604ce0 <lex_token>
  40252c:	83 f8 23             	cmp    $0x23,%eax
  40252f:	75 0c                	jne    40253d <prs_primary+0x1b>
  402531:	b8 00 00 00 00       	mov    $0x0,%eax
  402536:	e8 ae e4 ff ff       	callq  4009e9 <lex_next>
  40253b:	eb 68                	jmp    4025a5 <prs_primary+0x83>
  40253d:	8b 05 9d 27 20 00    	mov    0x20279d(%rip),%eax        # 604ce0 <lex_token>
  402543:	83 f8 06             	cmp    $0x6,%eax
  402546:	75 0c                	jne    402554 <prs_primary+0x32>
  402548:	b8 00 00 00 00       	mov    $0x0,%eax
  40254d:	e8 97 e4 ff ff       	callq  4009e9 <lex_next>
  402552:	eb 51                	jmp    4025a5 <prs_primary+0x83>
  402554:	48 8b 05 8d 27 20 00 	mov    0x20278d(%rip),%rax        # 604ce8 <lex_token+0x8>
  40255b:	0f b6 00             	movzbl (%rax),%eax
  40255e:	3c 28                	cmp    $0x28,%al
  402560:	75 34                	jne    402596 <prs_primary+0x74>
  402562:	b8 00 00 00 00       	mov    $0x0,%eax
  402567:	e8 7d e4 ff ff       	callq  4009e9 <lex_next>
  40256c:	b8 00 00 00 00       	mov    $0x0,%eax
  402571:	e8 09 fd ff ff       	callq  40227f <prs_expr>
  402576:	b8 00 00 00 00       	mov    $0x0,%eax
  40257b:	e8 69 e4 ff ff       	callq  4009e9 <lex_next>
  402580:	bf 29 00 00 00       	mov    $0x29,%edi
  402585:	e8 b9 fc ff ff       	callq  402243 <prs_expect_char>
  40258a:	b8 00 00 00 00       	mov    $0x0,%eax
  40258f:	e8 55 e4 ff ff       	callq  4009e9 <lex_next>
  402594:	eb 0f                	jmp    4025a5 <prs_primary+0x83>
  402596:	bf ba 2a 40 00       	mov    $0x402aba,%edi
  40259b:	b8 00 00 00 00       	mov    $0x0,%eax
  4025a0:	e8 11 e2 ff ff       	callq  4007b6 <fexit>
  4025a5:	b8 00 00 00 00       	mov    $0x0,%eax
  4025aa:	5d                   	pop    %rbp
  4025ab:	c3                   	retq   

00000000004025ac <sym_hasid>:
  4025ac:	55                   	push   %rbp
  4025ad:	48 89 e5             	mov    %rsp,%rbp
  4025b0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  4025b4:	b8 01 00 00 00       	mov    $0x1,%eax
  4025b9:	5d                   	pop    %rbp
  4025ba:	c3                   	retq   

00000000004025bb <init>:
  4025bb:	55                   	push   %rbp
  4025bc:	48 89 e5             	mov    %rsp,%rbp
  4025bf:	48 83 ec 10          	sub    $0x10,%rsp
  4025c3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  4025c6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  4025ca:	b8 00 00 00 00       	mov    $0x0,%eax
  4025cf:	e8 80 fa ff ff       	callq  402054 <lex_init>
  4025d4:	90                   	nop
  4025d5:	c9                   	leaveq 
  4025d6:	c3                   	retq   

00000000004025d7 <test_lex>:
  4025d7:	55                   	push   %rbp
  4025d8:	48 89 e5             	mov    %rsp,%rbp
  4025db:	48 83 ec 20          	sub    $0x20,%rsp
  4025df:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  4025e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4025e7:	48 89 c7             	mov    %rax,%rdi
  4025ea:	e8 43 e2 ff ff       	callq  400832 <lex_load_file>
  4025ef:	b8 00 00 00 00       	mov    $0x0,%eax
  4025f4:	e8 f0 e3 ff ff       	callq  4009e9 <lex_next>
  4025f9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  4025fc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  402600:	75 0c                	jne    40260e <test_lex+0x37>
  402602:	bf e0 4c 60 00       	mov    $0x604ce0,%edi
  402607:	e8 25 ec ff ff       	callq  401231 <lex_print_token>
  40260c:	eb e1                	jmp    4025ef <test_lex+0x18>
  40260e:	90                   	nop
  40260f:	c9                   	leaveq 
  402610:	c3                   	retq   

0000000000402611 <test_binary>:
  402611:	55                   	push   %rbp
  402612:	48 89 e5             	mov    %rsp,%rbp
  402615:	48 83 ec 10          	sub    $0x10,%rsp
  402619:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  40261d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  402621:	48 89 c7             	mov    %rax,%rdi
  402624:	e8 09 e2 ff ff       	callq  400832 <lex_load_file>
  402629:	b8 00 00 00 00       	mov    $0x0,%eax
  40262e:	e8 b6 e3 ff ff       	callq  4009e9 <lex_next>
  402633:	b8 00 00 00 00       	mov    $0x0,%eax
  402638:	e8 42 fc ff ff       	callq  40227f <prs_expr>
  40263d:	90                   	nop
  40263e:	c9                   	leaveq 
  40263f:	c3                   	retq   

0000000000402640 <main>:
  402640:	55                   	push   %rbp
  402641:	48 89 e5             	mov    %rsp,%rbp
  402644:	48 83 ec 10          	sub    $0x10,%rsp
  402648:	89 7d fc             	mov    %edi,-0x4(%rbp)
  40264b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  40264f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  402653:	8b 45 fc             	mov    -0x4(%rbp),%eax
  402656:	48 89 d6             	mov    %rdx,%rsi
  402659:	89 c7                	mov    %eax,%edi
  40265b:	e8 5b ff ff ff       	callq  4025bb <init>
  402660:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
  402664:	75 2f                	jne    402695 <main+0x55>
  402666:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  40266a:	48 83 c0 08          	add    $0x8,%rax
  40266e:	48 8b 00             	mov    (%rax),%rax
  402671:	48 89 c6             	mov    %rax,%rsi
  402674:	bf cb 2a 40 00       	mov    $0x402acb,%edi
  402679:	e8 e2 df ff ff       	callq  400660 <strcmp@plt>
  40267e:	85 c0                	test   %eax,%eax
  402680:	75 13                	jne    402695 <main+0x55>
  402682:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  402686:	48 83 c0 10          	add    $0x10,%rax
  40268a:	48 8b 00             	mov    (%rax),%rax
  40268d:	48 89 c7             	mov    %rax,%rdi
  402690:	e8 42 ff ff ff       	callq  4025d7 <test_lex>
  402695:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
  402699:	75 2f                	jne    4026ca <main+0x8a>
  40269b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  40269f:	48 83 c0 08          	add    $0x8,%rax
  4026a3:	48 8b 00             	mov    (%rax),%rax
  4026a6:	48 89 c6             	mov    %rax,%rsi
  4026a9:	bf ce 2a 40 00       	mov    $0x402ace,%edi
  4026ae:	e8 ad df ff ff       	callq  400660 <strcmp@plt>
  4026b3:	85 c0                	test   %eax,%eax
  4026b5:	75 13                	jne    4026ca <main+0x8a>
  4026b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  4026bb:	48 83 c0 10          	add    $0x10,%rax
  4026bf:	48 8b 00             	mov    (%rax),%rax
  4026c2:	48 89 c7             	mov    %rax,%rdi
  4026c5:	e8 47 ff ff ff       	callq  402611 <test_binary>
  4026ca:	b8 00 00 00 00       	mov    $0x0,%eax
  4026cf:	c9                   	leaveq 
  4026d0:	c3                   	retq   
  4026d1:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4026d8:	00 00 00 
  4026db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000004026e0 <__libc_csu_init>:
  4026e0:	41 57                	push   %r15
  4026e2:	41 56                	push   %r14
  4026e4:	41 89 ff             	mov    %edi,%r15d
  4026e7:	41 55                	push   %r13
  4026e9:	41 54                	push   %r12
  4026eb:	4c 8d 25 1e 17 20 00 	lea    0x20171e(%rip),%r12        # 603e10 <__frame_dummy_init_array_entry>
  4026f2:	55                   	push   %rbp
  4026f3:	48 8d 2d 1e 17 20 00 	lea    0x20171e(%rip),%rbp        # 603e18 <__init_array_end>
  4026fa:	53                   	push   %rbx
  4026fb:	49 89 f6             	mov    %rsi,%r14
  4026fe:	49 89 d5             	mov    %rdx,%r13
  402701:	4c 29 e5             	sub    %r12,%rbp
  402704:	48 83 ec 08          	sub    $0x8,%rsp
  402708:	48 c1 fd 03          	sar    $0x3,%rbp
  40270c:	e8 b7 de ff ff       	callq  4005c8 <_init>
  402711:	48 85 ed             	test   %rbp,%rbp
  402714:	74 20                	je     402736 <__libc_csu_init+0x56>
  402716:	31 db                	xor    %ebx,%ebx
  402718:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40271f:	00 
  402720:	4c 89 ea             	mov    %r13,%rdx
  402723:	4c 89 f6             	mov    %r14,%rsi
  402726:	44 89 ff             	mov    %r15d,%edi
  402729:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40272d:	48 83 c3 01          	add    $0x1,%rbx
  402731:	48 39 eb             	cmp    %rbp,%rbx
  402734:	75 ea                	jne    402720 <__libc_csu_init+0x40>
  402736:	48 83 c4 08          	add    $0x8,%rsp
  40273a:	5b                   	pop    %rbx
  40273b:	5d                   	pop    %rbp
  40273c:	41 5c                	pop    %r12
  40273e:	41 5d                	pop    %r13
  402740:	41 5e                	pop    %r14
  402742:	41 5f                	pop    %r15
  402744:	c3                   	retq   
  402745:	90                   	nop
  402746:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40274d:	00 00 00 

0000000000402750 <__libc_csu_fini>:
  402750:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000402754 <_fini>:
  402754:	48 83 ec 08          	sub    $0x8,%rsp
  402758:	48 83 c4 08          	add    $0x8,%rsp
  40275c:	c3                   	retq   
