.data
	A:		.space  400
	message1:	.asciiz "NHAP SO PHAN TU CHO MANG : "
	message2:	.asciiz "NHAP PHAN TU THU "
	message3:	.asciiz ": "
	message4:	.asciiz "TONG PHAN TU LE TRONG MANG LA : "
	message5:	.asciiz "\nTONG PHAN TU CHAN TRONG MANG LA : "
	message6:	.asciiz "ERROR: Phan tu trong mang phai >= 0\nVui long nhap lai\n"
.text 
Main:	la 	$s1, A			# Khoi tao mang A
	li 	$t3, 2			# $t3 = 2

Nhap_n:	li 	$v0, 4			# Thong bao nhap so phan tu cua mang
	la 	$a0, message1
	syscall
          
	li 	$v0, 5			# Nhap N
	syscall
          
	move	$s0, $v0		# $s0 = N
	li	$t0, 0			# $t0 = i
	
	slti  	$t5, $s0, 0		# if (N < 0) bao loi yeu cau nhap lai
	beq	$t5, $zero, Nhap_a
	li	$v0,4			# Thong bao loi
	la	$a0,message6
	syscall
	j Nhap_n			# Nhap lai n
	
Nhap_a:	ble	$s0,$t0,end		# ngay khi $s0 = $t0 => d?ng nh?p
	li 	$v0, 4			# thong bao nhap phan tu thu
	la 	$a0, message2
	syscall
          
	li 	$v0, 1			# "i "
	move 	$a0,$t0
	syscall
          
	li 	$v0, 4			# ": "
	la 	$a0, message3
	syscall
          
	li 	$v0, 5			# Nhap mot so nguyen
	syscall
          
	sll 	$t1,$t0,2		# $t1 = 4 * i
	add 	$t1,$s1,$t1		# $t1 = $s1 + 4 * i
	sw 	$v0,0($t1)		# $v0 = A[i]
                   
	addi 	$t0,$t0,1		# i++
	j Nhap_a
end:

sum:	li	$s2,0			# tong_le = 0
	li	$s3,0			# tong_chan = 0
	li	$t0,0			# i = 0
	lw 	$t2,0($s1)
	
loop:	ble	$s0,$t0,EndL		# dung khi i = N
	div	$t2, $t3		# A[i] / 2
	mfhi	$t4			# $t4 = a[i] % 2
	bne	$t4, $zero, le		# if ($s4 == 1) => tong_le
	add	$s3,$s3,$t2		# tong_chan += A[i] chan
	j tiep
	
le:	add 	$s2,$s2,$t2		#tong_le += A[i] le

tiep:	addi	$t0,$t0,1		# i++
	sll	$t1,$t0,2		# $t1 = 4 * i
	add	$t1,$s1,$t1		# $t1 = $s1 + 4 * i
	lw 	$t2,0($t1)		# $t2 = A[i]
	j 	loop
          
EndL:	li	$v0,4			# Thong bao tong le
	la	$a0,message4
	syscall
          
	li	$v0,1			# in tong_le
	move	$a0,$s2
	syscall
          
	li 	$v0,4			# Thong bao tong chan
	la	$a0,message5
	syscall
          
	li 	$v0,1			# in tong_chan
	move	$a0,$s3
	syscall
          
	li 	$v0,10			# Exit
	syscall