include("calc.jl")

function automaton(control_pile, value_pile, env, store)
	print_piles(control_pile, value_pile)
	if length(control_pile) == 0
		if length(value_pile) == 1
			println("Resultado: ",popfirst!(value_pile))
		end
		return 0
	else
		op = control_pile[1]
		if op[1] === '#'
			calc(op, control_pile, value_pile, env, store)
		else
			handle(popfirst!(control_pile), control_pile, value_pile, env, store)
		end
	end
end


function handle(element, control_pile, value_pile, env, store)
	op = element[1:2]
	if op == "Eq"
		handle_Eq(element, control_pile, value_pile, env, store)
	elseif op == "Lt"
		handle_Lt(element, control_pile, value_pile, env, store)
	elseif op == "Gt"
		handle_Gt(element, control_pile, value_pile, env, store)
	elseif op == "Le"
		handle_Le(element, control_pile, value_pile, env, store)
	elseif op == "Ge"
		handle_Ge(element, control_pile, value_pile, env, store)
	elseif op == "Or"
		handle_Or(element, control_pile, value_pile, env, store)
	elseif op == "Id"
		handle_Id(element, control_pile, value_pile, env, store)
	end

	op = element[1:3]
	if op == "Num"
		handle_Num(element, control_pile, value_pile, env, store)
	elseif op == "Sum"
		handle_Sum(element, control_pile, value_pile, env, store)
	elseif op == "Sub"
		handle_Sub(element, control_pile, value_pile, env, store)
	elseif op == "Mul"
		handle_Mul(element, control_pile, value_pile, env, store)
	elseif op == "Div"
		handle_Div(element, control_pile, value_pile, env, store)
	elseif op == "Boo"
		handle_Boo(element, control_pile, value_pile, env, store)
	elseif op == "Not"
		handle_Not(element, control_pile, value_pile, env, store)
	elseif op == "And"
		handle_And(element, control_pile, value_pile, env, store)
	end

	op = element[1:6]
	if op == "Assign"
		handle_Assign(element, control_pile, value_pile, env, store)
	end
end

function print_piles(control_pile, value_pile)
	println("######################")

	println("CONTROL PILE:")
	print_pile(control_pile)

	println("VALUE PILE:")
	print_pile(value_pile)

	println("######################")

end

function push(pile, element)
    pushfirst!(pile, element)
	pile
end

function pop(pile)
    popfirst!(pile)
    pile
end

function print_pile(pile)
	if length(pile) == 1
		println(pile[1])
	elseif length(pile) > 1
		println(pile[1])
		print_pile(pile[2:end])
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

function handle_Num(element, control_pile, value_pile, env, store)
    value_pile = push(value_pile, parse(Float64, element[5:end-1])) #coloca o numero no topo da pilha de valores

	automaton(control_pile, value_pile, env, store)
end

function handle_Boo(element, control_pile, value_pile, env, store)
	value_pile = push(value_pile, inside(element)) #coloca o numero no topo da pilha de valores

	automaton(control_pile, value_pile, env, store)
end

function handle_Id(element, control_pile, value_pile, env, store)
	value_pile = push(value_pile, inside(element)) #coloca o numero no topo da pilha de valores

	automaton(control_pile, value_pile, env, store)
end

function handle_Sum(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#SUM")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)

end

function handle_Sub(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#SUB")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Mul(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#MUL")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Div(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#DIV")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Eq(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#EQ")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Lt(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#LT")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Le(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#LE")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Gt(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#GT")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Ge(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#GE")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end


function handle_And(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#AND")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Or(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#OR")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Assign(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#ASSIGN")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile, second_value)
	control_pile = push(control_pile, first_value)

	automaton(control_pile, value_pile, env, store)
end

function handle_Not(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#NOT")
	value = inside(element)

	control_pile = push(control_pile, value)

	automaton(control_pile, value_pile, env, store)
end

function main(x::String)
	#automaton(["Num(23)"],[],[],[])
    #automaton(["Div(Mul(Num(1),Num(4)),Sub(Num(5),Num(15)))"],[],[],[])
	# automaton(["Or(Not(Lt(Num(20),Num(10))),Eq(Num(2),Num(5)))"],[],[],[])
	automaton([x],[],[],[])

end

# main()
