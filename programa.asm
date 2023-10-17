.data
	qualTemperaturaEmF: .asciiz "Digite a temperatura em Celsius:"
	convertido: .asciiz "A temperatura em Fahrenheit é "
	nove: .float 9
	trintaEdois: .float 32
	cinco: .float 5
	# F = 32 + ((9*C) / 5)
	# Fn = FN-1 + Fn-2
	
.text
	# Solicita a temperatura
	la $a0, qualTemperaturaEmF
	li $v0, 4
	syscall

	l.s $f3, nove
	l.s $f4, trintaEdois
	l.s $f5, cinco
	li $v0, 6
	syscall
	
	mul.s $f1, $f0, $f3 
	div.s $f2, $f1, $f5
	add.s $f1, $f2, $f4
	mov.s $f12, $f1
	
	li $v0, 2
	syscall
