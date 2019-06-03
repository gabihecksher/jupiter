using ParserCombinator
using Nullables

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
mutable struct Bind<:Node val end
mutable struct Ref<:Node val end
mutable struct Blk<:Node val end


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

        expression = (arith_expression | bool_expression | and_or) #|> Ref


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

        var = Delayed()
        let_var = Delayed()


        cmd = let_var | assign | loop | expression | conditional | cseq

        # conditional.matcher = Nullable{Matcher}((E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"end") | (E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"else" + spc + cmd + spc + E"end") |> Cond)

        conditional.matcher = Nullable{Matcher}((E"if" + spc + bool_expression + spc + E"then" + spc + cmd + spc + E"else" + spc + cmd + spc + E"end") |> Cond)

        assign.matcher = Nullable{Matcher}((identifier + E":=" + expression) | (E"(" + identifier + E":=" + expression + E")") |> Assign)

        loop.matcher = Nullable{Matcher}((E"while" + spc + expression + spc + E"do" + spc + cmd) | (E"(" + E"while" + spc + expression + spc + E"do" + spc + cmd + E")") |> Loop)

        cseq.matcher = Nullable{Matcher}((cmd + spc + cmd) |> CSeq)


    ##################### IMP-1 ######################################


        var.matcher = Nullable{Matcher}((E"var" +  spc + identifier + spc + E"=" + spc + expression) |> Bind)
        let_var.matcher =  Nullable{Matcher}((E"let" + spc + var + spc + E"in" + spc + cmd) |> Blk)

        teste = cmd + Eos()


    end

end
