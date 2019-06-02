using ParserCombinator

a = Any["Sum", Any["Num", 2], Any["Num", 3]]
println(typeof(a))
println(a)
