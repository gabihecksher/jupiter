function check_automaton(control_pile, value_pile, env, store)
    if length(control_pile) == 0
        return popfirst!(value_pile)
    else
        todo = popfirst!(control_pile) # todo pode ser um comando ou uma expressao aritmetica
        automaton(control_pile,value_pile,env,store)
    end
end

function automaton(control_pile, value_pile, env, store)
	if length(control_pile) == 0
		return value_pile[1]
	else
		handle(pop!(control_pile), control_pile, value_pile, env, store)
	end
end

function push(pile, element)
    pushfirst!(pile, element)
end

function pop(pile)
    popfirst!(pile)
    pile
end

function print_pile(pile)
	if length(pile) == 1
		println(pile[1])
	elseif length(pile) > 1
		print_pile(pile[2:end])
		println(pile[1])
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

function handle(element, control_pile, value_pile, env, store)

	println("######################")

	println(element)

	println("CONTROL PILE:")
	print_pile(control_pile)

	println("VALUE PILE:")
	print_pile(value_pile)

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
	end


end

function handle_Num(element, control_pile, value_pile, env, store)
    value_pile = push(value_pile, element) #coloca o numero no topo da pilha de valores
	control_pile = pop(control_pile)
end

function handle_Sum(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#SUM")
	values = inside(element)
	control_pile = push(control_pile,values)

	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]


	handle(first_value, control_pile, value_pile, env, store)
	handle(second_value, control_pile, value_pile, env, store)

	#automaton.rec(cPile,vPile,env,stor,result)
end

function handle_Sub(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#SUB")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile,first_value)
	control_pile = push(control_pile,second_value)

	#automaton.rec(cPile,vPile,env,stor,result)
end

function handle_Mul(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#MUL")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile,first_value)
	control_pile = push(control_pile,second_value)

	#automaton.rec(cPile,vPile,env,stor,result)
end

function handle_Div(element, control_pile, value_pile, env, store)
	control_pile = push(control_pile, "#DIV")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_pile = push(control_pile,first_value)
	control_pile = push(control_pile,second_value)

	#automaton.rec(cPile,vPile,env,stor,result)
end

function main()
    control_pile = []
    value_pile = []
    control_pile = push(control_pile, 4)
    println(control_pile)
    control_pile = push(control_pile, 5)
    println(control_pile)
    control_pile = pop(control_pile)
    println(control_pile)
end

#main()

automaton(["Mul(Num(5),Sum(Num(3),Num(2)))"],[],[],[])
