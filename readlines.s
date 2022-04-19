#BY SUBMITTING THIS FILE TO CARMEN, I CERTIFY THAT I HAVE STRICTLY ADHERED TO THE TENURES OF THE OHIO STATE UNIVERSIT'S ACADEMIC INTEGRITY POLICY WITH RESPECT TO THIS ASSIGNMENT. 
#student name: Linran Wu

#This function will use fscanf to read X lines from fptr, one by one, and store the first value in structure member value1, the second value in structure member value2. Multiply the two values and store result in value3. 
.file "readlines.s" 
.section .rodata
format:
	.string "%d%d\n"
.globl readlines
	.type readlines, @function

.text 
readlines:
	pushq %rbp		#save caller’s rbp
	movq %rsp,%rbp		#set function’s frame pointer

	movq %rsi,%r8		#%r8 would now become the head pointer of the stucture for that we are going to use %rsi
	movq %rdx,%r10          #%r10 would be the counter of the following loop
	movq $0,%r11		#counter of the n th element of the structure
	#this loop runs X times so that this function reads in 2 values from one line do the calculation and put the result in the third value into the stucture
loop:
	decq %r10
	jl exit

	#calling fscanf		be aware that the file ptr is already in %rdi
	movq $format,%rsi
	movq $0,%rax
	leaq (%r8,%r11,8),%rdx
	leaq 4(%r8,%r11,8),%rcx
	pushq %r10
	pushq %r11
	pushq %r8
	pushq %rdi 
	call fscanf
	popq %rdi
	popq %r8
	popq %r11
	popq %r10

	#calc value3 by signed mul and put the long value in the right place in memory
	movq $0,%rdx
	movl (%r8,%r11,8),%eax
	movl 4(%r8,%r11,8),%ecx
	imull %ecx
	shlq $32, %rdx
	orq %rdx, %rax
	movq %rax,8(%r8,%r11,8)

	incq %r11		#increment the counter %r11 twice meaning that since one stucture takes up 16 bytes and the max value of the third parameter in (%r8,%r11,8) is 8, this is one way to count 16 bytes to get the address of the next stucture.
	incq %r11
	jmp loop
exit:
	leave	
	ret			 #return to caller’s code at return address
.size readlines, .-readlines

