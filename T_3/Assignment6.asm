# Laboratory Exercise 3, Assignment 6
.data
	A: .word 2, 3, 8, -15, 9, 4, -10
	message: .asciiz "Tri tuyet doi lon nhat la: "
.text
	addi $s0, $zero, 0	# max = 0
	la $a0, A
	lw $s1, 0($a0)		# A[0]
	addi $s2, $zero, 0	# i = 0
	addi $s3, $zero, 7	# n = 7
	
loop:	slt $t2, $s2, $s3	# i<n
	beq $t2, $zero, endloop	# i>=n branch to endloop
	add $t1,$s2,$s2         # $t1 = 2 * i
	add $t1,$t1,$t1         # $t1 = 4 * i
	add $a1, $a0, $t1	# a1 = a0 + 4
	lw $s4, 0($a1)		# s4 = A[i]
behon:
	bge $s4,$zero, lonhon	# s4>0 branch to lonhon
	sub $s4, $zero, $s4	# s4 = 0 - s4
	j lonhon
lonhon: 		
	slt $t4, $s0, $s4	# max < s4
	bne $t4, $zero, max	# max < s4 branch to max
	j reloop		# jump reloop
max: 	add $s0, $zero, $s4	# max = 0 + s4
	j reloop		# jump reloop
reloop:
 	addi $s2, $s2, 1	# i=i+1
	j loop			# jump loop
endloop:







	
	
	
	
	
	
	
	
	
	
	
	
	
	
