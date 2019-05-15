
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
	end

end

function calc_sum(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
	result = value1 + value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_sub(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
	result = value1 - value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_mul(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
	result = value1 * value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_div(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
	result = value1 / value2
	value_pile = push(value_pile, result)
	automaton(pop(control_pile), value_pile, env, store)
end

function calc_eq(control_pile, value_pile, env, store)
	value2 = popfirst!(value_pile)
	value1 = popfirst!(value_pile)
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
