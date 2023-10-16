.data
	temperatura: .asciiz "Digite a temperatura em Fahrenheit:"
	convertido: .asciiz "A temperatura em Celsius é "
	# F = 32 + ((9*C) / 5)
	# Fn = FN-1 + Fn-2
.text
	la $a0, temperatura
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	
	addi $s1, $s1, 9
	addi $s2, $s2, 5
	addi $s3, $s3, 32
	
	move $s0, $v0
	mul $s0, $s0, $s1 
	div $s0, $s2, $s0
	addi $s0, $s0, $s3
	move $a0, $s0
	
	li $v0, 1
	syscall