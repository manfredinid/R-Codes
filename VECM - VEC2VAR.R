#Rotina VECM e VEC2VAR

# carregando pacotes
library("vars")
library("pastecs")


#Importar dados - Dados.csv
Dados <- read.csv("Dados.csv", sep=";", dec=",")

#Declarar série temporal
Dados <-ts(data = Dados, start = 1930, end = 1985, frequency = 1, deltat = 1)

#matriz de dados endógenos
dados <- data.frame(Dados[,c('TC0','CI0', 'TI0')])

#vetor exógeno - dummy
exo <- data.frame(Dados[,c('dummyi')])

#estatística descritiva dos dados endógenos

stat <- stat.desc(dados)
stat



#seleção da ordem do VAR (k)
CDI<-VARselect (log(dados), type="const", lag.max = 05, exogen=exo)$selection
CDI


#teste de Johansen - vetores de cointegração
john <-ca.jo(log(dados),  type = c("trace"), ecdet="none", K=2, spec = "transitory", dumvar=exo)

if (john@teststat[1]<john@cval[, "1pct"][3]){
  R<-2
}
if (john@teststat[2]<john@cval[, "1pct"][2]){
  R<-1
}
if (john@teststat[3]<john@cval[, "1pct"][1]){
  R<-0
}  
R

#VECM, com r=1

vecm.r1 <- cajorls(john, r = 1)
summary(vecm.r1$rlm)
vecm.r1$beta

#VECM representado como VAR em níveis

vecm.level <- vec2var(john, r=1)
  

# teste de autocorrelação
arch.test(vecm.level)


#teste de hetercedasticidade 
serial.test(vecm.level, type = c("PT.asymptotic"))

#Decomposição da variância
fevd <- fevd(vecm.level)
fevd
