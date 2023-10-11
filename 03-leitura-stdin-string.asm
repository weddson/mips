

.data
	prompt_string: .asciiz "Digite uma string: "
	resultado: .asciiz "Valor lido = "
	new_line:  .asciiz "\n"
	buffer: .space 10

.text

	la    $a0, prompt_string        # Carregamento do argumento
 	li    $v0, 4           # Definicao da funcao print 
	syscall               # Chamada da funcao
	
	la    $a0, buffer
	li    $a1, 10
	li    $v0, 8      #Carregamento da funcao read_string
	syscall
	
	la    $a0, resultado        # Carregamento do argumento
 	li    $v0, 4           # Definicao da funcao print 
	syscall               # Chamada da funcao
	
	la  $a0, buffer     #Carrega o argumento
	li    $v0, 4      #Carrega a funcao de impressao de string
	syscall
	
	la    $a0, new_line        # Carregamento do argumento
 	li    $v0, 4           # Definicao da funcao print 
	syscall               # Chamada da funcao
	
	li   $v0, 10          # system call for exit
	syscall               # Exit!
