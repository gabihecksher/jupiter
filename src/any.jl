using ParserCombinator

a = Any["Sum", Any["Num", 2], Any["Num", 3]]
println(typeof(a))
println(a)

b = Any[Sum(Any[Num(2.0), Num(5.0)])]
