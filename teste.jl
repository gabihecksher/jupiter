using ParserCombinator
using Nullables

abstract type Node end
==(n1::Node, n2::Node) = isequal(n1.val, n2.val)

mutable struct Num<:Node val end
mutable struct Boo<:Node val end
mutable struct Sum<:Node val end
mutable struct Sub<:Node val end
mutable struct Mul<:Node val end
mutable struct Div<:Node val end

@with_names begin
    spc = Drop(Star(Space()))
    # isso permite que eu bote ou nao espacos entre operacoes
    @with_pre spc begin

        Exp = Delayed()

        digits = PFloat64() |> Num

        sum = (Exp + E"+" + Exp) |> Sum
#        sub =  (Exp + spc + E"-" + spc + Exp) |> Sub
#        mul = (Exp + spc + E"*" + spc + Exp) |> Mul
#        div = (Exp + spc + E"/" + spc + Exp) |> Div

        ArithExp = sum | digits # | sub | mul | div | digits
        # nos slides tem <exp> ao inves de <arithexp> mas nao sei se poderia por exemplo somar duas expressoes booleanas

        Exp.matcher = Nullable{Matcher}(ArithExp) # | BoolExp



        teste_digits = digits + Eos()
        teste_sum = Exp + Eos()

        teste = teste_digits | teste_sum

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
