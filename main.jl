
using ParserCombinator
using Nullables

abstract type Node end
==(n1::Node, n2::Node) = isequal(n1.val, n2.val)

mutable struct Num<:Node val end
mutable struct Sum<:Node val end
mutable struct Sub<:Node val end
mutable struct Mul<:Node val end
mutable struct Div<:Node val end
mutable struct Id<:Node val end
mutable struct Not<:Node val end
mutable struct Eq<:Node val end
mutable struct Lt<:Node val end
mutable struct Le<:Node val end
mutable struct Gt<:Node val end
mutable struct Ge<:Node val end
mutable struct And<:Node val end
mutable struct Or<:Node val end
mutable struct Boo<:Node val end
mutable struct Assign<:Node val end
mutable struct Loop<:Node val end
mutable struct Cond<:Node val end
mutable struct CSeq<:Node val end




@with_names begin
    spc = Drop(Star(Space()))
    # isso permite que eu bote ou nao espacos entre operacoes

    @with_pre spc begin


        number = (E"(" + spc + PFloat64() + spc + E")") | PFloat64() > Num

        # FAZER O IDENTIFIER FUNCIONAR
        identifier = (E"(" + spc + Word() + spc + E")") | Word() > Id

        truth = (E"(" + spc + p"([Tt][Rr][Uu][Ee])|([Ff][Aa][Ll][Ss][Ee])" + spc + E")") | p"([Tt][Rr][Uu][Ee])|([Ff][Aa][Ll][Ss][Ee])" > Boo

        atom = number | truth | identifier


        multiplication = Delayed()
        division = Delayed()
        addition = Delayed()
        subtraction = Delayed()


        mult_expression = (multiplication | division | atom) # | <parentesisexp>


        multiplication.matcher = Nullable{Matcher}((atom + E"*" + mult_expression) | (E"(" + atom + E"*" + mult_expression + E")") |> Mul)
        division.matcher = Nullable{Matcher}((atom + E"/" + mult_expression) | (E"(" + atom + E"/" + mult_expression + E")") |> Div)


        arith_expression = ((addition | subtraction | mult_expression | division) | (E"(" + (addition | subtraction | mult_expression | division) + E")")) # DUVIDA: PQ TEM QUE TER ESSE DIVISION SE EM MULT_EXPRESSION JA CHAMA DIVISION?

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

        # FAZER O CSEQ

        assign = Delayed()
        loop = Delayed()
        cseq = Delayed()
        conditional = Delayed()
        call = Delayed()


        cmd = assign | loop | expression | conditional | cseq

        conditional.matcher = Nullable{Matcher}((E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"else" + spc + cmd + spc + E"end") | (E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"end") |> Cond)

        assign.matcher = Nullable{Matcher}((identifier + E":=" + expression) | (E"(" + identifier + E":=" + expression + E")") |> Assign)

        loop.matcher = Nullable{Matcher}((E"while" + spc + expression + spc + E"do" + spc + cmd) | (E"(" + E"while" + spc + expression + spc + E"do" + spc + cmd + E")") |> Loop)
        
        cseq.matcher = Nullable{Matcher}((cmd + spc + cmd) |> CSeq)

        teste = cmd + Eos()


    end
end

function pega_entrada()
     print("Escreva a expressão: ")
     readline()
 end

# entrada = pega_entrada()
# println("Você digitou $entrada")

teste_str = "while not (y == 0) do z:=z*y z:=y-1"
println(teste_str)
parse = parse_one(teste_str, teste)
parser_string = (string.(parse))
parser_string = replace(parser_string[1], "Any"=> "")
println(parser_string)
