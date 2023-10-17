.data
	escolha: .asciiz "1 - Fahrenheit -> Celsius \n 2 - Fibonnacci \n 3 - Enésimo par \n 4 - Sair \n"
	qualTemperaturaEmF: .asciiz "Digite a temperatura em Fahrenheit: "
	convertido: .asciiz "A temperatura em Celsius é "
	nove: .float 9
	trintaEdois: .float 32
	cinco: .float 5
	saiu: .asciiz "Você saiu do programa."
	newline: .asciiz "\n"
	
.text
start:
	# --------- MENU ----------
	la $a0, escolha
	li $v0, 4
	syscall
	
	# Recebe a escolha do usuário
	li $v0, 5
	syscall
	
	# Armazena a escolha do usuário no t1
	move $t1, $v0
	
	# Vai até a escolha do usuário
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
	# Operação - C = (F-32)/1,8
	
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
	
	# Executa a operação
	div.s $f3, $f3, $f5
	sub.s $f1, $f0, $f4
	div.s $f1, $f1, $f3 
	
	# Move o resultado da operação para ser printada
	mov.s $f12, $f1
	
	# Printa o valor
	li $v0, 2
	syscall
	
	j start
fibonnaci:
	# --------- Fibonnaci ----------
	# Fn = FN-1 + Fn-2
	
	la $a0, saiu
	li $v0, 4
	syscall
	
	# Volta para o menu
	j start
enesimo:
	# --------- enesimo ----------
	
	la $a0, saiu
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