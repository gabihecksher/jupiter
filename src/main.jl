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


function main()
    println("Pressione 1 para escrever o programa. Exemplos: 2+3 , 2<3 and 3>11 ")
    println("Pressione 2 para ler um arquivo texto como entrada")
    digito = readline()
    env = Dict()
    store = Dict()

    println("De quantas variaveis seu programa vai precisar?")
    num_variaveis = parse(UInt8, readline())
    for i = 1:num_variaveis
        println("Qual o nome da $i ª variavel?")
        nome_var = readline()
        println("Qual o valor inicial da $i ª variavel?")
        valor_var = readline()

        env[nome_var] = i # coloca o id da variavel no dicionario env associada a localizacao
        store[i] = valor_var # associa a localizacao da variavel ao seu valor no dicionario store
        print_variables(env,store)
    end

    if (isequal(digito, "1"))

        entrada = pega_entrada()
        println("Entrada: $entrada")

        parser = parse_one(entrada, teste)
        println(parser)


        # Automaton.automaton([parser_string], [], env, store)
        control_stack = Array{Any, 1}(parser)
        value_stack = Array{Any, 1}()
        automaton(control_stack, value_stack, env, store)

    elseif (isequal(digito, "2"))
        entrada = pega_arquivo()
        open(entrada) do file
            for ln in eachline(file)
                linha = "$(ln)"
                println(linha)
                parse = parse_one(linha, teste)
                parser_string = (string.(parse))
                parser_string = replace(parser_string[1], "Any"=> "")
                parser_string = replace(parser_string, "["=> "")
                parser_string = replace(parser_string, "]"=> "")
                parser_string = replace(parser_string, " "=> "")
                println(parser_string)
                Automaton.automaton([parser_string], [], env, store)
                println(" ")
            end
        end
    end
end

main()
