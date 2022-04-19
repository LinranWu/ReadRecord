#BY SUBMITTING THIS FILE TO CARMEN, I CERTIFY THAT I HAVE STRICTLY ADHERED TO THE TENURES OF THE OHIO STATE UNIVERSIT'S ACADEMIC INTEGRITY POLICY WITH RESPECT TO THIS ASSIGNMENT.
#student name: Linran Wu

#This function will use printf() to print out all values within the structure array in this format: value1 * value2 = value3
.file "printlines.s"
.section .rodata
printf_line:
	.string "%d * %d = %ld\n"
.globl printlines
        .type printlines, @function

.text
printlines:
        pushq %rbp              #save caller’s rbp
        movq %rsp,%rbp          #set function’s frame pointer

	movq %rsi,%r10		#%r10 would be the counter of the following loop
	movq %rdi,%r8		#%r8 would now become the head pointer of the stucture for that we are going to use %rdi
	movq $0,%r11            #counter of the n th element of the structure
        #this loop runs X times so that this function prints out the 3 values in each structure
loop:	
	decq %r10
	jl exit
	#calling printf 
	movslq (%r8,%r11,8),%rsi
	movslq 4(%r8,%r11,8),%rdx
	movq 8(%r8,%r11,8),%rcx
	movq $printf_line,%rdi
	movq $0,%rax
	pushq %r11
	pushq %r10
	pushq %r8
	call printf
	popq %r8
	popq %r10
	popq %r11

	incq %r11		#increment the counter %r11 twice meaning that since one stucture takes up 16 bytes and the max value of the third parameter in (%r8,%r11,8) is 8, this is one way to count 16 bytes to get the address of the next stucture.
	incq %r11
	jmp loop
exit:
        leave
        ret                      #return to caller’s code at return address
.size printlines, .-printlines

