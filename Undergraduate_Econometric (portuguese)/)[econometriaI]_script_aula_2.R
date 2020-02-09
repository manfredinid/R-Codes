# Introdução ao R - Econometria 1
# Aula 2

#------------------------
# Como eu deleto um elemento do environment?
#rm(elemento que quero deletar)

# Como limpo o console?
# No Rstudio é CTRL+L

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


# Exercício 2: Escreva a função w(x)=e^-x
#-------------------------------------
#-------------------------------------

# Exercício 3: Integre a função do exercício 2 de -infinito até +infinito
#-------------------------------------
#-------------------------------------

# Esperança

## Defina a FDP
f <- function(x){x/4*exp(-x^2/8)}

## Defina a função ex
ex <- function(x)x*f(x)

## Calcule o valor esperado de X
expected_value <- integrate(ex, 0, Inf)$value

# Variância

## Defina a função ex2
ex2 <- function(x)x^2*f(x)

## Calcule a variância de X
variance <- integrate(ex2, 0, Inf)$value - expected_value^2



#-------distribuição normal------------

## Escrevendo a fórmula da Normal
normal <- function(x){ 1 /sqrt(2*pi*1)*exp(-(x-0)^2/(2*1^2))}

## Gráfico de uma N(0,1)
curve(dnorm(x),
      xlim = c(-3.5, 3.5),
      ylab = "Densidade", 
      main = "Função de Densidade de uma Normal Padrão") 

## Gráfico de uma N(0,1) - usando a função feita 'a mão'
curve(normal(x),
      xlim = c(-3.5, 3.5),
      ylab = "Densidade", 
      main = "Função de Densidade de uma Normal Padrão") 

## Funções
### dnorm(x,mean,sd) - FDP da normal
### pnorm(q,mean,sd) - probabilidade acumulada
### rnorm(n,mean,sd) - simula dado de uma normal


#-------distribuição amostral da média------------


# Lei dos Grandes Números

## Exemplo da repetição da jogada de um dado
dado <- 1:6
roll <- function(n) {
  mean(sample(dado, size = n, replace = TRUE))
}

### rep é o número de repetições - mude para testar diferentes números de repetições
rep <- 1000
plot(sapply(1:rep, roll), type = "l", xlab = "jogadas", ylab = "média")

### desenha a linha da média do experimento (3.5)
abline(h = 3.5, col = "red")


# Teorema do Limite Central

### rep1 é o número de repetições - mude para testar diferentes números de repetições
rep1 <- 5000

## gera números aleatórios de uma N(0,1)
 x <- rnorm(rep1,mean=0,sd=1)
 
## histograma das repetições 
hist(x,prob=TRUE, main = paste("Histograma" ),
     xlab = "x",
     ylab= "Densidade")

### desenha uma N(0,1))
curve(dnorm(x,mean=0,sd=1),add=TRUE,lwd=2,col="red")


#------- intervalo de confiança ------------

##### Qual o preço médio dos imóveis em Windsor, Canadá?


# importar os dados externos
library(readr)
windsor_pop <- read_csv("windsor_pop.csv")
                    
                    # tem que substituir pelo caminho do arquivo
                       
View(windsor_pop)

# se tivermos o pacote dplyr podemos tirar amostrar da base original
# aqui são retiradas amostras de 50% da populaçao dos dados (.5)

# tira amostras dos dados originais
##library(dplyr)
##set.seed(123)
##windsor_sample <- sample_frac(windsor_pop, .5)


# importa amostra (essa planilha foi gerada com a função comentada acima)
windsor_sample <- read_csv("windsor_sample.csv")
View(windsor_sample)


######## gráfico do slide ##########
# cria 100 médias amostrais
#library(dplyr)
#sample_mean <- vector(mode = "double", length = 100)
#for(i in seq_along(sample_mean)) {
#  set.seed(i)
#  sample <- sample_frac(windsor_pop, .5)
#  mean_stat <- mean(sample$price)
#  sample_mean[i] <- mean_stat
#}

#hist(sample_mean, main="Histograma das Médias", ylab="frequência", xlab="médias amostrais")
#abline(v = mean(sample_mean), col = "red")          # média das 100 médias amostrais
#abline(v = mean(windsor_pop$price), col = "blue") # média da população

###############################


# Parâmetros para o IC
x <- windsor_sample$price
xbar <- mean(x) # média
multi <- qt(.975, df = length(x) - 1) # t-Student
sigma <- sd(x) # desvio padrão
denom <- sqrt(length(x)) # raiz quadrada de n

# calcula o erro padrão
se <- multi * (sigma / denom)

# intervalo inferior e superior
xbar + c(-se, se)

## usando a função t.test

# nomeia a função 
ttest <- t.test(windsor_sample$price, conf.level = 0.95)

# mostra apenas o resultado do IC

ttest$conf.in


### Preço médio dos imóveis em Windor com nível de significância de 0,05?
# mostra os dois intervalo
rbind(c(ttest$conf.in), c(xbar + c(-se, se)))


#------- teste de hipótese ------------

# Existe diferença significativa na média das notas dos filmes lançados em 2015.

# importa dados
library(readr)
movies <- read_csv("IMDB-Movie-Data.csv")
View(movies)

year2015 <-subset(movies, Year == '2015')
View(year2015)

# define os dados
sample <- year2015$Metascore
pop <- movies$Metascore

sample_mean <- mean(sample) # média da amostra
pop_mean <- mean(pop) # média da população
n <- length(sample) # tamanho da amostra
var <- var(sample) # variância da amostra

# calcula o teste-t
tstatistic <- (sample_mean - pop_mean) / (sqrt(var/(n)))
tstatistic

# usando a função t-test
# nomeia a função t.test
tstatistic_f <- t.test(year2015$Metascore, mu = mean(movies$Metascore))
tstatistic_f$statistic

# mostra as duas estatíticas
c(tstatistic_f$statistic, tstatistic)

# Comparando com o valor tabelado
df<-length(year2015$Metascore) -1 # grau de liberdade
qt(0.975,df) # valor tabelado da distribuição t (superior)
qt(0.025,df) # valor tabelado da distribuição t (inferior)

# se rejeita a hipótese nula |estat.calculada| > valor.tabelado_superior
# rejeita H0 se estat.calculada > valor.tabelado_superior ou estat.calculada < valor.tabelado_inferior
# se a estatística calculada cai nas caudas rejeitamos a hipótese nula
# se TRUE rejeitamos a hipótese nula | se FALSE não rejeitamos a hipótese nula
abs(tstatistic) > qt(0.025,df) # Rejeitamos a hipótese nula?


#### EXERCICIOS ########

# Exercício 4: Escreva a função f(x)=(x/4)e^(-x^2/8)
#-------------------------------------

#-------------------------------------

# Exercício 5: Confira se função do exercício 2 é um FDP
#-------------------------------------

#-------------------------------------

# Exercício 6: Encontre a esperança e variância para f(x)=3/x^4
#-------------------------------------

#-------------------------------------

# Exercício 7: Seja z ~ N(0,1).
# Calcule valor da densidade da normal padrão em c = 3
#-------------------------------------

#-------------------------------------

# Exercício 8: Seja Y ~ N(2,12).
# Gere 5 números aleatórios dessa distribuição
#-------------------------------------

#-------------------------------------

# Exercício 9: Seja Z ~ N(0,1).
# Calcule P(|Z|<=z)
#-------------------------------------

#-------------------------------------

# Exercício 10: Qual o preço médio dos imóveis com 3 quartos da mostra de Windsor, Canadá?
# Use os dados do windsor_sample
# Use um intervalo de 95% de confiança
#-------------------------------------

#-------------------------------------


# Exercício 11: Existe diferença significativa na média das notas dos filmes com menos de 120 minutos?
# Faça time120 <-subset(movies, Runtime < '120')
# Teste continua sendo bicaudal 
#-------------------------------------

#-------------------------------------

