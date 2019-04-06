

function pega_entrada(mensagem)
    print(mensagem)
    readline()
end

entrada = pega_entrada("Escreva a expressão: ")
println("Você digitou $entrada")

tokens = split(entrada, "")
println(tokens)