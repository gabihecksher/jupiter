Demonstração das denotações:

`δ(Num(N) :: C, V, S) = δ(C, N :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-num.png?raw=true)

Soma

`δ(Sum(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #SUM :: C, V, S)`

`δ(#SUM :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ + N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-sum.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-sum.png?raw=true)

Subtração
`δ(Sub(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #SUB :: C, V, S)`

`δ(#SUB :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ - N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-sub.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-sub.png?raw=true)

Multiplicação
`δ(Mul(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #MUL :: C, V, S)`
`δ(#MUL :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ * N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-mul.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-mul.png?raw=true)

Divisão
`δ(Div(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #MUL :: C, V, S)`
`δ(#DIV :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ / N₂ :: V, S) if N₂ ≠ 0`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-div.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-div.png?raw=true)

Comparações

`δ(Eq(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #EQ :: C, V, S)`
`δ(#EQ :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ = B₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-eq.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-eq.png?raw=true)

`δ(Lt(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #LT :: C, V, S)`
`δ(#LT :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ < N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-lt.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-lt.png?raw=true)

`δ(Le(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #LE :: C, V, S)`
`δ(#LE :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ ≤ N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-le.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-le.png?raw=true)

`δ(Gt(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #GT :: C, V, S)`
`δ(#GT :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ > N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-gt.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-gt.png?raw=true)

`δ(Ge(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #GE :: C, V, S)`
`δ(#GE :: C, Num(N₁) :: Num(N₂) :: V, S) = δ(C, N₁ ≥ N₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-ge.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-ge.png?raw=true)

Operadores lógicos

`δ(And(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #AND :: C, V, S)`
`δ(#AND :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ ∧ B₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-and.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-and.png?raw=true)

`δ(Or(E₁, E₂) :: C, V, S) = δ(E₁ :: E₂ :: #OR :: C, V, S)`
`δ(#OR :: C, Boo(B₁) :: Boo(B₂) :: V, S) = δ(C, B₁ ∨ B₂ :: V, S)`

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/handle-or.png?raw=true)

![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/calc-or.png?raw=true)




Função Automaton
Recebe como parâmetro os elementos que definem o estado atual do autômato: pilha de controle, pilha de valores, ambiente e memória
![alt text](https://github.com/gabihecksher/jupiter/blob/master/images/function-automaton.png?raw=true)
