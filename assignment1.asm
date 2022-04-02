#################################################################
# CDA3100 - Assignment 1			       		#
#						       		#
# The following code is provided by the professor.     		#
# DO NOT MODIFY any code above the STUDENT_CODE label. 		#
#						       		#
# The professor will not troubleshoot any changes to this code. #
#################################################################

	.data
	.align 0

	# Define strings used in each of the printf statements
msg1:	.asciiz "Welcome to Prime Tester\n\n"
msg2:	.asciiz "Enter a number between 0 and 100: "
msg3:	.asciiz "Error: Invalid input for Prime Tester\n"
msg4:	.asciiz "The entered number is prime\n"
msg5:	.asciiz "The entered number is not prime\n"
ec_msg:	.asciiz " is prime\n" 		# Reserved for use in extra credit

	.align 2	
	.text
	.globl main

	# The following macros are provided to simplify the program code
	# A macro can be thought of as a cross between a function and a constant
	# The assembler will copy the macro's code to each use in the program code
	
	# Display the %integer to the user
	# Reserved for extra credit
	.macro display_integer (%integer)
		li $v0, 1			# Prepare the system for output
		add $a0, $zero, %integer	# Set the integer to display
		syscall				# System displays the specified integer
	.end_macro
	
	# Display the %string to the user
	.macro display_string (%string)
		li $v0, 4		# Prepare the system for output
		la $a0, %string		# Set the string to display
		syscall			# System displays the specified string
	.end_macro
	
	# Compute the square root of the %value
	# Result stored in the floating-point register $f2
	.macro calc_sqrt (%value)
		mtc1.d %value, $f2	# Copy integer %value to floating-point processor
		cvt.d.w $f2, $f2	# Convert integer %value to double
		sqrt.d $f2, $f2		# Calculate the square root of the %value
	.end_macro 
	
	# Determine if the %value is less-than or equal-to the current square root value in register $f2
	# Result stored in the register $v1
	.macro slt_sqrt (%value)
		mtc1.d %value, $f4	# Copy integer %value to floating-point processor
		cvt.d.w $f4, $f4	# Convert integer %value to double
		c.lt.d $f4, $f2		# Test if %value is less-than square root
		bc1t less_than_or_equal	# If less-than, go to less_than_or_equal label
		c.eq.d $f4, $f2		# Test if %value is equal-to square root
		bc1t less_than_or_equal	# If equal-to, go to less_than_or_equal label
		li $v1, 0		# Store a 0 in register $v1 to indicate greater-than condition
		j end_macro		# Go to the end_macro label
less_than_or_equal: 	
		li $v1, 1		# Store a 1 in register $v1 to indicate less-than or equal-to condition
end_macro: 
	.end_macro

main:
	# This series of instructions
	# 1. Displays the welcome message
	# 2. Displays the input prompt
	# 3. Reads input from the user
	display_string msg1	# Display welcome message
	display_string msg2	# Display input prompt
	li $v0, 5		# Prepare the system for keyboard input
	syscall			# System reads user input from keyboard
	move $a1, $v0		# Store the user input in register $a0
	j student_code 		# Go to the student_code label

error:	
	display_string msg3	# Display error message
	j exit
isprime:
	display_string msg4	# Display is prime message
	j exit
notprime:
	display_string msg5	# Display not prime message
exit:
	li $v0, 10	# Prepare to terminate the program
	syscall		# Terminate the program
	
#################################################################
# The code above is provided by the professor.     		#
# DO NOT MODIFY any code above the STUDENT_CODE label. 		#
#						       		#
# The professor will not troubleshoot any changes to this code. #
#################################################################

# Place all your code below the student_code label
student_code:
# Celine Ramirez (N01442188)
# CDA 3100 - Project 1
# Version (3/4/2022)


# First if statement to check input validity
li $t3, 100 # store 100 in register for comparison
slt $t0, $a1, $zero # test if less than 0
sgt $t1, $a1, 100 # test if greater than 100
or $t2, $t0, $t1 # compare both statements to see if inner statement is true (1) or false (0)
beq $t2, $zero, else # if statement is false, skip to else
display_string msg3 # if statement is true, display error
j exit # exit the program after error

else:
li $t2, 2 # store 2 in register for comparison
slt $t3, $a1, $t2 # check if input value is less than 2, 2nd if statement
beq $t3, $zero, elseif #if statement is false go to elseif
j notprime # if less than 2, number is not prime

elseif:
div $a1, $t2 # division operation
mfhi $t0 # remainder
beq $t0, $zero, check_two # check first condition, if true, jump to check second condition
bne $t0, $zero, continue #if first condition is false, continue program, and is already evaluated to false
# if input%2==0 and input !=2, input is not prime, exit program

check_two:
bne $a1, $t2, notprime # check second condition, if true, exit, both conditions are true
bne $a1, $t2, continue # if second condition is false, and has evaluated to false, continue program

continue: #continue the program, execute for loop segment
li $t3, 3
calc_sqrt $a1 # sqrt(input) = $f2
j for

for:
slt_sqrt $t3 # check if x <= sqrt(input) = $v1
#sle $t5, $t3, $v1 # check if x <= sqrt(input), if this condition manages to reach false, the number is prime
beq $v1, $zero, isprime # jump to isprime
add $t3, $t3, $t2 # x+=2

div $t4, $a1, $t3 # input / 2
mfhi $t4 # remainder
bne $t4, $zero, notprime #if divisible by 2, not prime
j for # loop








  

 





