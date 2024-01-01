.data 
	message1:	.asciiz "NHAP SO NGUYEN N : "
	message2:	.asciiz " "
	message3:	.asciiz "ERROR: So nhap vao khong phai so nguyen duong\nVui long nhap lai\n"
	message4:	.asciiz "Cac so thoa man : "
.text
	li	$s0, 1			# n = 1
	li	$s2, 3			# $s2 = 3
	li	$s3, 5			# $s3 = 5
     
Nhap_n:	li	$v0, 4			# Thong bao nhap so nguyen N
	la	$a0, message1
	syscall
         
	li	$v0, 5			# Nhap so nguyen N
	syscall
         
	move	$s1, $v0		# $s1 = N
	
	slti  	$t2, $s1, 1		# if (n <= 0) => error else => Print1
	beq	$t2, $zero, Print1
	li	$v0, 4			# Bao loi va yeu cau nhap lai
	la	$a0, message3
	syscall
	j Nhap_n			# Nhap l?i N
	
Print1:	li	$v0,4			# Thong bao cac phan tu thoa man
	la	$a0,message4
	syscall
         
Loop:   slt	$t0, $s0, $s1		# if($s0 < $s1)  continue else exit
        beq	$t0, $zero, Exit
         
Chia_3: div	$s0, $s2           
	mfhi	$t1			# $t1 = n % 3
	beq	$t1, $zero, Print2	# if $t1 chia het cho 3 => print2
	
Chia_5: div	$s0, $s3
	mfhi	$t1			# $t1 = n % 5
	beq	$t1, $zero, Print2	# if $t1 chia het cho 3 => print2
	addi	$s0, $s0 ,1		# $s0++
	j Loop

Print2:	li	$v0, 1			# In ra so thoa man
        move	$a0, $s0
        syscall
        
	li	$v0,4			# In " "
	la	$a0,message2
	syscall
	
	addi	$s0, $s0 ,1		# n++
	j Loop				# Lap lai loop
	
Exit:	li	$v0, 10			# Exit
	syscall
