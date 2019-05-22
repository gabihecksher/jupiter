function calc(op, control_stack, value_stack, env, store)
	if op === "#SUM"
		calc_sum(control_stack, value_stack, env, store)
	elseif op === "#MUL"
		calc_mul(control_stack, value_stack, env, store)
	elseif op === "#SUB"
		calc_sub(control_stack, value_stack, env, store)
	elseif op === "#DIV"
		calc_div(control_stack, value_stack, env, store)
	elseif op === "#EQ"
		calc_eq(control_stack, value_stack, env, store)
	elseif op === "#LT"
		calc_lt(control_stack, value_stack, env, store)
	elseif op === "#GT"
		calc_gt(control_stack, value_stack, env, store)
	elseif op === "#LE"
		calc_le(control_stack, value_stack, env, store)
	elseif op === "#GE"
		calc_ge(control_stack, value_stack, env, store)
	elseif op === "#AND"
		calc_and(control_stack, value_stack, env, store)
	elseif op === "#OR"
		calc_or(control_stack, value_stack, env, store)
	elseif op === "#NOT"
		calc_not(control_stack, value_stack, env, store)
	elseif op === "#ASSIGN"
		calc_assign(control_stack, value_stack, env, store)
	elseif op === "#LOOP"
		calc_loop(control_stack, value_stack, env, store)
	elseif op === "#COND"
		calc_cond(control_stack, value_stack, env, store)
	end

end


function inside(element)
	parentheses_control = 0
	start = 0;
	finish = 0;
	i = 0
	for char in element
		i = i + 1
		if char == '('
			if parentheses_control == 0 # se for o primeiro parenteses
				start = i+1
			end
			parentheses_control = parentheses_control + 1
		end
		if char == ')'
			parentheses_control = parentheses_control - 1
			if parentheses_control == 0
				finish = i-1
			end
		end
	end
	return element[start:finish]
end


function middle(element)
	parentheses_control = 0
	finish = 0;
	i = 0
	for char in element
		i = i + 1
		if char == '('
			parentheses_control = parentheses_control + 1
		end
		if char == ')'
			parentheses_control = parentheses_control - 1
			if parentheses_control == 0
				finish = i
				return finish
			end
		end
	end
end



function get_value(id, env, store)
	loc = env[id]
	store[loc]
end

function calc_sum(control_stack, value_stack, env, store) # chamada quando o opcode #SUM está no topo da pilha de controle
	value2 = popfirst!(value_stack)  # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)
	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 + value2
	value_stack = push(value_stack, result) # coloca o resultado da soma no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_sub(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end


	result = value1 - value2
	value_stack = push(value_stack, result) # coloca o resultado da subtração no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_mul(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 * value2
	value_stack = push(value_stack, result) # coloca o resultado da multiplicação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_div(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end

	result = value1 / value2
	value_stack = push(value_stack, result) # coloca o resultado da divisão no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_eq(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end


	if value1 == value2
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_lt(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end

	if value1 < value2
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_gt(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end

	if value1 > value2
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_le(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end

	if value1 <= value2
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_ge(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	if typeof(value1) == String # caso o valor seja o nome de uma variável, pega o valor associado a ela
		value1 = get_value(value1, env, store)
		if typeof(value1) == String
			value1 = parse(Float64, value1)
		end
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
		if typeof(value2) == String
			value2 = parse(Float64, value2)
		end
	end

	if value1 >= value2
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_and(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)
	if value1=="true" && value2=="true"
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_or(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)
	if value1=="true" || value2=="true"
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da comparação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_not(control_stack, value_stack, env, store)
	value1 = popfirst!(value_stack) # retira o elemento do topo da pilha de valores
	if value1=="false"
		result = "true"
	else
		result = "false"
	end
	value_stack = push(value_stack, result)  # coloca o resultado da negação no topo da pilha de valores
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_assign(control_stack, value_stack, env, store)
	value2 = popfirst!(value_stack) # retira os dois elementos do topo da pilha de valores
	value1 = popfirst!(value_stack)

	loc = env[value1]
	store[loc] = value2 # associa o novo valor ao nome da variavel
	println(env)
	println(store)
	automaton(pop(control_stack), value_stack, env, store)
end

function calc_loop(control_stack, value_stack, env, store)
	condition = popfirst!(value_stack)
	loop = popfirst!(value_stack)
	values = Automaton.inside(loop)
	second_value = values[middle(values)+2:end]
	control_stack = pop(control_stack)
	if condition == "true"
		control_stack = push(control_stack, loop)
		control_stack = push(control_stack, second_value)
	end
	automaton(control_stack, value_stack, env, store)
end

function calc_cond(control_stack, value_stack, env, store)
	condition = popfirst!(value_stack)
	loop = popfirst!(value_stack)
	values = Automaton.inside(loop)

	part_two = values[middle(values)+2:end]

	second_value = values[middle(values)+2:middle(part_two)+middle(values)+1]
	third_value = values[middle(part_two)+middle(values)+3:end]

	control_stack = pop(control_stack)
	if condition == "true"
		control_stack = push(control_stack, second_value)
	else
		control_stack = push(control_stack, third_value)
	end
	automaton(control_stack, value_stack, env, store)
end
