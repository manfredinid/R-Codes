# Introdução ao R - Econometria 1

# Exemplo 1: [Dado] Experimento de jogar um dado
sample(1:6,1)

#Exercício 1: 
# Em uma loteria, toda semana são sorteados 6 de 49 números únicos. 
# Qual o número vencedor da loteria?
#-------------------------------------
#-------------------------------------

# [Dado] Vetor das Probabilidades 
probabilidade <- rep(1/6, 6) 

#[Dado]  Gráfico das Probabilidades
plot(probabilidade, 
     main = "Distribuição de Probabilidade",
     xlab = "resultados")

# [Dado] Vetor da  Distribuição da Probabilidade Acumulada 
prob_acumulada <- cumsum(probabilidade) 

# [Dado] Gráfica da Distribuição Acumulada
plot(prob_acumulada, 
     xlab = "resultados", 
     main = "Distribuição Acumulada") 

# Exercício Extra 1: Qual o vetor, gráfico das probabilidades e  da probabilidade acumulada 
# se o dado tivesse 12 lados?
#-------------------------------------
#-------------------------------------

# [Dado] Valor Esperado

## Sem usar a fórmula
media_dado <- 1*1/6+ 2*1/6+ 3*1/6+ 4*1/6+ 5*1/6+ 6*1/6
media_dado 

## Usando a fórmula
media_dado_f <-mean(1:6)
media_dado_f

# [Dado] Variância

## Sem usar a fórmula
variancia_pop <- 1/6*sum((1:6 -3.5)^2)
variancia_amos <- 1/(6-1)*sum((1:6 -3.5)^2)                         

## Usando a fórmula
variancia <- var(1:6)


#-------variáveis contínuas------------

# Funções
f <-  function(x){ x^2 + 2*x }

## Calculando a função em x=3
f(3)


# Integrais

## Escreve a função
z <- function(x){ 1/x^2 }

## Integre a função
integral_z <- integrate(z,
                        lower = 1,
                        upper = Inf)$value
integral_z



