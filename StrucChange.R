#carregando o pacote
library(strucchange)

#carregando os dados
div<-read.csv("~/Dados - R/Shiller_2016_div.csv", sep=";", dec=",")

#validando utilização dos dados
attach(div)


#definindo a série temporal
g<- ts(data = div, start = 1871, end = 2016, frequency = 12, deltat = 1/12)

#plotando a série
ts.plot(g ,xlab="ano", ylab="Taxa Pre�o-Dividendo" )

#estimando os pontos de quebra
bp.g <- breakpoints(g~1, h=150)

#plotando os candidatos a pontos de quebra estrutural
plot(bp.g)

#avaliando a série com 2 pontos de quebra
bp2 <- breakpoints(bp.g, breaks = 09)

#usando OLS-CUSUM para avaliar se existem outros pontos de quebra na média
ocus.g <- efp(g ~ breakfactor(bp2), type = "OLS-CUSUM")
plot(ocus.g)

#denise testando através do intervalo de confiança
ci.g <- confint(bp.g, breaks =094)
lines(ci.g)

#plotando, com ic, os pontos de quebra
plot(g)

# fit and visualize segmented and unsegmented model
fm0 <- lm(g ~ 1)
fm1 <- lm(g ~ breakfactor(bp2))
lines(fitted(fm0), col = 3)
lines(fitted(fm1), col = 4)
lines(bp.g, breaks = 09)
bp2
