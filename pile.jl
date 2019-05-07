function push(pile, element)
    pushfirst!(pile, element)
end

function pop(pile)
    popfirst!(pile)
    pile
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

main()
