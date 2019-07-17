abstract type opCode end

mutable struct opCodeSum <: opCode
    val :: String
end

mutable struct opCodeMul <: opCode
    val :: String
end

mutable struct opCodeSub <: opCode
    val :: String
end

mutable struct opCodeDiv <: opCode
    val :: String
end

mutable struct opCodeEq <: opCode
    val :: String
end

mutable struct opCodeLt <: opCode
    val :: String
end

mutable struct opCodeGt <: opCode
    val :: String
end

mutable struct opCodeLe <: opCode
    val :: String
end

mutable struct opCodeGe <: opCode
    val :: String
end

mutable struct opCodeAnd <: opCode
    val :: String
end

mutable struct opCodeOr <: opCode
    val :: String
end

mutable struct opCodeNot <: opCode
    val :: String
end

mutable struct opCodeAssign <: opCode
    val :: String
end

mutable struct opCodeLoop <: opCode
    val :: String
end

mutable struct opCodeCond <: opCode
    val :: String
end

mutable struct opCodeBind <: opCode
    val :: String
end

mutable struct opCodeRef <: opCode
    val :: String
end

mutable struct opCodeBlkDec <: opCode
    val :: String
end

mutable struct opCodeBlkCmd <: opCode
    val :: String
end

mutable struct opCodeUnfold <: opCode
    val :: String
end

op_sum = opCodeSum("#SUM")
op_mul = opCodeMul("#MUL")
op_sub = opCodeSub("#SUB")
op_div = opCodeDiv("#DIV")
op_eq = opCodeEq("#EQ")
op_lt = opCodeLt("#LT")
op_gt = opCodeGt("#GT")
op_le = opCodeLt("#LE")
op_ge = opCodeGe("#GE")
op_and = opCodeAnd("#AND")
op_or = opCodeOr("#OR")
op_not = opCodeNot("#NOT")
op_assign = opCodeAssign("#ASSIGN")
op_loop = opCodeLoop("#LOOP")
op_cond = opCodeCond("#COND")
op_bind = opCodeBind("#BIND")
op_ref = opCodeRef("#REF")
op_blk = opCodeBlkDec("#BLKDEC")
op_cmd = opCodeBlkCmd("#BLKCMD")
op_unfold = opCodeUnfold("#UNFOLD")

mutable struct Loc
	val :: Int
end
function calc(op, control_stack, value_stack, env, store, locations)
	if typeof(op) <: opCodeSum
		calc_sum(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeMul
		calc_mul(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeSub
		calc_sub(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeDiv
		calc_div(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeEq
		calc_eq(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeLt
		calc_lt(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeGt
		calc_gt(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeLe
		calc_le(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeGe
		calc_ge(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeAnd
		calc_and(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeOr
		calc_or(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeNot
		calc_not(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeAssign
		calc_assign(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeLoop
		calc_loop(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeCond
		calc_cond(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeBind
		calc_bind(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeRef
		calc_ref(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeBlkDec
		calc_blkdec(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeBlkCmd
		calc_blkcmd(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeCall
		calc_call(control_stack, value_stack, env, store, locations)
	elseif typeof(op) <: opCodeUnfold
		calc_unfold(control_stack, value_stack, env, store, locations)
	end

end

function get_value(id, env, store)
	value = env[id] #retorna o valor de uma variavel a partir de seu nome
	if typeof(value) <: Loc
		return store[value]
	else
		return value
	end
end


function calc_sum(control_stack, value_stack, env, store, locations) # chamada quando o opcode #SUM está no topo da pilha de controle
	value2 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 + value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_sub(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 - value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_mul(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 * value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_div(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 / value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_eq(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 === value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_lt(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 < value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_gt(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 > value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_le(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 <= value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_ge(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value1) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) <: String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) <: String
		value2 = get_value(value2, env, store)
		if typeof(value2) <: String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 >= value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_and(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)
	if value1 && value2
		result = true
	else
		result = false
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_or(control_stack, value_stack, env, store, locations)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)
	if value1 || value2
		result = true
	else
		result = false
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_not(control_stack, value_stack, env, store, locations)
	value = popfirst!(value_stack) # retira o elemento do topo da pilha de valores

	value_stack = push(value_stack, !value)  # coloca o resultado da negação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_assign(control_stack, value_stack, env, store, locations)
	value1 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value2 = popfirst!(value_stack)

	if typeof(value2) <: String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value2 = get_value(value2, env, store)
		
	end

	loc = env[value1]
	store[loc] = value2 # associa o novo valor ao nome da variavel

	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_loop(control_stack, value_stack, env, store, locations)
	condition = popfirst!(value_stack)
	loop = popfirst!(value_stack)
	values = loop.val
	second_value = values[2]
	control_stack = pop(control_stack)
	if condition
		control_stack = push(control_stack, loop)
		control_stack = push(control_stack, second_value)
	end
	automaton(control_stack, value_stack, env, store, locations)
end

function calc_cond(control_stack, value_stack, env, store, locations)
	condition = popfirst!(value_stack)
	command = popfirst!(value_stack)
	values = command.val

	control_stack = pop(control_stack)
	if condition
		control_stack = push(control_stack, values[2])
	else
		control_stack = push(control_stack, values[3])
	end
	automaton(control_stack, value_stack, env, store, locations)
end


function calc_bind(control_stack, value_stack, env, store, locations)
	loc_or_value = popfirst!(value_stack)
	identifier = popfirst!(value_stack)

	if length(value_stack) !== 0
		next = popfirst!(value_stack)
	end

	if (@isdefined next) && (typeof(next) <: Dict) # ja existe E'
		println("NAO E O PRIMEIRO BIND")
		if typeof(loc_or_value) <: Loc
			blk_locations = popfirst!(value_stack) # pega as locations do bloco
			push!(blk_locations, loc_or_value) # coloca a loc nova na lista de locations
			value_stack = push(value_stack, blk_locations) # coloca a lista de locations de volta
		end
		next[identifier] = loc_or_value
		value_stack = push(value_stack, next) # atualiza E' e coloca de volta na pilha de valores
	else # primeiro bind
		println("PRIMEIRO BIND")
		if @isdefined next
			value_stack = push(value_stack, next) # coloca de volta o valor retirado
		end
		println(typeof(loc_or_value))
		blk_locations = []
		if typeof(loc_or_value) <: Loc
			push!(blk_locations, loc_or_value)
		end

		value_stack = push(value_stack, blk_locations)
		new_env = Dict()
		new_env[identifier] = loc_or_value
		value_stack = push(value_stack, new_env)
	end

	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_ref(control_stack, value_stack, env, store, locations)
	value = popfirst!(value_stack)
	loc = Loc(length(store))
	store[loc] = value
	push(value_stack, loc)
	push(locations, loc)
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_blkdec(control_stack, value_stack, env, store, locations)
	println("TROCANDO OS ENVS")
	result_env = copy_dict(env)
	blk_env = popfirst!(value_stack)
	exists = false
	for (key_blk, value_blk) in blk_env
		for (key, value) in result_env
			if key === key_blk
				result_env[key] = blk_env[key_blk]
				exists = true
			end
		end
		if !exists
			result_env[key_blk] = value_blk
		else
			exists = false
		end
	end
	value_stack = push(value_stack, env)
	automaton(pop(control_stack), value_stack, result_env, store, locations)
end

function calc_blkcmd(control_stack, value_stack, env, store, locations)
	if length(value_stack) !== 0
		env = copy_dict(popfirst!(value_stack))
		locations = copy_array(popfirst!(value_stack))
	end
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function copy_dict(dict)
	new = Dict()
	for (key, value) in dict
		new[key] = value
	end
	return new
end

function copy_array(array)
	new =  Array{Any, 1}()
	for (value) in array
		new = push!(new, value)
	end
	return new
end


function calc_call(control_stack, value_stack, env, store, locations)
	op = popfirst!(control_stack)
	control_stack = push(control_stack, env[op.id].blk)

	formals = env[op.id].formals.val # pega um vetor de idseqs e ids
									 # ex: Any[Id("x"), IdSeq(Any[Id("y"), Id("a")])]
	i = op.n
	println(i)
	actuals = []
	while i > 0
		actuals = push!(actuals, popfirst!(value_stack)) # coloca o resultado das expressoes escolhidas num vetor
		i = i - 1
	end

	next = popfirst!(value_stack)
	if typeof(next) <: Dict
		next = matcher(formals, actuals, next)
		e = reclose(env, next)
		env[op.id] = e
	end
	value_stack = push(value_stack, next)
	#automaton(control_stack, value_stack, env, store, locations)
end

function reclose(current_env, fun_env)
	println("current_env = ", current_env, "\n\n\n")
	println("fun_env = ", fun_env, "\n\n\n")
	for (key, value) in current_env
		if typeof(value) <: Closure
			println("value_env = ", value.env, "\n\n\n")
	
			rec = Rec(value.formals, value.blk, value.env, current_env)
			println(rec)
			return rec
		elseif typeof(value) <: Rec
			new_rec = Rec(value.formals, value.blk, value.env, current_env)
		end
	end

	# if typeof(fun_env) <: Closure
	# 	rec = Rec(fun_env.formals, fun_env.blk, fun_env.env, current_env)
	# 	return rec
	# end
	return 0
end

function matcher(formals_array, actuals_array, env)
	i = 1
	while i <= length(actuals_array)
		if typeof(formals_array) <: Array
			env[formals_array[1].val] = actuals_array[i]
			formals_array = formals_array[2].val
		else
			env[formals_array] = actuals_array[i]
		end
		i = i + 1
	end
	return env
end

function calc_unfold(control_stack, value_stack, env, store, locations)
	closure = popfirst!(value_stack)
	id_fun = popfirst!(value_stack)
	rel = Dict(id_fun=>closure)
	unfold = Unfold(rel)
	println(unfold)
	value_stack = push(value_stack, unfold)
	# automaton(pop(control_stack), value_stack, env, store, locations)
end

