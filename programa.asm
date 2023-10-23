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
	termopar: .asciiz "Digite o valor de n para calcular o en�simo termo par: "
	resultadotermopar: .asciiz "O en�simo termo par �: "
	entrada_invalida_msg: .asciiz "Entrada inv�lida. O n�mero deve ser maior que zero."
	
	# Fibonacci
	entradaFibonacci:     .asciiz "Digite o valor de N: "
	resultadoFibonacci:     .asciiz "O en�simo termo da sequ�ncia de Fibonacci �: "
.text

menu:
	# Reseta vari�veis
	
	move $t0, $zero     # Move o valor zero para $t1
	move $t1, $zero     # Move o valor zero para $t1
	move $t2, $zero     # Move o valor zero para $t1
	move $t3, $zero     # Move o valor zero para $t1
	move $t4, $zero     # Move o valor zero para $t1
		
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
	j menu
	
fibonnaci:
	# Imprimir o prompt para o usu�rio
	la $a0, entradaFibonacci
	li $v0, 4
	syscall

	# Ler o valor de N do usu�rio
	li $v0, 5
	syscall
	
	# Valida��o de entrada
	bltz $v0, entrada_invalida # Se $v0 for menor que zero, v� para entrada_invalida
	
	move $t0, $v0   # $t0 cont�m N

	# Inicializar os primeiros termos da sequ�ncia de Fibonacci
	li $t1, 1    # Primeiro termo (F0)
	li $t2, 1    # Segundo termo (F1)
	li $t3, 2    # Inicializador para o loop (come�a em 2)
	
	fibonacci_loop:
		# Verificar se o valor de N � 0 ou 1
		beq $t0, $zero, entrada_invalida
		beq $t0, $t3, saidaFibonacci
		beq $t0, 1, saidaFibonacci

		# Calcular o pr�ximo termo da sequ�ncia
		add $t4, $t1, $t2  # $t4 = F(n-1) + F(n-2)
		move $t1, $t2      # $t1 = F(n-1)
		move $t2, $t4      # $t2 = F(n-2)

		# Incrementar o contador e verificar o final do loop
		addi $t3, $t3, 1
		j fibonacci_loop
		
	saidaFibonacci:
	# Imprimir o resultado
	li $v0, 4
	la $a0, resultadoFibonacci
	syscall

	# Imprimir o en�simo termo da sequ�ncia
	move $a0, $t2
	li $v0, 1
	syscall

	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall
	
	j menu
	
enesimo:
	# Imprime a entrada sobre o en�simo termo par
	li $v0, 4           # Carrega o c�digo 4 em $v0 para imprimir uma string
	la $a0, termopar    # Carrega o endere�o de termopar em $a0
	syscall             # Chama o sistema para imprimir a mensagem

	# Ler o n�mero
	li $v0, 5           # Carrega o c�digo 5 em $v0 para ler um inteiro
	syscall             # Realiza a chamada do sistema para ler o n�mero

	# Valida��o de entrada
	bltz $v0, entrada_invalida # Se $v0 for menor que zero, v� para entrada_invalida

	# Reinicia a vari�vel $t1 para 0
	move $t1, $zero     # Move o valor zero para $t1

	# C�lculo do en�simo termo par
	move $t0, $v0       # Move o valor lido para $t0
	addi $t1, $t1, 2    # Adiciona 2 em $t1
	mul $t2, $t1, $t0   # Multiplica o valor de $t1 pelo valor de $t0 e armazena em $t2

	# Imprime mensagem sobre qual � o en�simo termo par
	li $v0, 4           # Carrega o c�digo 4 em $v0 para imprimir uma string
	la $a0, resultadotermopar  # Carrega o endere�o de resultadotermopar em $a0
	syscall             # Chama o sistema para imprimir a mensagem

	# Imprime qual � o en�simo termo par
	li $v0, 1           # Carrega o c�digo 1 em $v0 para imprimir um inteiro
	move $a0, $t2       # Move o valor armazenado em $t2 para $a0
	syscall             # Chama o sistema para imprimir o valor
	
	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall

	j menu        # Pula para o fim do programa

entrada_invalida:

	# Tratar entrada inv�lida
	li $v0, 4           # Carrega o c�digo 4 em $v0 para imprimir uma string
	la $a0, entrada_invalida_msg # Carrega o endere�o de entrada_invalida_msg em $a0
	syscall             # Chama o sistema para imprimir a mensagem
	
	#Pula linha
	la $a0, newline
	li $v0, 4
	syscall
	
	j menu        # Pula para o fim do programa
	
sair:
	la $a0, saiu
	li $v0, 4
	syscall
	
	# --------- Sair ----------
	li   $v0, 10          # Finaliza o programa
	syscall               # Exit!
