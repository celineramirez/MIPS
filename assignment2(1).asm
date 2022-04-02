#################################################################
# CDA3100 - Assignment 2			       		#
#						       		#
# DO NOT MODIFY any code above the STUDENT_CODE label. 		#
#################################################################
	.data
	.align 0
msg0:	.asciiz "Statistical Calculator!\n"
msg1:	.asciiz "-----------------------\n"
msg2:	.asciiz "Average: "
msg3:	.asciiz "Maximum: "
msg4:	.asciiz "Median:  "
msg5:	.asciiz "Minimum: "
msg6:	.asciiz "Sum:     "
msg7:	.asciiz "\n"
msg8:	.asciiz "Elapsed Time: "
		.align 2
array:	.word 91, 21, 10, 56, 35, 21, 99, 33, 13, 80, 79, 66, 52, 6, 4, 53, 67, 91, 67, 90
size:	.word 20
timer:	.word 0	# Used to calculate elapsed time of program execution
	.text
	.globl main
	# Display the floating-point (%double) value in register (%register) to the user
	.macro display_double (%register)
		li $v0, 3		# Prepare the system for output
		mov.d $f12, %register	# Set the integer to display
		syscall			# System displays the specified integer
	.end_macro
	
	# Display the %integer value to the user
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

	# Perform floating-point division %value1 / %value2
	# Result stored in register specified by %register
        .macro fp_div (%register, %value1, %value2)
 		mtc1.d %value1, $f28		# Copy integer %value1 to floating-point processor
		mtc1.d %value2, $f30		# Copy integer %value2 to floating-point processor
		cvt.d.w $f28, $f28		# Convert integer %value1 to double
		cvt.d.w $f30, $f30		# Convert integer %value2 to double
		div.d %register, $f28, $f30	# Divide %value1 by %value2 (%value1 / %value2)
	.end_macro				# Quotient stored in the specified register (%register)
	
	# Get start time for computing elapsed time
	.macro get_start_time
		get_current_time
		sw $a0, timer		# Store the start time (in milliseconds) in the timer memory
		li $v0, 0
	.end_macro
	
	# Compute elapsed time
	.macro compute_elapsed_time
		get_current_time
		lw $a1, timer		# Read the start time (in milliseconds) in the timer memory
		sub $a1, $a0, $a1	# Subtract the start time from the finish time
		display_string msg8	# Display the "Elapsed Time: " string
		display_integer $a1	# Display the computed elapsed time of program execution
		display_string msg7
	.end_macro
	
	# Request current time (in milliseconds) from OS
	.macro get_current_time
		li $v0, 30			# Prepare request the current time (in milliseconds) from OS
		syscall				# Submit the request to the OS
	.end_macro
	
main:
	get_start_time		# Used to compute elapsed time
	la $a0, array		# Store memory address of array in register $a0
	lw $a1, size		# Store value of size in register $a1
	jal getMax		# Call the getMax procedure
	add $s0, $v0, $zero	# Move maximum value to register $s0
	jal getMin		# Call the getMin procedure
	add $s1, $v0, $zero	# Move minimum value to register $s1
	jal calcSum		# Call the calcSum procedure
	add $s2, $v0, $zero	# Move sum value to register $s2
	jal calcAverage		# Call the calcAverage procedure (result is stored in floating-point register $f2
	jal sort		# Call the sort procedure
	jal calcMedian		# Call the calcMedian procedure (result is stored in floating-point register $f4
	add $a1, $s0, $zero	# Add maximum value to the argumetns for the displayStatistics procedure
	add $a2, $s1, $zero	# Add minimum value to the argumetns for the displayStatistics procedure
	add $a3, $s2, $zero	# Add sum value to the argumetns for the displayStatistics procedure
	jal displayStatistics	# Call the displayResults procedure
	compute_elapsed_time	# Used to compute elapsed time
	
exit:	li $v0, 10		# Prepare to terminate the program
	syscall			# Terminate the program
	
# Display the computed statistics
# $a1 - Maximum value in the array
# $a2 - Minimum value in the array
# $a3 - Sum of the values in the array
displayStatistics:
	display_string msg0
	display_string msg1
	display_string msg6
	display_integer	$a3	# Sum
	display_string msg7
	display_string msg5
	display_integer $a2	# Minimum
	display_string msg7
	display_string msg3
	display_integer $a1	# Maximum
	display_string msg7
	display_string msg2
	display_double $f2	# Average
	display_string msg7
extra_credit:
	display_string msg4
	display_double $f4	# Median
	display_string msg7
	jr $ra
#################################################################
# DO NOT MODIFY any code above the STUDENT_CODE label. 		#
#################################################################

# Place all your code in the procedures provided below the student_code label
student_code:

# Calculate the average of the values stored in the array
# $a0 - Memory address of the array
# $a1 - Size of the array (number of values)
# Result MUST be stored in floating-point register $f2
calcAverage:
	
	#fp_div $f2, $rs, $rt	# Perform floating-point division on registers $rs and $rt ($rs / $rt)
	jr $ra	# Return to calling procedure
	
################################################################################

# Calculate the median of the values stored in the array
# $a0 - Memory address of the array
# $a1 - Size of the array (number of values)
# Result MUST be stored in floating-point register $f4
calcMedian:

	#fp_div $f4, $rs, $rt	# Perform floating-point division on registers $rs and $rt ($rs / $rt)
	jr $ra			# Return to calling procedure
	
################################################################################

# Calculate the sum of the values stored in the array
# $a0 - Memory address of the array
# $a1 - Size of the array (number of values)
# Result MUST be stored in register $v0
calcSum:
	li $t3, 0 # x to increment
	la $a2, ($a0) # copy array address from a0 to a2
	loop:
	slt $t2, $t3, $a1 # x < size
	beq $t2, 0, sumVal # go to output sum
	lw $t4, 0($a2) # iterate through each index
	add $t6, $t6, $t4 # add values together, store in t6
	addi $a2, $a2, 4 # .word +4 bytes
	addi $t3, $t3, 1 # x++
	j loop
	sumVal:
	addi $v0, $t6, 0 # store sum in v0
	jr $ra	# Return to calling procedure
	
################################################################################

# Return the maximum value in the array
# $a0 - Memory address of the array
# $a1 - Size of the array (number of values)
# Result MUST be stored in register $v0
getMax:
	la $a2, ($a0) # copy array address from a0 to a2
	li $t3, 0 # x to increment
	lw $t1, 0($a2) # set 1st index to curr max val
	# for loop
	loopMax:
	slt $t2, $t3, $a1 # x < size
	beq $t2, 0, maxVal # if x >= size print max value
	lw $t4, ($a2) # iterate through array
	# if statement
	slt $t5, $t4, $t1 # array[x] < max
	beq $t5, 1, skipif # do not change max val
	addi $t3, $t3, 1 # x++
	lw $t1, ($a2) # max = array[x]
	addi $a2, $a2, 4 # move +4 bytes
	j loopMax
	
	skipif:
	addi $t3, $t3, 1
	addi $a2, $a2, 4 # move +4 bytes
	j loopMax
	
	maxVal:
	addi $v0, $t1, 0 # load max value into v0
	
	jr $ra	# Return to calling procedure
	
################################################################################

# Return the minimum value in the array
# $a0 - Memory address of the array
# $a1 - Size of the array (number of values)
# Result MUST be stored in register $v0
getMin:
	la $a2, ($a0) # copy array address from a0 to a2
	li $t3, 0 # x to increment
	lw $t1, 0($a2) # set 1st index to curr max val
	# for loop
	loopMaxB:
	slt $t2, $t3, $a1 # x < size
	beq $t2, 0, maxValB # if x >= size print max value
	lw $t4, ($a2) # iterate through array
	# if statement
	sgt $t5, $t4, $t1 # array[x] < max
	beq $t5, 1, skipifB # do not change max val
	addi $t3, $t3, 1 # x++
	lw $t1, ($a2) # max = array[x]
	addi $a2, $a2, 4 # move +4 bytes
	j loopMaxB
	
	skipifB:
	addi $t3, $t3, 1
	addi $a2, $a2, 4 # move +4 bytes
	j loopMaxB
	
	maxValB:
	addi $v0, $t1, 0 # load max value into v0
	jr $ra	# Return to calling procedure
	
################################################################################

# Perform the Selection Sort algorithm to sort the array
# $a0 - Memory address of the array
# $a1 - Size of the array (number of values)
sort:
	
	jr $ra	# Return to calling procedure

################################################################################

# Swap the values in the specified positions of the array
# $a0 - Memory address of the array
# $a1 - Index position of first value to swap
# $a2 - Index position of second value to swap
swap:
	
	jr $ra	# Return to calling procedure
