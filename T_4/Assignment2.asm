#Laboratory Exercise 4, Assignment 2
.text
	li $s0,0x12345678          # Load test value for these function
	andi $t0,$s0,0xff000000    # Extract the MSB of$s0
	sra $t0,$t0,24             # Shift right 24 bít
	andi $t1,$s0,0xffffff00    #Clear LSB of $s0 
	ori $t2,$s0,0x000000ff     #Set LSB of $s0(bits 7 to 0 are set to 1)
	andi $t3,$s0,0             #Clear $s0($s0=0, must use logical instructions)