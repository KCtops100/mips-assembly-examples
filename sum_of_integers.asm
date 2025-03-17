.data
    	array: .word 3, 7, 2, 9, 5   # Array of 5 integers
    	msg_sum: .asciiz "Sum: "

.text
.globl main

main:
	# call function
    	la $a0, array	# load array base address
    	li $a1, 5	# load array size (number of elements)
    	jal compute_sum	# call function
    	
    	move $t0, $v0	# store sum into temporary variable $t0 to make sure it is not overriden

    	# print "Sum: "
    	li $v0, 4	# syscall for print string
    	la $a0, msg_sum	# passing in string parameter
    	syscall	# print message

    	# print sum
    	li $v0, 1	# syscall for print integer
    	move $a0, $t0	# passing in integer parameter
    	syscall	# print sum
    	
    	# exit
    	li $v0, 10	# syscall for terminate program
    	syscall	# terminate program

# Function: compute_sum(int *arr, int size)
# Returns sum of elements in $v0
# input - $a0 : *array
# input - $a1 : size
# output - $v0 : sum
compute_sum:
    	li $v0, 0  # sum = 0

    	loop:
        	beq $a1, $zero, done  # If size == 0, exit loop
		# otherwise, continue
        	lw $t0, 0($a0)  # Load current element
        	add $v0, $v0, $t0  # sum += arr[i]
        	addi $a0, $a0, 4  # Move to next element
        	subi $a1, $a1, 1  # Decrease size count
        	# addi $a1, $a1, -1	# alternative method
        	j loop	# another iteration

    	done:
        	jr $ra  # Return to caller
