# Place all your code below the student_code label
student_code:

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
