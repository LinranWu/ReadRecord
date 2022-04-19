#BY SUBMITTING THIS FILE TO CARMEN, I CERTIFY THAT I HAVE STRICTLY ADHERED TO THE TENURES OF THE OHIO STATE UNIVERSIT'sACADEMIC INTEGRITY POLICY WITH RESPECT TO THIS ASSIGNMENT.
#student name: Linran Wu

#This program reads in 2 values from each lines of a file and prints out these two values and their product.
.file "main.s"
.section .rodata
#printf error message for checking if there is incorrect number of command line arguments 
printf_line:
	.string "ERROR: Please enter 2 command line arguments, program exit.\n"
access_type:
	.string "r"
.globl main
	.type main, @function
.text 
main:
	push %rbp		# save caller's %rbp
	movq %rsp, %rbp		# copy %rsp to %rbp so our stack frame is ready to use
    
	#check if have the right command line arg
	cmpq $3,%rdi
	je proceed

	pushq %rdi
	pushq %rsi
	movq $printf_line,%rdi
	movq $0,%rax
	call printf		#calling printf sending error message
	popq %rsi
	popq %rdi

	#exit the program
	jmp exit
proceed:
	#getting int count from atoi(*(argv+1))
	pushq %rsi
	movq 8(%rsi),%rdi
	call atoi
	popq %rsi
	movq %rax,%r9		#int count now in %r9

	#allocate space for structures of the same number as the first argv
	pushq %r9
        pushq %rsi
	movq %r9,%rdi
	imulq $16,%rdi
	call malloc
	popq %rsi
	popq %r9

	movq %rax,%r8		#the address of the first structure would be stored in %r8
	movq 16(%rsi),%r10	#getting string filename from (*argv+2) and put in %r10
	
	#calling fopen
	pushq %r8
	pushq %r9
	movq %r10,%rdi
	movq $access_type,%rsi
        call fopen
        popq %r9
	popq %r8
	movq %rax,%r11		#fptr put in %r11

	#calling readlines
	pushq %r11
	pushq %r8
        pushq %r9
        movq %r11,%rdi
	movq %r8,%rsi
	movq %r9,%rdx
	call readlines
        popq %r9
        popq %r8
	popq %r11

	#calling fclose
        pushq %r8
        pushq %r9
        movq %r11,%rdi
        call fclose
        popq %r9
        popq %r8

	#calling printlines
	pushq %r8
	movq %r8,%rdi
	movq %r9,%rsi
	call printlines
	popq %r8

	#freeall spaces that has been allocated
	movq %r8,%rdi
	call free
exit:
	leave
	ret
.size main, .-main

