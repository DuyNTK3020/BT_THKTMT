#Laboratory Exercise 3, Home Assignment 4
#i < j
.data
	x: .word 1
	y: .word 2
	z: .word 3

.text
	addi $s1,$zero,2          #Khoi tao i = 2
	addi $s2,$zero,3          #Khoi tao j = 3
	lw $t1,x                  #Lay gia tri cua x gan vao thanh ghi $t1
	lw $t2,y                  #Lay gia tri cua y gan vao thanh ghi $t2
	lw $t3,z                  #Lay gia tri cua z gan vao thanh ghi $t3

start:
	slt     $t0,$s1, $s2      # i < j
	beq     $t0,$zero,else    # branch to else if i >= j
	addi    $t1,$t1,1         # then part: x = x + 1
	addi    $t3,$zero,1       # z = 1
	j       endif             
else:
	addi    $t2,$t2,-1        # begin else part: y = y - 1
	add     $t3,$t3,$t3       # z = 2 * z
endif:
