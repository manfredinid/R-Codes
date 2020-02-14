#Rotina SVEC - Intro

#pacotes
library("vars")

#Importar dados - Dados.csv
Dados <- read.csv("~/Desktop/Dados.csv", sep=";", dec=",")

#Declarar série temporal
ts(data = Dados, start = 1930, end = 1982, frequency = 1, deltat = 1)

#matriz de dados endógenos
dados<-Dados[,c('TC0','TT0','I0', 'TI0')]

#matriz de dados exógenos
exo<-Dados[,c('EUAi', 'dummyi']

#teste de Johansen
vecm <-ca.jo(dados,  type = c("eigen"), ecdet="const", K=2, dumvar=exo)

if (vecm@teststat[1]<vecm@cval[, "5pct"][1]){
  R<-3
}
if (vecm@teststat[2]<vecm@cval[, "5pct"][2]){
  R<-2
}
if (vecm@teststat[3]<vecm@cval[, "5pct"][3]){
  R<-1
}
if (vecm@teststat[4]<vecm@cval[, "5pct"][4]){
  R<-0
}
R


#Restrições do SVEC
SR <- matrix(NA, nrow = 4, ncol = 4)
SR[4,1]<-0
SR[2,1]<-0
SR[1,3]<-0
SR[3,2]<-0
SR[4,2]<-0
SR[1,2]<-0
SR

LR <- matrix(NA, nrow = 4, ncol = 4)
LR

#SVEC
svec<-SVEC(vecm, LR = LR, SR = SR, r = R, lrtest=FALSE, boot = TRUE)


#Função impulso resposta
svec.irf <- irf( svec , impulse = c("TC0", "I0", "TT0", "TI0"), 
                 response = c("TI0", "I0", "TT0"), n.ahead = 5, boot = TRUE, ci = 0.95, runs=500)

plot(svec.irf)

#Decomposição da variância
fevd<-fevd(svec, n.ahead = 5)
plot(fevd)

summary(svec)
