include("./automaton.jl")
include("./lexer.jl")


function main(args)
    if(isequal(args[1], "-f"))
        arquivo_path = args[2]
        open(arquivo_path) do file
            for ln in eachline(file)
                linha = "$(ln)"
                println(linha)
                parse = parse_one(linha, teste)
                control_stack = Array{Any, 1}(parse)
                value_stack = Array{Any, 1}()
                env = Dict()
                store = Dict()
                automaton(control_stack, value_stack, env, store)
            end
    end

    elseif(isequal(args[1], "-i"))
        println("Escreva a expressão: ")
        entrada = readline()
        parser = parse_one(entrada, teste)
        println(parser)
         control_stack = Array{Any, 1}(parser)
         value_stack = Array{Any, 1}()
         env = Dict()
         store = Dict()
         automaton(control_stack, value_stack, env, store)
    end
end


main(ARGS)
