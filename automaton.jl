module Automaton
include("calc.jl")

function automaton(control_stack, value_stack, env, store)
	print_stacks(control_stack, value_stack, env, store)
	if length(control_stack) == 0
		if length(value_stack) == 1
			result = popfirst!(value_stack)
			print_stacks(control_stack, value_stack, env, store)
			println("Resultado: ",result)
		end
		return 0
	else
		op = control_stack[1]
		if op[1] === '#'
			calc(op, control_stack, value_stack, env, store)
		else
			handle(popfirst!(control_stack), control_stack, value_stack, env, store)
		end
	end
end

function handle(element, control_stack, value_stack, env, store)
	op = element[1:2]
	if op == "Eq"
		handle_Eq(element, control_stack, value_stack, env, store)
	elseif op == "Lt"
		handle_Lt(element, control_stack, value_stack, env, store)
	elseif op == "Gt"
		handle_Gt(element, control_stack, value_stack, env, store)
	elseif op == "Le"
		handle_Le(element, control_stack, value_stack, env, store)
	elseif op == "Ge"
		handle_Ge(element, control_stack, value_stack, env, store)
	elseif op == "Or"
		handle_Or(element, control_stack, value_stack, env, store)
	elseif op == "Id"
		handle_Id(element, control_stack, value_stack, env, store)
	end

	op = element[1:3]
	if op == "Num"
		handle_Num(element, control_stack, value_stack, env, store)
	elseif op == "Sum"
		handle_Sum(element, control_stack, value_stack, env, store)
	elseif op == "Sub"
		handle_Sub(element, control_stack, value_stack, env, store)
	elseif op == "Mul"
		handle_Mul(element, control_stack, value_stack, env, store)
	elseif op == "Div"
		handle_Div(element, control_stack, value_stack, env, store)
	elseif op == "Boo"
		handle_Boo(element, control_stack, value_stack, env, store)
	elseif op == "Not"
		handle_Not(element, control_stack, value_stack, env, store)
	elseif op == "And"
		handle_And(element, control_stack, value_stack, env, store)
	end

	op = element[1:4]
	if op == "Loop"
		handle_Loop(element, control_stack, value_stack, env, store)
	elseif op == "CSeq"
		handle_CSeq(element, control_stack, value_stack, env, store)
	elseif op == "Cond"
		handle_Cond(element, control_stack, value_stack, env, store)
	end

	op = element[1:6]
	if op == "Assign"
		handle_Assign(element, control_stack, value_stack, env, store)
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

function push(stack, element)
    pushfirst!(stack, element)
	stack
end

function pop(stack)
    popfirst!(stack)
    stack
end

function print_stack(stack)
	if length(stack) == 1
		println(stack[1])
	elseif length(stack) > 1
		println(stack[1])
		print_stack(stack[2:end])
	end
end

function handle_Num(element, control_stack, value_stack, env, store)
    value_stack = push(value_stack, parse(Float64, element[5:end-1])) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store)
end

function handle_Boo(element, control_stack, value_stack, env, store)
	value_stack = push(value_stack, inside(element)) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store)
end

function handle_Id(element, control_stack, value_stack, env, store)
	value_stack = push(value_stack, inside(element)[2:end-1]) #coloca o numero no topo da pilha de valores

	automaton(control_stack, value_stack, env, store)
end

function handle_Sum(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#SUM")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)

end

function handle_Sub(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#SUB")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Mul(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#MUL")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Div(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#DIV")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Eq(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#EQ")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Lt(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#LT")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Le(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#LE")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Gt(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#GT")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Ge(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#GE")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end


function handle_And(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#AND")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Or(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#OR")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Assign(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#ASSIGN")
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_CSeq(element, control_stack, value_stack, env, store)
	values = inside(element)
	first_value = values[1:middle(values)]
	second_value = values[middle(values)+2:end]

	control_stack = push(control_stack, second_value)
	control_stack = push(control_stack, first_value)

	automaton(control_stack, value_stack, env, store)
end

function handle_Loop(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#LOOP")
	values = inside(element)
	first_value = values[1:middle(values)]
	control_stack = push(control_stack, first_value)

	value_stack = push(value_stack, element)

	automaton(control_stack, value_stack, env, store)
end

function handle_Cond(element, control_stack, value_stack, env, store)
	control_stack = push(control_stack, "#COND")
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
	control_stack = push(control_stack, "#NOT")
	value = inside(element)

	control_stack = push(control_stack, value)

	automaton(control_stack, value_stack, env, store)
end

end
