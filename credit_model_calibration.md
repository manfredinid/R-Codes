Credit Model Calibration
================
Denise Manfredini
07/02/2020

Teste teste teste 99999

okokokokokokokokokok

okokokokokokkkkkkk

## Measured by Components of Demand

``` r
# From IBGE (quarterly)
GDP.sidra <- get_sidra(api='/t/1846/n1/all/v/all/p/last%2075/c11255/90707/d/v585%200')
GDP.sidra = ts(GDP.sidra$Valor,  start=c(2001,01), freq=4)

# Consumption
consumption <- get_sidra(api='/t/1846/n1/all/v/all/p/last%2075/c11255/93404/d/v585%200')
consumption <-ts(consumption$Valor,  start=c(2001,01), freq=4)

# Government Spending
government<- get_sidra(api='/t/1846/n1/all/v/all/p/last%2075/c11255/93405/d/v585%200')
government <-ts(government$Valor,  start=c(2001,01), freq=4)

# Gross Fixed Capital Formation
capitalformation<- get_sidra(api='/t/1846/n1/all/v/all/p/last%2075/c11255/93406/d/v585%200')
capitalformation <-ts(capitalformation$Valor,  start=c(2001,01), freq=4)

# capital stock
stock<- get_sidra(api='/t/1846/n1/all/v/all/p/last%2075/c11255/102880/d/v585%200')
stock <-ts(stock$Valor,  start=c(2001,01), freq=4)

# Exports
exports<- get_sidra(api='/t/1846/n1/all/v/all/p/last%2075/c11255/93407/d/v585%200')
exports <-ts(exports$Valor,  start=c(2001,01), freq=4)

# Imports
imports <- get_sidra(api='/t/1846/n1/all/v/all/p/last%2075/c11255/93408/d/v585%200')
imports <-ts(imports$Valor,  start=c(2001,01), freq=4)
```

# Labor and Capital Markets

## Employment and Hours of Work

<div class="alert alert-info">

Population is divided between PIA and PINA PIA (eng:AP) is divided
between PEA and PNEA PEA (eng:EAP) is divided between employed and
unemployed

</div>

``` r
# Active population
AP <- BETSget(10800,from = "2001-10-31")

# Economically active population
EAP <- BETSget(10810,from = "2001-10-31")

# Employed 
employed <- BETSget(10812, from ="2001-10-31")
unemployed <- BETSget(10811, from="2001-10-31")

# unemployed
employment.pop <- employed/AP


# Hours of Work
#First is march 2002 last value is Feb/2016
 
hours<- get_sidra(api='/t/2166/n110/all/v/1006/p/all/d/v1006%201')
hours <- ts(hours$Valor,  start=c(2002,03), freq=12)
```

# Credit Market

``` r
# Total
total <- BETSget(20539,from = "2007-03-01", to = "2017-12-31")

total.firms<- BETSget(20540,from = "2007-03-01", to = "2017-12-31")

total.household <- BETSget(20541,from = "2001-01-01", to = "2017-12-31")
```

    ## 
    ## BETS-package: Sorry. This series is not yet available. Series is empty in the BACEN databases

``` r
# Earmarked
earmarked <-BETSget(20593,from = "2007-03-01", to = "2017-12-31")

earmarked.firms <-BETSget(20594,from = "2007-03-01", to = "2017-12-31")
```

    ## 
    ## BETS-package: Sorry. This series is not yet available. Series is empty in the BACEN databases

``` r
earmarked.households <-BETSget(20606,from = "2007-03-01", to = "2017-12-31")

# Non-earmarked
nonearmarked <-BETSget(20542,from = "2007-03-01", to = "2017-12-31")

nonearmarked.firms <-BETSget(20543,from = "2007-03-01", to = "2017-12-31")
```

    ## 
    ## BETS-package: Sorry. This series is not yet available. Series is empty in the BACEN databases

``` r
nonearmarked.households <-BETSget(20570,from = "2007-03-01", to = "2017-12-31")
```

## Monthly (%p.m) start in March 2011

``` r
rate.nonearmarked <- BETSget(25436,from ="2011-04-01",to ="2017-03-01")

rate.earmarked <-BETSget(25481,from ="2011-04-01",to ="2017-03-01")
```

# Adjusting to real values

## Deflate series

The series are deflated using the
IPCA

``` r
actual_dates_quarter <- seq.Date(from = as.Date("2001-01-01"), to = as.Date("2019-07-01"), by = "quarter")
gdp_quarter <- deflate(GDP.sidra, actual_dates_quarter , '01/2010', index = 'ipca')

CC <- consumption 
CI <- capitalformation
CX <- (exports-imports)
CG <- government

CC <- deflate(CC, actual_dates_quarter , '01/2010', index = 'ipca')
CI <- deflate(CI, actual_dates_quarter , '01/2010', index = 'ipca')
CX <- deflate(CX, actual_dates_quarter , '01/2010', index = 'ipca')
CG <- deflate(CG, actual_dates_quarter , '01/2010', index = 'ipca')
```

## Adjust series to 2001 Q4

``` r
# AP to quarter
# from 2001/04 to 2015/04 and from thousands to unit
AP_quarter <- 1000*(aggregate(AP, nfrequency=4)/3)

# Adjust time window
AP_quarter_adj <- window(AP_quarter, start = c(2001, 4), end=c(2015,4))
gdp_quarter_adj <- window(gdp_quarter, start = c(2001, 4), end=c(2015,4))
consumption_CC_adj <- window(CC, start = c(2001, 4), end=c(2015,4))
investment_CI_adj <- window(CI, start = c(2001, 4), end=c(2015,4))
government_CG_adj <- window(CG, start = c(2001, 4), end=c(2015,4))
netexports_CX_adj <- window(CX, start = c(2001, 4), end=c(2015,4))
```

## Deseasonalize series and divide by population

``` r
# Millions to a unit
gdp_final <- (gdp_quarter_adj/AP_quarter_adj)*1000000
gdp_final <- seas(gdp_final)
gdp_final <-final(gdp_final)

investment_final <- (investment_CI_adj/AP_quarter_adj)*1000000
investment_final <- seas(investment_final)
investment_final <-final(investment_final)

consumption_final <- (consumption_CC_adj/AP_quarter_adj)*1000000
consumption_final <- seas(consumption_final)
consumption_final <-final(consumption_final)



government_final <- (government_CG_adj/AP_quarter_adj)*1000000
government_final <- seas(government_final)
government_final <-final(government_final)

netexports_final <- (netexports_CX_adj/AP_quarter_adj)*1000000
netexports_final <- seas(netexports_final)
netexports_final <-final(netexports_final)
```

## HP filter

``` r
gdp_final_filter <-  hpfilter(gdp_final, freq=6.25,type="frequency")
consumption_final_filter <-  hpfilter(consumption_final, freq=6.25,type="frequency")
investment_final_filter <-  hpfilter(investment_final, freq=6.25,type="frequency")
government_final_filter <-  hpfilter(government_final, freq=6.25,type="frequency")
netexports_final_filter <-  hpfilter(netexports_final, freq=6.25,type="frequency")
```

# Population and Technology Discount Factors

``` r
# From 2001-Q4 to 2015-Q4
gamma <- (consumption_final_filter$trend[length(consumption_final)]/consumption_final_filter$trend[1])^(1/length(consumption_final_filter$trend))

# Fix the time in the data
AP <- window(AP, start=c(2001, 12), end=c(2015, 12))

eta <- (AP[length(AP)]/AP[1])^(1/length(AP))

cbind(eta=eta, gamma=gamma)
```

    ##           eta    gamma
    ## [1,] 1.002411 1.004923

``` r
# consumption per output
# From 2001/Q4 to 2015/Q4
c_y <- (consumption_final_filter$trend+government_final_filter$trend)/gdp_final_filter$trend

i_y <- (investment_final_filter$trend)/gdp_final_filter$trend

cbind(round(mean(i_y),2), round(mean(c_y),2))
```

    ##      [,1] [,2]
    ## [1,] 0.19  0.8

## Discount factor

``` r
rate.credit <-BETSget(25433)
interest.rate<-mean(rate.credit)/100
beta <- 1-((interest.rate+1)^4 -1)
round(beta, digits = 2)
```

    ## [1] 0.92

# Final Calibration

All series are expressed in per capita terms after dividing by the
population in active age, those aged 15 to 64.

The measure of GDP is the current price GDP from the CNT/IBGE deflated
by the IPCA

``` r
y <- log(gdp_final_filter$trend)
```

capital stock: Measure using *perpetual inventory* method, using the s
data on investment, an initial capital stock, and an estimate of the
rate of depreciation we constructed a series using the accumulation
equation for capital.

*The initial value is the same measure by Lama (2011), but the ratios
are VERY different*

``` r
delta <- 0.05
initial_capital <- 60330
I <- log(investment_final_filter$trend)

k <- matrix(0, nrow = length(I), ncol = 1)
k[1] <- I[1] +(1-delta)*initial_capital

end <- length(I)-1   

   for(jj in 1:end)  {
      k[jj+1] <- investment_final[jj] +(1-delta)*k[jj]
   }
k <- ts(k, frequency=4, start=c(2001,4))
k <- seas(k)
k<-final(k)
```

The measure of consumption is the sum of consumption and government
spending from CNT/IBGE

``` r
c <- log(consumption_final_filter$trend + government_final_filter$trend)
```

Investment is measured as the gross fixed capital formation from
CNT/IBGE

``` r
i <- log(investment_final_filter$trend)
```

Total hours is measured by the fraction of hours worked by the AP
population. Fraction of employed population is the proportion of
employed population to total population in active age.

``` r
Worked.hours<-(mean(hours)/(16*7))*(employment.pop)
Worked.hours<-(aggregate(Worked.hours, nfrequency=4)/3)
Worked.hours<-ts(Worked.hours, frequency=4, start=c(2001,4))
Worked.hours<-seas(Worked.hours)
Worked.hours<-final(Worked.hours)
total.worked.hours <- Worked.hours*AP_quarter_adj
```

``` r
prog <- matrix(0,  length(c),1)
for (jj in 0:length(c))
{prog[jj] <- 1/gamma^jj}

Technological.Progress.Deflator <- ts(prog,  frequency = 4, start = c(2001, 4))

pop <- matrix(0,  length(c),1)
for (jj in 0:length(c))
{pop[jj] <- 1/eta^jj}

Populator.Deflator <- ts(pop,  frequency = 4, start = c(2001, 4))
```

## Real data in Levels (deseasonalized data)

``` r
c <- (consumption_final+government_final)*Technological.Progress.Deflator
i <- investment_final*Technological.Progress.Deflator
y <- gdp_final*Technological.Progress.Deflator
h <- Worked.hours
xm <- netexports_final*Technological.Progress.Deflator
k <- k*Technological.Progress.Deflator
```

``` r
plot.c <- autoplot(c, main='consumption')
plot.i <- autoplot(i, main='investment')
plot.y <- autoplot(y, main='output')
plot.h <- autoplot(h, main='hours')
plot.xm <- autoplot(xm, main='net exports')
plot.k <- autoplot(k, main='Capital Stock')
grid.arrange(plot.c, plot.y, plot.h,plot.i, plot.xm, plot.k, ncol=2)
```

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Table in logs

``` r
consumption2015<-log(c[((as.yearqtr("2015-04")- as.yearqtr("2001-04"))*4+1)])
investment2015<-log(i[((as.yearqtr("2015-04")- as.yearqtr("2001-04"))*4+1)])
output2015<-log(y[((as.yearqtr("2015-04")- as.yearqtr("2001-04"))*4+1)])

consumption2011=log(c[((as.yearqtr("2011-04")- as.yearqtr("2001-04"))*4+1)])
investment2011=log(i[((as.yearqtr("2011-04")- as.yearqtr("2001-04"))*4+1)])
output2011=log(y[((as.yearqtr("2011-04")- as.yearqtr("2001-04"))*4+1)])

mec<-cbind('2011'=consumption2011, '2015'=consumption2015)
mei<-cbind('2011'=investment2011, '2015'=investment2015)
meo<-cbind('2011'=output2011, '2015'=output2015)
met<- rbind(mec, mei, meo)
rownames(met)<-(c("consumption","investment","output"))
met
```

    ##                 2011     2015
    ## consumption 9.636931 9.600179
    ## investment  8.288929 7.975681
    ## output      9.871980 9.772580

# Policy design

``` r
pi_p <- seas(rate.nonearmarked/rate.earmarked)
pi_p <-final(pi_p)
pi_p <- (aggregate(pi_p, nfrequency=4)/3)
#pi_p <- ts(pi_p, start = c(2011,2))
pi_p <-  hpfilter(pi_p, freq=6.25,type="frequency")
pi_p <- pi_p$trend

autoplot(pi_p, main='non-earmarked earmarked ratio')
```

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

``` r
cbind(round(max(rate.nonearmarked/rate.earmarked),2), round(min(rate.nonearmarked/rate.earmarked),2))
```

    ##      [,1] [,2]
    ## [1,] 4.57 3.38