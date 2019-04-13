using ParserCombinator

# function pega_entrada(mensagem)
#     print(mensagem)
#     readline()
# end

# entrada = pega_entrada("Escreva a expressão: ")
# println("Você digitou $entrada")

# tokens = split(entrada, "")
# println(tokens)
#
mutable struct Neg children end #onde neg = negacao do numero
mutable struct Num children end
mutable struct Inv children end #onde inv = inverso do numero
mutable struct Sum children end
mutable struct Mul children end
mutable struct Bool children end
mutable struct Assign children end
mutable struct Exp children end

##A GRAMATICA:
positivo = Delayed()
#Delayed() define um loop na gramatica

valor = (E"(" + positivo + E")") | PFloat64()
#O E determina expressao enquanto o + seria juntar as expressoes numa lista. E o | seria um ou.
#ou seja o valor pode ser uma expressao (positiva) ou um numero ponto flutuante

negativo = Delayed()
negativo.matcher = valor | (E"-" + negativo > Neg)
#aqui ele permite varias negacoes em sequencia tipo --3
# o .matcher indica que a expressao "negativo" significa o que ta depois do =
# o ">" serve para indicar que tudo que ta na esquerda vai virar uma funcao Neg

multiplicacao = Delayed()

mul = E"*" + negativo
#ou seja a multiplicacao pode ser de um valor positivo ou negativo(ja que o negativo chama um valor positivo) aqui percebemos que estamos montando
#uma arvore igual ele deu em aula


div = E"/" + negativo > Inv
#aqui eu to definindo que a divisao vai ser uma multiplicacao do numero inverso ou seja 3/2 => 3*(1/2)

num = negativo[0:end] |> Num
#aqui o [0:end] significa que vai ler os numeros em sequencia ate acabar os valores e entrar uma outra expressao ex: 123*2 => aqui ele vai ler "123"

multiplicacao.matcher = negativo + (mul | div)[0:end] |> Mul
#o .matcher define que a expressao da multiplicacao sera  definida ao que vem depois do =

add = E"+" + num
sub = E"-" + num > Neg

positivo.matcher = negativo + (add | sub)[0:end] |> Sum


test_soma = positivo + Eos()
test_mul = multiplicacao + Eos()
#O Eos() faz a checagem se a entrada que eu dei faz sentido com o que eu defini na gramatica

aritmetico = positivo + multiplicacao + Eos()

#TENTANDO FAZER O BOOLEANO FUNCIONAR
bool_exp = Delayed()

bool_exp.matcher = (E"Eq(" + (positivo|multiplicacao) + E"," + (positivo|multiplicacao)[0:end] + E")") | (E"Not(" + (positivo|multiplicacao)[0:end] + E")") |> Bool

string = Word()

cmd_assign = Delayed()

cmd_assign = (E"Assign(" + string + E"," + (positivo|multiplicacao|bool_exp)[0:end] + E")") |> Assign  

teste_bool = bool_exp + Eos()

teste_assign = cmd_assign + Eos()

# println(parse_one("2/-2", test_div))
# println(parse_one("1*2", test_mul))

# println(parse_one("1+", test_soma_mul))
#println(parse_one("4+1==3-9", teste_bool))
# println(parse_one("Eq(2-1,3/4)", teste_bool))
println(parse_one("Assign(a,3/8)", cmd_assign))
# println(parse_one("Eq((3*4)+1,13)", teste_bool))
#parse_dbg("1+2/3", Trace(test_soma_mul))
