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
mutable struct Id<:Node val end
mutable struct Not<:Node val end
mutable struct Exp<:Node val end
mutable struct Eq<:Node val end
mutable struct Lt<:Node val end
mutable struct Le<:Node val end
mutable struct Gt<:Node val end
mutable struct Ge<:Node val end
mutable struct And<:Node val end



@with_names begin
    spc = Drop(Star(Space()))
    # isso permite que eu bote ou nao espacos entre operacoes

    @with_pre spc begin


        number = (E"(" + spc + PFloat64() + spc + E")") | PFloat64() > Num

        # FAZER O IDENTIFIER FUNCIONAR
        # identifier = r"/(?!\d)\w+/" > Id

        # ACHAR UM EQUIVALENTE DE PFloat64() PRA ELE LER BOOLEAN
        # truth = (E"(" + spc + PBool() + spc + E")") | PBool() > Boo

        atom = number # | identifier # truth #


        multiplication = Delayed()
        division = Delayed()
        addition = Delayed()
        subtraction = Delayed()


        mult_expression = multiplication | division | atom # | <parentesisexp>

        #multiplication.matcher = Nullable{Matcher}(E"(" + spc + mult_expression + E"*" + mult_expression + spc + E")" |> Mul) # ARRANJAR UMA FORMA DE FUNCIONAR SEM OS PARENTESES

        ### TENTANDO FAZER DA MANEIRA DO IMP ###

        multiplication.matcher = Nullable{Matcher}(atom + E"*" + mult_expression |> Mul)
        division.matcher = Nullable{Matcher}(atom + E"/" + mult_expression |> Div)


        arith_expression = addition | subtraction | mult_expression | division # DUVIDA: PQ TEM QUE TER ESSE DIVISION SE EM MULT_EXPRESSION JA CHAMA DIVISION?

        addition = mult_expression + E"+" + arith_expression |> Sum
        subtraction = mult_expression + E"-" + arith_expression |> Sub


        ##################### ARIT EXPRESSION ########################################333
        #Delayed() define um loop na gramatica

        # num = (E"(" + spc + aexp + spc + E")") | PFloat64() > Num


        teste = mult_expression + Eos()

        ############################ BOOL EXP ##################################



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
