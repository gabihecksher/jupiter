include("calc.jl")
include("lexer.jl")

function automaton(control_stack, value_stack, env, store, locations)
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
			handle(popfirst!(control_stack), control_stack, value_stack, env, store, locations)
		elseif typeof(op) <: opCode
			calc(op, control_stack, value_stack, env, store, locations)
		else
			handle(popfirst!(control_stack), control_stack, value_stack, env, store, locations)
		end
	end
end


function handle(op, control_stack, value_stack, env, store, locations)
	if typeof(op) <: Eq
		handle_Eq(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Lt
		handle_Lt(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Gt
		handle_Gt(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Le
		handle_Le(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Ge
		handle_Ge(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Or
		handle_Or(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Id
		handle_Id(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Num
		handle_Num(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Sum
		handle_Sum(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Sub
		handle_Sub(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Mul
		handle_Mul(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Div
		handle_Div(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Boo
		handle_Boo(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Not
		handle_Not(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: And
		handle_And(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Loop
		handle_Loop(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: CSeq
		handle_CSeq(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Cond
		handle_Cond(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Assign
		handle_Assign(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Blk
		handle_Blk(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Ref
		handle_Ref(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: DeRef
		handle_DeRef(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: ValRef
		handle_ValRef(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Bind
		handle_Bind(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: DSeq
		handle_DSeq(op, control_stack, value_stack, env, store, locations)
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

function handle_Num(element, control_stack, value_stack, env, store, locations)
    value_stack = push(value_stack, element.val) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Boo(element, control_stack, value_stack, env, store, locations)
	value_stack = push(value_stack, element.val) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Id(element, control_stack, value_stack, env, store, locations)
	value_stack = push(value_stack, element.val) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_Sum(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_sum.val) #coloca o opcode de soma na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)

end

function handle_Sub(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_sub.val) #coloca o opcode de soma na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)

end

function handle_Mul(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_mul.val)  # coloca o opcode de multiplicação na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Div(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_div.val)  # coloca o opcode de divisão na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Eq(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_eq.val)  # coloca o opcode de equidade na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Lt(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_lt.val)  # coloca o opcode de comparação do tipo "menor que" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Le(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_le.val)  # coloca o opcode de comparação do tipo "menor ou igual a" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Gt(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_gt.val)  # coloca o opcode de comparação do tipo "maior que" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Ge(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_ge.val)  # coloca o opcode de comparação do tipo "maior ou igual a" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_And(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_and.val)  # coloca o opcode de "e" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Or(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_or.val)  # coloca o opcode de "ou" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Assign(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_assign.val)  # coloca o opcode de atribuição na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_CSeq(element, control_stack, value_stack, env, store, locations)
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Loop(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_loop.val)   # coloca o opcode de loop na pilha de controle
	operands = element.val
	control_stack = push(control_stack, operands[1])

	value_stack = push(value_stack, element)

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Cond(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_cond.val)  # coloca o opcode de condição na pilha de controle
	operands = element.val

 	control_stack = push(control_stack, operands[1])

 	value_stack = push(value_stack, element)

 	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Not(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_not.val) # coloca o opcode de negação na pilha de controle
	control_stack = push(control_stack, element.val)

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Bind(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_bind.val)  # coloca o opcode de atribuição na pilha de controle
	operands = element.val

	value_stack = push(value_stack, operands[1].val) # coloca o id da variavel no topo da pilha de valores
	control_stack = push(control_stack, operands[2]) # coloca a expressao associada à variavel na pilha de controle

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Blk(element, control_stack, value_stack, env, store, locations)
	operands = element.val
	control_stack = push(control_stack, op_cmd.val)
	control_stack = push(control_stack, operands[2])

	control_stack = push(control_stack, op_blk.val)
	control_stack = push(control_stack, operands[1])

	value_stack = push(value_stack, locations)

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_Ref(element, control_stack, value_stack, env, store, locations)
<<<<<<< HEAD
	control_stack = push(control_stack, op_ref.val)
	control_stack = push(control_stack, element.val)
=======
	control_stack = push(control_stack, "#REF")
	if typeof(element.val) <: Array{Any,1}
		control_stack = push(control_stack, element.val[1])
	else
		control_stack = push(control_stack, element.val)
	end
>>>>>>> b4a79f16938519e36ecfc7776ad8cc69b5bf8036

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_DeRef(element, control_stack, value_stack, env, store, locations)
	operand = element.val[1]
	id = operand.val # pega o identificador da variavel
	value_stack = push(value_stack, store[store[env[id]]]) # coloca a location associada a variavel na pilha de valores
	automaton(control_stack, value_stack, env, store, locations)
end

function handle_ValRef(element, control_stack, value_stack, env, store, locations)
	operand = element.val[1]
	id = operand.val # pega o identificador da variavel
	value_stack = push(value_stack, env[id]) # pega o valor apontado por um ponteiro
	automaton(control_stack, value_stack, env, store, locations)
	#ex x := &y  ValRef(Id(x))
	#ex env = [x->loc2, y->loc3] store = [loc2->loc3, loc3->8]
	#nesse caso receberia x e retornaria 8
end

function handle_DSeq(element, control_stack, value_stack, env, store, locations)
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end
