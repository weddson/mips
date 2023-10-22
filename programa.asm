.data
	# Menu
	escolha: .asciiz "1 - Fahrenheit -> Celsius \n2 - Fibonnacci \n3 - En�simo par \n4 - Sair \n"
	
	# Fahrenheit -> Celcius
	qualTemperaturaEmF: .asciiz "Digite a temperatura em Fahrenheit: "
	convertido: .asciiz "A temperatura em Celsius � "
	nove: .float 9
	trintaEdois: .float 32
	cinco: .float 5
	saiu: .asciiz "Voc� saiu do programa."
	
	# Others
	newline: .asciiz "\n"
	
	# En�simo Par
	qualpar: .asciiz "Qual en�simo par voc� quer saber?"
	opar: .asciiz "O seu en�simo n�mero par � o: "
	
.text

start:
	# --------- MENU ----------
	la $a0, escolha
	li $v0, 4
	syscall
	
	# Recebe a escolha do usu�rio
	li $v0, 5
	syscall
	
	# Armazena a escolha do usu�rio no t1
	move $t1, $v0
	
	# Vai at� a escolha do usu�rio
	beq $t1, 1, ftoc
	beq $t1, 2, fibonnaci
	beq $t1, 3, enesimo
	beq $t1, 4, sair
	
	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall
	
ftoc:
	# --------- Fahrenheit -> Celsius ----------
	# Opera��o - C = (F-32)/1,8
	
	# Solicita a temperatura
	la $a0, qualTemperaturaEmF
	li $v0, 4
	syscall
	
	# Carrega os valores para float
	l.s $f3, nove
	l.s $f4, trintaEdois
	l.s $f5, cinco
	li $v0, 6
	syscall
	
	# Executa a opera��o
	div.s $f3, $f3, $f5
	sub.s $f1, $f0, $f4
	div.s $f1, $f1, $f3 
	
	# Move o resultado da opera��o para ser printada
	mov.s $f12, $f1
	
	# Printa o valor
	li $v0, 2
	syscall
	
	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall
	
	# Volta para o menu
	j start
	
fibonnaci:
	# --------- Fibonnaci ----------
	# Fn = FN-1 + Fn-2
	
	la $a0, saiu
	li $v0, 4
	syscall
	
	
	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall
	
	# Volta para o menu
	j start
	
enesimo:
	# --------- enesimo ----------
	
	# inicio
	la $a0, qualpar
	li $v0, 4
	syscall
	
	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall

	# Pede um inteiro para o usu�rio
	li $v0, 5
	syscall

	# Faz o c�lculo (en�simo= 2N)
	mul $a2, $v0, 2
	
	# Printa o texto 
	la $a0, opar
	li $v0, 4
	syscall	
	
	# Printa o en�simo n�mero
	move $a0, $a2	
	li $v0, 1 
	syscall
	
	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall
	
	# Volta para o menu
	j start
	
sair:
	la $a0, saiu
	li $v0, 4
	syscall
	
	# --------- Sair ----------
	li   $v0, 10          # Finaliza o programa
	syscall               # Exit!
