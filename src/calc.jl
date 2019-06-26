function calc(op, control_stack, value_stack, env, store, locations)
	if op === "#SUM"
		calc_sum(control_stack, value_stack, env, store, locations)
	elseif op === "#MUL"
		calc_mul(control_stack, value_stack, env, store, locations)
	elseif op === "#SUB"
		calc_sub(control_stack, value_stack, env, store, locations)
	elseif op === "#DIV"
		calc_div(control_stack, value_stack, env, store, locations)
	elseif op === "#EQ"
		calc_eq(control_stack, value_stack, env, store, locations)
	elseif op === "#LT"
		calc_lt(control_stack, value_stack, env, store, locations)
	elseif op === "#GT"
		calc_gt(control_stack, value_stack, env, store, locations)
	elseif op === "#LE"
		calc_le(control_stack, value_stack, env, store, locations)
	elseif op === "#GE"
		calc_ge(control_stack, value_stack, env, store, locations)
	elseif op === "#AND"
		calc_and(control_stack, value_stack, env, store, locations)
	elseif op === "#OR"
		calc_or(control_stack, value_stack, env, store, locations)
	elseif op === "#NOT"
		calc_not(control_stack, value_stack, env, store, locations)
	elseif op === "#ASSIGN"
		calc_assign(control_stack, value_stack, env, store, locations)
	elseif op === "#LOOP"
		calc_loop(control_stack, value_stack, env, store, locations)
	elseif op === "#COND"
		calc_cond(control_stack, value_stack, env, store, locations)
	elseif op === "#BIND"
		calc_bind(control_stack, value_stack, env, store, locations)
	elseif op === "#REF"
		calc_ref(control_stack, value_stack, env, store, locations)
	elseif op === "#BLKDEC"
		calc_blkdec(control_stack, value_stack, env, store, locations)
	end

end

function get_value(id, env, store)
	loc = env[id] #retorna o valor de uma variavel a partir de seu nome
	store[loc]
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
	loc = popfirst!(value_stack)
	identifier = popfirst!(value_stack)

	next = popfirst!(value_stack)

	println("TIPO: ", typeof(next))

	if typeof(next) <: Dict # ja existe E'
		println("ja existe E'")
		next[identifier] = loc
		value_stack = push(value_stack, next) # atualiza E' e coloca de volta na pilha de valores
	else # primeiro bind
		println("primeiro bind")
		value_stack = push(value_stack, next) # coloca de volta o valor retirado
		new_env = Dict()
		new_env[identifier] = loc
		value_stack = push(value_stack, new_env)
	end

	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_ref(control_stack, value_stack, env, store, locations)
	value = popfirst!(value_stack)
	loc = length(store)
	store[loc] = value
	push(value_stack, loc)
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function calc_blkdec(control_stack, value_stack, env, store, locations)
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
	value_stack = push(value_stack, result_env)
	automaton(pop(control_stack), value_stack, env, store, locations)
end

function copy_dict(dict2)
	new = Dict()
	for (key, value) in dict2
		new[key] = value
	end
	return new
end
