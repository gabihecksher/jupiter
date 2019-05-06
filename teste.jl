using ParserCombinator
using Nullables
import Base.==

abstract type Node end
==(n1::Node, n2::Node) = isequal(n1.val, n2.val)

mutable struct Num<:Node val end
mutable struct Boo<:Node val end
mutable struct Sum<:Node val end
mutable struct Sub<:Node val end
mutable struct Mul<:Node val end
mutable struct Div<:Node val end
mutable struct Id<:Node val end
mutable struct Not<:Node val end
mutable struct ArithExp<:Node val end
mutable struct BoolExp<:Node val end
mutable struct Exp<:Node val end
mutable struct Eq<:Node val end



@with_names begin
    spc = Drop(Star(Space()))
    # isso permite que eu bote ou nao espacos entre operacoes
   
    @with_pre spc begin


        ##################### ARIT EXPRESSION ########################################333
        aexp = Delayed()
        #Delayed() define um loop na gramatica

        num = (E"(" + spc + aexp + spc + E")") | PFloat64() > Num
        
        multiplication = E"*" + num

        division = E"/" + num

        prd = (num + (multiplication)[0:end] |> Mul)

        div = (num + (division)[0:end] |> Div)

        add = E"+" + num 
        sub = E"-" + num

        soma = (num + (add)[0:end] |> Sum)
        subtracao = (num + (sub)[0:end] |> Sub)


        # aexp.matcher =(num + (add)[0:end]|> Sum)
        aexp.matcher = Nullable{Matcher}((soma | subtracao | prd | div | num))


        aritmetico = spc + aexp > ArithExp

        # teste = aritmetico

        ############################ BOOL EXP ##################################
        
        bool_exp = Delayed()

        expression = (bool_exp | aritmetico)[0:end] |> Exp

        negation = E"not" + spc + (aritmetico)[0:end]|> Not

        equality = spc + (aritmetico) + spc + E"==" + spc + (aritmetico)[0:end] |> Eq

        bool_exp.matcher =  Nullable{Matcher}((equality | negation))

        # id = Word()[0:end] |> Id 

        # truth = E"True" | E"False"


        booleano = bool_exp + Eos() > BoolExp
        teste = booleano


    end
end

function pega_entrada()
     print("Escreva a expressão: ")
     readline()
 end

entrada = pega_entrada()
println("Você digitou $entrada")

parse = parse_one(entrada, teste)
println(parse)

