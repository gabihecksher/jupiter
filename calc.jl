function calc(op, control_pile, value_pile, env, store)
	if op === "#SUM"
		calc_sum(control_pile, value_pile, env, store)
	elseif op === "#MUL"
		calc_mul(control_pile, value_pile, env, store)
	elseif op === "#SUB"
		calc_sub(control_pile, value_pile, env, store)
	elseif op === "#DIV"
		calc_div(control_pile, value_pile, env, store)
	elseif op === "#EQ"
		calc_eq(control_pile, value_pile, env, store)
	elseif op === "#LT"
		calc_lt(control_pile, value_pile, env, store)
	elseif op === "#GT"
		calc_gt(control_pile, value_pile, env, store)
	elseif op === "#LE"
		calc_le(control_pile, value_pile, env, store)
	elseif op === "#GE"
		calc_ge(control_pile, value_pile, env, store)
	elseif op === "#AND"
		calc_and(control_pile, value_pile, env, store)
	elseif op === "#OR"
		calc_or(control_pile, value_pile, env, store)
	elseif op === "#NOT"
		calc_not(control_pile, value_pile, env, store)
	elseif op === "#ASSIGN"
		calc_assign(control_pile, value_pile, env, store)
	elseif op === "#LOOP"
		calc_loop(control_pile, value_pile, env, store)
	elseif op === "#COND"
		calc_cond(control_pile, value_pile, env, store)
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

function calc_sum(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end

	result = value1 + value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_sub(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end


	result = value1 - value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_mul(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end

	result = value1 * value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_div(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end

	result = value1 / value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_eq(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end


	if value1 == value2
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_lt(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end

	if value1 < value2
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_gt(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end

	if value1 > value2
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_le(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end

	if value1 <= value2
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_ge(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	if typeof(value1) == String
		value1 = get_value(value1, env, store)
	end
	if typeof(value2) == String
		value2 = get_value(value2, env, store)
	end

	if value1 >= value2
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_and(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
	if value1=="true" && value2=="true"
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_or(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
	if value1=="true" || value2=="true"
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_not(control_pile, value_pile, env, store)
	value1 = popfirst!(value_pile)
	if value1=="false"
		result = "true"
	else
		result = "false"
	end
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_assign(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)

	loc = env[value1]
	store[loc] = value2
	println(env)
	println(store)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_loop(control_pile, value_pile, env, store)
	condition = popfirst!(value_pile)
	loop = popfirst!(value_pile)
	values = pile.inside(loop)
	second_value = values[middle(values)+2:end]
	control_pile = pop(control_pile)
	if condition == "true"
		control_pile = push(control_pile, loop)
		control_pile = push(control_pile, second_value)
	end
	automaton(control_pile, value_pile, env, store)
end

function calc_cond(control_pile, value_pile, env, store)
	condition = popfirst!(value_pile)
	loop = popfirst!(value_pile)
	values = pile.inside(loop)

	part_two = values[middle(values)+2:end]

	second_value = values[middle(values)+2:middle(part_two)+middle(values)+1]
	third_value = values[middle(part_two)+middle(values)+3:end]

	control_pile = pop(control_pile)
	if condition == "true"
		control_pile = push(control_pile, second_value)
	else
		control_pile = push(control_pile, third_value)
	end
	automaton(control_pile, value_pile, env, store)
end
