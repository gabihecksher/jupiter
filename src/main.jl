using ParserCombinator
using Nullables

include("./automaton.jl")
using .Automaton

abstract type Node end
==(n1::Node, n2::Node) = isequal(n1.val, n2.val)

mutable struct Num<:Node val end #ok
mutable struct Sum<:Node val end #ok
mutable struct Sub<:Node val end #ok
mutable struct Mul<:Node val end #ok
mutable struct Div<:Node val end #ok
mutable struct Id<:Node val end #ok
mutable struct Not<:Node val end #ok
mutable struct Eq<:Node val end #ok
mutable struct Lt<:Node val end #ok
mutable struct Le<:Node val end #ok
mutable struct Gt<:Node val end #ok
mutable struct Ge<:Node val end #ok
mutable struct And<:Node val end #ok
mutable struct Or<:Node val end #ok
mutable struct Boo<:Node val end #ok
mutable struct Assign<:Node val end #ok
mutable struct Loop<:Node val end
mutable struct Cond<:Node val end
mutable struct CSeq<:Node val end




@with_names begin
    spc = Drop(Star(Space()))
    # isso permite que eu bote ou nao espacos entre operacoes

    @with_pre spc begin

        #definicao de numero pela gramatica onde PFloat64 faz parte do Parser
        number = (E"(" + spc + PFloat64() + spc + E")") | PFloat64() > Num

        #definicao de identificador pela gramatica onde Word faz parte do Parser
        identifier = (E"(" + spc + Word() + spc + E")") | Word() > Id

        #unica coisa que eu achei no parser combinator que parseia true e false (nao sei o que significa isso, caso duvidas consultar biblioteca ParserCombinator)
        truth = (E"(" + spc + p"([Tt][Rr][Uu][Ee])|([Ff][Aa][Ll][Ss][Ee])" + spc + E")") | p"([Tt][Rr][Uu][Ee])|([Ff][Aa][Ll][Ss][Ee])" > Boo

        atom = number | truth | identifier

        #O Delayed serve como uma inicializacao da variavel para que eu possa atribuir ela a uma outra variavel sem que eu defina o que ela eh
        multiplication = Delayed()
        division = Delayed()
        addition = Delayed()
        subtraction = Delayed()

        #aqui por exemplo eu botei o multiplication no mult_expression mas eu so defino o que eh na linha abaixo.
        mult_expression = (multiplication | division | atom)

        multiplication.matcher = Nullable{Matcher}((atom + E"*" + mult_expression) | (E"(" + atom + E"*" + mult_expression + E")") |> Mul)
        division.matcher = Nullable{Matcher}((atom + E"/" + mult_expression) | (E"(" + atom + E"/" + mult_expression + E")") |> Div)


        arith_expression = ((addition | subtraction | mult_expression | division) | (E"(" + (addition | subtraction | mult_expression | division) + E")"))

        addition.matcher = Nullable{Matcher}((mult_expression + E"+" + arith_expression) | (E"(" + mult_expression + E"+" + arith_expression + E")") |> Sum)
        subtraction.matcher = Nullable{Matcher}((mult_expression + E"-" + arith_expression) | (E"(" + mult_expression + E"-" + arith_expression + E")") |> Sub)

        ############################ BOOL EXP ##################################

        equality = Delayed()
        negation = Delayed()

        conjunction = Delayed()
        disjuction = Delayed()

        lower_eq = Delayed()
        greater_eq = Delayed()
        lower_than = Delayed()
        greater_than = Delayed()

        #o conjunction e disjuction tive que fazer fora do bool_expression pois o PEG entrava em loop infinito em sua recursao
        and_or = (conjunction | disjuction)
        bool_expression = ((equality | negation | lower_eq | lower_than | greater_eq | greater_than) | (E"(" + (equality | negation |  lower_eq | lower_than | greater_eq | greater_than) + E")"))

        expression = (arith_expression | bool_expression | and_or)


        equality.matcher = Nullable{Matcher}((arith_expression + spc + E"==" +spc +  expression) | (E"(" + arith_expression + spc + E"==" + spc + expression + E")") |> Eq)
        negation.matcher = Nullable{Matcher}((E"not"+ spc + E"(" + bool_expression  + E")") | (E"(" + E"not" + E"(" + bool_expression+ E")" + E")") |> Not)
        conjunction.matcher = Nullable{Matcher}((bool_expression + spc + E"and" + spc + bool_expression) | (E"(" + bool_expression + spc + E"and" + spc + bool_expression + E")") |> And)
        disjuction.matcher = Nullable{Matcher}((bool_expression + spc + E"or" + bool_expression) | (E"(" + bool_expression + spc + E"or" + spc + bool_expression + E")") |> Or)

        lower_eq.matcher = Nullable{Matcher}((arith_expression + E"<=" + arith_expression) | (E"(" + arith_expression + E"<=" + arith_expression + E")") |> Le)
        lower_than.matcher = Nullable{Matcher}((arith_expression + E"<" + arith_expression) | (E"(" + arith_expression + E"<" + arith_expression + E")") |> Lt)
        greater_eq.matcher = Nullable{Matcher}((arith_expression + E">=" + arith_expression) | (E"(" + arith_expression + E">=" + arith_expression + E")") |> Ge)
        greater_than.matcher = Nullable{Matcher}((arith_expression + E">" + arith_expression) | (E"(" + arith_expression + E">" + arith_expression + E")") |> Gt)


    ############################ COMAND ##################################
        assign = Delayed()
        loop = Delayed()
        cseq = Delayed()
        conditional = Delayed()
        call = Delayed()


        cmd = assign | loop | expression | conditional | cseq

        # conditional.matcher = Nullable{Matcher}((E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"end") | (E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"else" + spc + cmd + spc + E"end") |> Cond)

        conditional.matcher = Nullable{Matcher}((E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"else" + spc + cmd + spc + E"end") |> Cond)

        assign.matcher = Nullable{Matcher}((identifier + E":=" + expression) | (E"(" + identifier + E":=" + expression + E")") |> Assign)

        loop.matcher = Nullable{Matcher}((E"while" + spc + expression + spc + E"do" + spc + cmd) | (E"(" + E"while" + spc + expression + spc + E"do" + spc + cmd + E")") |> Loop)

        cseq.matcher = Nullable{Matcher}((cmd + spc + cmd) |> CSeq)

        teste = cmd + Eos()


    end
end

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
        Automaton.print_variables(env,store)
    end

    if (isequal(digito, "1"))

        entrada = pega_entrada()
        println("Entrada: $entrada")
        parser = parse_one(entrada, teste)
        parser_string = (string.(parser))
        parser_string = replace(parser_string[1], "Any"=> "")
        parser_string = replace(parser_string, "["=> "")
        parser_string = replace(parser_string, "]"=> "")
        parser_string = replace(parser_string, " "=> "")


        Automaton.automaton([parser_string], [], env, store)

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
