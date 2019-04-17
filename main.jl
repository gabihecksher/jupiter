using ParserCombinator
using Nullables
import Base.==
# function pega_entrada(mensagem)
#     print(mensagem)
#     readline()
# end

# entrada = pega_entrada("Escreva a expressão: ")
# println("Você digitou $entrada")

# tokens = split(entrada, "")
# println(tokens)

signed_prod(lst) = length(lst) == 1 ? lst[1] : Base.prod(lst)
signed_sum(lst) = length(lst) == 1 ? lst[1] : Base.sum(lst)

abstract type Node end
==(n1::Node, n2::Node) = isequal(n1.val, n2.val)
calc(n::Float64) = n
mutable struct Inv<:Node val end
calc(i::Inv) = 1.0/calc(i.val)
mutable struct Neg<:Node val end
calc(n::Neg) = -calc(n.val)
mutable struct Mul<:Node val end
calc(p::Mul) = signed_prod(map(calc, p.val))
mutable struct Sum<:Node val end
calc(s::Sum) = signed_sum(map(calc, s.val))
mutable struct Bool<:Node val end
mutable struct Assign<:Node val end

@with_names begin
    spc = Drop(Star(Space()))
    #isso permite que eu bote espacos entre operacoes

    @with_pre spc begin

        ##A GRAMATICA:
        positivo = Delayed()
        #Delayed() define um loop na gramatica

        valor = (E"(" + spc + positivo + spc + E")") | PFloat64()
        #O E determina expressao enquanto o + seria juntar as expressoes numa lista. E o | seria um ou.
        #ou seja o valor pode ser uma expressao (positiva) ou um numero ponto flutuante

        negativo = Delayed()
        negativo.matcher = Nullable{Matcher}(valor | (E"-" + negativo > Neg))
        #aqui ele permite varias negacoes em sequencia tipo --3
        # o .matcher indica que a expressao "negativo" significa o que ta depois do =
        # o ">" serve para indicar que tudo que ta na esquerda vai virar uma funcao Neg


        mul = E"*" + negativo
        #ou seja a multiplicacao pode ser de um valor positivo ou negativo(ja que o negativo chama um valor positivo) aqui percebemos que estamos montando
        #uma arvore igual ele deu em aula


        div = E"/" + negativo > Inv
        #aqui eu to definindo que a divisao vai ser uma multiplicacao do numero inverso ou seja 3/2 => 3*(1/2)

        prd = negativo + (mul | div)[0:end] |> Mul
        #o .matcher define que a expressao da multiplicacao sera  definida ao que vem depois do =

        add = E"+" + prd
        sub = E"-" + prd > Neg


        positivo.matcher = Nullable{Matcher}(prd + (add | sub)[0:end] |> Sum)


        #O Eos() faz a checagem se a entrada que eu dei faz sentido com o que eu defini na gramatica

        aritmetico = spc + positivo  + Eos()

        # #TENTANDO FAZER O BOOLEANO FUNCIONAR
        bool_exp = Delayed()

        bool_exp.matcher = (E"Eq(" + (positivo) + E"," + (positivo)[0:end] + E")") | (E"Not(" + (positivo)[0:end] + E")") |> Bool

        string = Word()

        cmd_assign = Delayed()

        cmd_assign = (E"Assign(" + string + E"," + (positivo|bool_exp)[0:end] + E")") |> Assign  

        teste_bool = bool_exp + Eos()

        # teste_assign = cmd_assign + Eos()
    end
end

## TESTE CALCULADORA#
println(parse_one("2-1 * 2/3", aritmetico))
println(calc(parse_one("2-1 * 3/3", aritmetico)[1]))

### TESTE BOOLEANO ####
# println(parse_one("Eq(2-1,3/4)", teste_bool))
# println(parse_one("Eq((3*4)+1,13)", teste_bool))

### TESTE ASSIGN ####
# println(parse_one("Assign(a,3/8)", cmd_assign))

