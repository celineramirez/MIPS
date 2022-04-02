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
