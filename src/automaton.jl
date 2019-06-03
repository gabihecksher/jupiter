
include("calc.jl")
include("lexer.jl")

function automaton(control_stack, value_stack, env, store)
	print_stacks(control_stack, value_stack, env, store)
	if length(control_stack) === 0
		if length(value_stack) === 1
			result = popfirst!(value_stack)
			print_stacks(control_stack, value_stack, env, store)
			println("Resultado: ",result)
		end
		print_variables(env,store)
		return 0
	else
		op = control_stack[1]
		println("op: ", op)
		println("typeof(op): ", typeof(op))
		if Array{Any,1} <: typeof(op)
			println("eh do tipo any")
			control_stack[1] = op[1]
			handle(popfirst!(control_stack), control_stack, value_stack, env, store)
		elseif typeof(op) === String && op[1] === '#'
			println("eh opcode")
			calc(op, control_stack, value_stack, env, store)
		else
			handle(popfirst!(control_stack), control_stack, value_stack, env, store)
		end
	end
end


function handle(op, control_stack, value_stack, env, store)
	if typeof(op) <: Eq
		handle_Eq(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Lt
		handle_Lt(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Gt
		handle_Gt(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Le
		handle_Le(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Ge
		handle_Ge(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Or
		handle_Or(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Id
		handle_Id(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Num
		handle_Num(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Sum
		handle_Sum(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Sub
		handle_Sub(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Mul
		handle_Mul(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Div
		handle_Div(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Boo
		handle_Boo(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Not
		handle_Not(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: And
		handle_And(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Loop
		handle_Loop(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: CSeq
		handle_CSeq(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Cond
		handle_Cond(op, control_stack, value_stack, env, store)
	elseif typeof(op) <: Assign
		handle_Assign(op, control_stack, value_stack, env, store)
	end
end


function print_stacks(control_stack, value_stack, env, store)
	println()
	println()
	println("######################")

	println()

	println("CONTROL PILE:")
	print_stack(control_stack)

	println()

	println("VALUE PILE:")
	print_stack(value_stack)

	println()

	println("ENV:")
	println(env)

	println()

	println("STORE:")
	println(store)

	println()

	println("######################")
	println()
	println()
end

function print_stack(stack)
	if length(stack) === 1
		println(stack[1])
	elseif length(stack) > 1
		println(stack[1])
		print_stack(stack[2:end])
	end
end

function push(stack, element)
    pushfirst!(stack, element)
	stack
end

function pop(stack)
    popfirst!(stack)
    stack
end


function print_variables(env, store)
	println("VARIÁVEIS:")
	tamanho = 0
	for (key, value) in env
		tamanho = tamanho+1
	end
	i = tamanho
	for (key, value) in env
		id = key
		value = store[i]
		println("$id = $value")
		i = i - 1
	end

end

function handle_Num(element, control_stack, value_stack, env, store)
    value_stack = push(value_stack, element.val) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store)
end

function handle_Boo(element, control_stack, value_stack, env, store)
	value_stack = push(value_stack, element.val) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store)
end

function handle_Id(element, control_stack, value_stack, env, store)
	value_stack = push(value_stack, element.val) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store)
end

function handle_Sum(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#SUM") #coloca o opcode de soma na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)

end

function handle_Sub(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#SUB") #coloca o opcode de soma na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)

end

function handle_Mul(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#MUL")  # coloca o opcode de multiplicação na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Div(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#DIV")  # coloca o opcode de divisão na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Eq(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#EQ")  # coloca o opcode de equidade na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Lt(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#LT")  # coloca o opcode de comparação do tipo "menor que" na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Le(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#LE")  # coloca o opcode de comparação do tipo "menor ou igual a" na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Gt(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#GT")  # coloca o opcode de comparação do tipo "maior que" na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Ge(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#GE")  # coloca o opcode de comparação do tipo "maior ou igual a" na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end


function handle_And(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#AND")  # coloca o opcode de "e" na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Or(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#OR")  # coloca o opcode de "ou" na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Assign(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#ASSIGN")  # coloca o opcode de atribuição na pilha de controle
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_CSeq(element, control_stack, value_stack, env, store)
	values = inside(element)
	operators = element.val

	control_stack = push(control_stack, operators[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operators[2])

	automaton(control_stack, value_stack, env, store)
end

function handle_Loop(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#LOOP")   # coloca o opcode de loop na pilha de controle
	operators = element.val
	control_stack = push(control_stack, operators[1])

	value_stack = push(value_stack, element)

	automaton(control_stack, value_stack, env, store)
end

function handle_Cond(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#COND")  # coloca o opcode de condição na pilha de controle
	values = inside(element)
	first_value = values[1:middle(values)]
	part_two = values[middle(values)+2:end]

 	second_value = values[middle(values)+2:middle(part_two)+middle(values)+1]
	third_value = values[middle(part_two)+middle(values)+3:end]


 	control_stack = push(control_stack, first_value)

 	value_stack = push(value_stack, element)

 	automaton(control_stack, value_stack, env, store)
end

function handle_Not(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#NOT") # coloca o opcode de negação na pilha de controle
	control_stack = push(control_stack, element.val)

	automaton(control_stack, value_stack, env, store)
end
