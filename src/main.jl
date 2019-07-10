include("./automaton.jl")
include("./lexer.jl")


function main(args)
    if(isequal(args[1], "-f"))
        arquivo_path = args[2]
        open(arquivo_path) do file
                s = read(file, String)
                s = replace(s, "\n" => " ")
                s = replace(s, "    " => "")
                linha = replace(s, "  "=> " ")
                parse = parse_one(linha, teste)
                println(parse)
                # control_stack = Array{Any, 1}(parse)
                # value_stack = Array{Any, 1}()
                # env = Dict()
                # store = Dict()
                # locations = []
                # automaton(control_stack, value_stack, env, store, locations)
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
         locations = []
         automaton(control_stack, value_stack, env, store, locations)
    end
end


main(ARGS)
