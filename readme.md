![alt text](https://i.imgur.com/tGLQy92.png)

# Jupiter, the Julia Compiler

Install environment:
`make install`

Run file:
`julia-1.0.0/bin/julia  "filename".jl`

Clean environment:
`make clean`

Demonstração das denotações:

Função Automaton:
`δ(Num(N) :: C, V, S) = δ(C, N :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-num.png?raw=true)

`δ(Sum(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #SUM :: C, V, S)
δ(#SUM :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ + N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-sum.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-sum.png?raw=true)




Função Automaton
Recebe como parâmetro os elementos que definem o estado atual do autômato: pilha de controle, pilha de valores, ambiente e memória
![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/function-automaton.png?raw=true)
