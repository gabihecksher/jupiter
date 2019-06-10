include("./automaton.jl")
include("./lexer.jl")


function pega_entrada()
     println("Escreva a expressão: ")
     readline()
 end

 function pega_arquivo()
    println("Escreva o o path do arquivo a ser lido. Exemplo: test/fatorial.txt")
    readline()
 end


function main(args)
    if(isequal(args[1], "-f"))
        arquivo_path = args[2]
        open(arquivo_path) do file
            for ln in eachline(file)
                linha = "$(ln)"
                println(linha)
                parse = parse_one(linha, teste)
                control_stack = Array{Any, 1}(parser)
                value_stack = Array{Any, 1}()
                # env[nome_var] = i # coloca o id da variavel no dicionario env associada a localizacao
                # store[i] = valor_var # associa a localizacao da variavel ao seu valor no dicionario store
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
        # env[nome_var] = i # coloca o id da variavel no dicionario env associada a localizacao
        # store[i] = valor_var # associa a localizacao da variavel ao seu valor no dicionario store
        automaton(control_stack, value_stack, env, store)
    end
end


main(ARGS)
