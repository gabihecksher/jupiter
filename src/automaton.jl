include("calc.jl")
include("lexer.jl")

mutable struct opCodeCall <: opCode
	val :: String
	id :: String
	n :: Int64
end


mutable struct Closure
	formals :: IdSeq
	blk :: Blk
	env :: Dict
end


mutable struct Unfold
	relation :: Dict{SubString{String},Closure}
end


mutable struct Rec
	formals :: IdSeq
	blk :: Blk
	E :: Dict
	env :: Dict
end

function automaton(control_stack, value_stack, env, store, locations)
	print_stacks(control_stack, value_stack, env, store, locations)
	if length(control_stack) === 0
		if length(value_stack) === 1
			result = popfirst!(value_stack)
			print_stacks(control_stack, value_stack, env, store, locations)
			println("Resultado: ",result)
		end
		#print_variables(env,store)
		return 0
	else
		op = control_stack[1]
		if Array{Any,1} <: typeof(op)
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
	elseif typeof(op) <: Call
		handle_Call(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: Abs
		handle_Abs(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: ExpSeq
		handle_ExpSeq(op, control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: RBnd
		handle_RBnd(op, control_stack, value_stack, env, store, locations)
	end
end


function print_stacks(control_stack, value_stack, env, store, locations)
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

	println("LOCATIONS:")
	println(locations)

	println()

	println("######################")
	println()
	println()
end

function print_stack(stack)
	if length(stack) > 0
		if typeof(stack[1]) <: opCode
			if typeof(stack[1]) <: opCodeCall
				println(stack[1].val, "(", stack[1].id, ",", stack[1].n, ")")
			else
				println(stack[1].val)
			end
		else
			element_string = string(stack[1])
        	element_string = replace(element_string, "Any"=> "")
        	element_string = replace(element_string, "["=> "")
			element_string = replace(element_string, "]"=> "")
			element_string = replace(element_string, " "=> "")
			println(element_string)
		end
		if length(stack) > 1
			print_stack(stack[2:end])
		end
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
	value_stack = push(value_stack, String(element.val)) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_Sum(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_sum) #coloca o opcode de soma na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)

end

function handle_Sub(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_sub) #coloca o opcode de soma na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)

end

function handle_Mul(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_mul)  # coloca o opcode de multiplicação na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Div(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_div)  # coloca o opcode de divisão na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Eq(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_eq)  # coloca o opcode de equidade na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Lt(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_lt)  # coloca o opcode de comparação do tipo "menor que" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Le(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_le)  # coloca o opcode de comparação do tipo "menor ou igual a" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Gt(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_gt)  # coloca o opcode de comparação do tipo "maior que" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Ge(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_ge)  # coloca o opcode de comparação do tipo "maior ou igual a" na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_And(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_and)  # coloca o opcode de "e" na pilha de controle
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
	control_stack = push(control_stack, op_assign)  # coloca o opcode de atribuição na pilha de controle
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_CSeq(element, control_stack, value_stack, env, store, locations)
	operands = element.val

	control_stack = push(control_stack, operands[2])
	control_stack = push(control_stack, operands[1]) #coloca as expressões a serem somadas na pilha de controle


	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Loop(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_loop)   # coloca o opcode de loop na pilha de controle
	operands = element.val
	control_stack = push(control_stack, operands[1])

	value_stack = push(value_stack, element)

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Cond(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_cond)  # coloca o opcode de condição na pilha de controle
	operands = element.val

 	control_stack = push(control_stack, operands[1])

 	value_stack = push(value_stack, element)

 	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Not(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_not) # coloca o opcode de negação na pilha de controle
	control_stack = push(control_stack, element.val)

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Bind(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_bind)  # coloca o opcode de atribuição na pilha de controle
	operands = element.val

	value_stack = push(value_stack, operands[1].val) # coloca o id da variavel no topo da pilha de valores
	control_stack = push(control_stack, operands[2]) # coloca a expressao associada à variavel na pilha de controle

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Blk(element, control_stack, value_stack, env, store, locations)
	operands = element.val
	control_stack = push(control_stack, op_cmd)
	control_stack = push(control_stack, operands[2])

	control_stack = push(control_stack, op_blk)
	control_stack = push(control_stack, operands[1])

	automaton(control_stack, value_stack, env, store, locations)
end


function handle_Ref(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_ref)
	if typeof(element.val) <: Array{Any,1}
		control_stack = push(control_stack, element.val[1])
	else
		control_stack = push(control_stack, element.val)
	end

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

	control_stack = push(control_stack, operands[1]) 
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_IdSeq(element, control_stack, value_stack, env, store, locations)
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as ids na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function handle_ExpSeq(element, control_stack, value_stack, env, store, locations)
	operands = element.val

	control_stack = push(control_stack, operands[1]) #coloca as expressoes na pilha de controle
	control_stack = push(control_stack, operands[2])

	automaton(control_stack, value_stack, env, store, locations)
end

function count_exp(element) #recebe um ExpSeq e conta quantas exps tem nele
	if length(element.val) === 1
		return 1
	else
		return 1 + count_exp(element.val[2])
	end
end

function handle_Call(element, control_stack, value_stack, env, store, locations)
	operands = element.val
	id_function = operands[1]
	parameters = operands[2]

	num_parameters = count_exp(parameters)
	op_call = opCodeCall("#CALL", String(id_function.val), num_parameters)
	control_stack = push(control_stack, op_call)
	
	
	control_stack = push(control_stack, parameters)
	
	automaton(control_stack, value_stack, env, store, locations)
end

function handle_Abs(element, control_stack, value_stack, env, store, locations)
	operands = element.val
	formals = operands[1]
	blk = operands[2]

	closure = Closure(formals, blk, env)
	value_stack = push(value_stack, closure)
	automaton(control_stack, value_stack, env, store, locations)
end

function handle_RBnd(element, control_stack, value_stack, env, store, locations)
	control_stack = push(control_stack, op_bind)  # coloca o opcode de bind na pilha de controle
	control_stack = push(control_stack, op_unfold)  # coloca o opcode de bind na pilha de controle
	value_stack = push(value_stack, element.val[1].val)
	control_stack = push(control_stack, element.val[2])

	print_stacks(control_stack, value_stack, env, store, locations)
	
	# id_function = element.val[1]
	# formals = element.val[2].val[1]
	# blk = element.val[2].val[2]
	# closure = Closure(formals, blk, env)
	# relation = Dict(id_function=>closure)
	# unfolding = Unfold(relation)
	# println("unfold = ", unfolding)
	
	# value_stack = push(value_stack, unfo)
	automaton(control_stack, value_stack, env, store, locations)
end