# Introdu��o ao R - Econometria 1

# Exemplo 1: [Dado] Experimento de jogar um dado
sample(1:6,1)

#Exerc�cio 1: 
# Em uma loteria, toda semana s�o sorteados 6 de 49 n�meros �nicos. 
# Qual o n�mero vencedor da loteria?
#-------------------------------------
#-------------------------------------

# [Dado] Vetor das Probabilidades 
probabilidade <- rep(1/6, 6) 

#[Dado]  Gr�fico das Probabilidades
plot(probabilidade, 
     main = "Distribui��o de Probabilidade",
     xlab = "resultados")

# [Dado] Vetor da  Distribui��o da Probabilidade Acumulada 
prob_acumulada <- cumsum(probabilidade) 

# [Dado] Gr�fica da Distribui��o Acumulada
plot(prob_acumulada, 
     xlab = "resultados", 
     main = "Distribui��o Acumulada") 

# Exerc�cio Extra 1: Qual o vetor, gr�fico das probabilidades e  da probabilidade acumulada 
# se o dado tivesse 12 lados?
#-------------------------------------
#-------------------------------------

# [Dado] Valor Esperado

## Sem usar a f�rmula
media_dado <- 1*1/6+ 2*1/6+ 3*1/6+ 4*1/6+ 5*1/6+ 6*1/6
media_dado 

## Usando a f�rmula
media_dado_f <-mean(1:6)
media_dado_f

# [Dado] Vari�ncia

## Sem usar a f�rmula
variancia_pop <- 1/6*sum((1:6 -3.5)^2)
variancia_amos <- 1/(6-1)*sum((1:6 -3.5)^2)                         

## Usando a f�rmula
variancia <- var(1:6)


#-------vari�veis cont�nuas------------

# Fun��es
f <-  function(x){ x^2 + 2*x }

## Calculando a fun��o em x=3
f(3)


# Integrais

## Escreve a fun��o
z <- function(x){ 1/x^2 }

## Integre a fun��o
integral_z <- integrate(z,
                        lower = 1,
                        upper = Inf)$value
integral_z



