#Laboratory Exercise 3, Assignment 4
# i + j > m + n
.data
	x: .word 1
	y: .word 2
	z: .word 3

.text
	addi $s1,$zero,3          #Khoi tao i = 3
	addi $s2,$zero,4          #Khoi tao j = 4
	addi $s3,$zero,3          #Khoi tao m = 3
	addi $s4,$zero,2          #Khoi tao n = 2
	lw $t1,x                  #Lay gia tri cua x gan vao thanh ghi $t1
	lw $t2,y                  #Lay gia tri cua y gan vao thanh ghi $t2
	lw $t3,z                  #Lay gia tri cua z gan vao thanh ghi $t3

start:
	add     $t4, $s1, $s2     # $t4 = i + j
	add     $t5, $s3, $s4     # $t5 = m + n
	sgt     $t0,$t4,$t5       # i + j > m + n
	beq     $t0,$zero,else    # branch to else if i + j <= m + n
	addi    $t1,$t1,1         # then part: x = x + 1
	addi    $t3,$zero,1       # z = 1
	j       endif             
else:
	addi    $t2,$t2,-1        # begin else part: y = y - 1
	add     $t3,$t3,$t3       # z = 2 * z
endif:
