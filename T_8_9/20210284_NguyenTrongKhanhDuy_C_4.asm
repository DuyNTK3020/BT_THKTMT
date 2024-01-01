.data
	string:		.space 500
	Message1:	.asciiz "Nhap xau ky tu: "
	Message2:	.asciiz "Ky tu dai nhat trong chuoi vua nhap la: "
	Message3:	.asciiz "ERROR: Khong duoc de trong. Vui long nhap lai\n"
	comma:		.asciiz ", "
	sqm:		.asciiz "'"
.text
	li	$t1, 0			# Khoi tao check = 0
NhapXau:	
	li	$v0, 4			# Thong bao nhap xau
	la	$a0, Message1
	syscall
	li	$v0, 8			# Nhap xau
	la	$a0, string
	li	$a1, 500
	syscall
	li	$t0, 0			# Khoi tao i cho Length
	
Length:	la	$a0, string
	add	$t2, $t0, $a0
	lb	$t2, 0($t2)		# string[i] = $t2
	beq	$t2, 10, EndLength	# if string[i] ='\n' => EndLength
	addi	$t0, $t0, 1 		# i++
	j	Length	

EndLength:
	add	$s0, $t0, $zero		# $s0 = strlen(string) 
	slti  	$t2, $s0, 1		# if (n <= 0) => error else => Print1
	beq	$t2, $zero, Longtest
	li	$v0, 4			# Bao loi va yeu cau nhap lai
	la	$a0, Message3
	syscall
	j	NhapXau
	
Longtest:
	li	$t3, 0			# Khoi tao count = 0
	li	$t4, 0			# Khoi tao longtest = 0
	li	$t0, -1			# Khoi tao i cho For
	
For:	addi 	$t0, $t0, 1		# i++
	blt	$s0, $t0, EndFor	# if strlen(string) < i => ket thuc vong lap
	
If:	la	$a0, string		
	add	$t2, $t0, $a0
	lb	$t2, 0($t2)		# Lay ra string[i]
	beq	$t2, 32, Else		# if string[i] != ' '
	beq	$t2, 10, Else		# or if string[i] != '\n'
	addi	$t3, $t3, 1		# t=> count ++ else => else
	j	For
Else:	blt	$t3, $t4, ResetCount	# Neu count > longtest && count != 0 thi longtest = count
	beq	$t3, 0, ResetCount
	add	$t4, $t3, $zero		
ResetCount:	
	li	$t3, 0			# count = 0
	j	For

EndFor:	li	$t0, -1			# Khoi tao i cho For1
	li	$t1, 0			# $t1 = dem = 0
	li	$t3, 0			# $t3 = z = 0
	li 	$v0, 4			# Thong bao in ket qua
	la	$a0, Message2
	syscall
	
For1:	addi	$t0, $t0, 1		# i++
	beq	$t0, $s0, Exit		# Kiem tra neu i = strlen(string) thi ket thu For1
	
If1:	la	$a0, string		
	add	$t2, $t0, $a0	
	lb	$t5, 0($t2)		# Lay ra string[i]
	lb	$t6, 1($t2)		# Lay ra string[i+1]
	beq	$t5, 32, Else4		# Kiem tra neu string[i] = ' ' thi thuc hien Else4
	addi	$t1, $t1, 1		# dem++
	
If2:	bne	$t1, $t4, For1		# Kiem tra neu dem = longtest thi kiem tra tiep lenh ben duoi, neu khong bang thi quay lai For1
	beq	$t6, 32, If3		# Kiem tra string[i+1] = ' ' thi nhay den If3
	beq	$t6, 10, If3		# Kiem tra string[i+1] = '\0' thi nhay den If3
	j	For1			# Neu cac dieu kien tren khong thoa man thi quay` lai For1
If3:	beq	$t3, 0, EndIf3		# Kiem tra neu z = 0 thi khong thuc hien lenh trong If3
	li	$v0, 4			# In dau ", "
	la	$a0, comma
	syscall	
EndIf3:	li	$v0, 4			# In dau nhay don
	la	$a0, sqm
	syscall
	
# In ket qua
	sub	$t7, $t0, $t1		# Khoi tao j = i - dem
For2:	addi	$t7, $t7, 1		# j++ => j = i-dem+1
	bgt	$t7, $t0, EndFor2	# Kiem tra neu j > i thi ket thuc For2
	la	$a0, string
	add	$a0, $t7, $a0
	lb	$a0, 0($a0)		# Lay ra string[j]
	li	$v0, 11			# In ra string[j]
	syscall
	j	For2		
EndFor2:	
	li	$v0, 4			# In dau nhay don 
	la	$a0, sqm
	syscall
	add	$t3, $t3, 1		# z++
	j	For1
	
Else4:	li	$t1, 0			# Dem = 0
	j	For1
Exit:	li	$v0, 10			# Exit
	syscall
