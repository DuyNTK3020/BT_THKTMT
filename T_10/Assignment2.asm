.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai.
.eqv SEVENSEG_RIGHT 0xFFFF0010 	# Dia chi cua den led 7 doan phai
.data
	nhapso:	.asciiz "Nhap so nguyen n = "

.text
main:
	li	$v0,4
	la	$a0,nhapso
	syscall
	li	$v0, 5
	syscall
	add	$s1, $v0, $zero	# n = $s1
	div	$s2, $s1, 10
	mfhi	$t1		# so hang don vi
	div	$s3, $s2, 10
	mfhi	$t2		# so hang chuc
	addi	$s4, $zero, -1	# khoi tao check = -1
	add	$t3, $zero, $t2 # $t3 = so hang chuc
Check_so:
So_0:	bne	$t3, 0, So_1
	li	$a0, 0x3F
	j	in_so
So_1:	bne	$t3, 1, So_2
	li	$a0, 0x06
	j	in_so
So_2:	bne	$t3, 2, So_3
	li	$a0, 0x5B
	j	in_so
So_3:	bne	$t3, 3, So_4
	li	$a0, 0x4F
	j	in_so
So_4:	bne	$t3, 4, So_5
	li	$a0, 0x66
	j	in_so
So_5:	bne	$t3, 5, So_6
	li	$a0, 0x6D
	j	in_so
So_6:	bne	$t3, 6, So_7
	li	$a0, 0x7D
	j	in_so
So_7:	bne	$t3, 7, So_8
	li	$a0, 0x07
	j	in_so
So_8:	bne	$t3, 8, So_9
	li	$a0, 0x7F
	j	in_so
So_9:	bne	$t3, 9, exit
	li	$a0, 0x6F
in_so:	
	beq	$s4, $zero, in_so_don_vi# if check = -1 in so hang chuc
					# if check = 0 in so hang don vi
in_so_chuc:	
	jal 	SHOW_7SEG_LEFT 	# show
	nop
	addi	$s4, $s4, 1
	add	$t3, $zero, $t1 # $t3 = so hang don vi
	j Check_so

in_so_don_vi:
	jal 	SHOW_7SEG_RIGHT # show 
	nop
exit: 	li 	$v0, 10
	syscall
endmain:

SHOW_7SEG_LEFT: 
	li 	$t0, SEVENSEG_LEFT # assign port's address
	sb 	$a0, 0($t0) 	# assign new value 
	nop
	jr 	$ra
	nop
SHOW_7SEG_RIGHT: 
	li 	$t0, SEVENSEG_RIGHT # assign port's address
	sb 	$a0, 0($t0) 	# assign new value
	nop
	jr 	$ra
	nop
