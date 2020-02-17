Credit Model Calibration
================
Denise Manfredini
07/02/2020

Data for the transiiton path calibration.

## GDP Measured by Components of Demand

<details>

<summary>Click to
expand</summary>

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

</details>

# Labor and Capital Markets

## Employment and Hours of Work

``` diff
+ Population is divided between PIA and PINA.
+ PIA (eng:AP) is divided between PEA and PNEA.
+ PEA (eng:EAP) is divided between employed and unemployed.
```

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

## Credit Market

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Monthly (%p.m.) start in March 2011

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

    ##      [,1] [,2]
    ## [1,] 3.65 0.91

    ##      [,1] [,2]
    ## [1,] 2.16 0.56

# Adjusting to real values

## Deflate series

The series are deflated using the IPCA

<details>

<summary>Click to
expand</summary>

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

</details>

## Per capita and HP filter Series

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

# Population and Technology Discount Factors

*Gamma* is the tecnology discount factor.

*Eta* is the population discount factor.

    ##           eta    gamma
    ## [1,] 1.002411 1.004923

    ##       i/y c/y
    ## [1,] 0.19 0.8

## Discount factor

*Beta* is the discount factor.

    ## [1] 0.92

# Final Calibration

All series are expressed in per capita terms after dividing by the
population in active age, those aged 15 to 64.

The measure of **GDP** is the current price GDP from the CNT/IBGE
deflated by the IPCA

    ##      mean   sd
    ## [1,] 9.93 0.16

The **capital stock** is measure using *perpetual inventory* method,
using the s data on investment, an initial capital stock, and an
estimate of the rate of depreciation we constructed a series using the
accumulation equation for
capital.

``` diff
+ The initial value is the same measure by Lama (2011), but the ratios are VERY different.
```

    ##       mean sd  
    ## [1,] 11.11  0 2

The measure of **consumption** is the sum of consumption and government
spending from CNT/IBGE.

    ##      mean   sd
    ## [1,] 9.71 0.16

**Investment** is measured as the gross fixed capital formation from
CNT/IBGE.

    ##      mean   sd
    ## [1,] 8.25 0.23

**Total hours worked** is measured by the fraction of hours worked by
the AP population. Fraction of employed population is the proportion of
employed population to total. population in active age.

    ##         mean       sd
    ## [1,] 7999489 801217.4

## Real data in Levels (deseasonalized data)

``` diff
+  Detrended by the rate of technological progress (gamma).
```

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

## Graphs (introduction)

<details>

<summary>Click to
    expand</summary>

    ## Saving 7 x 5 in image

    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.

    ## Saving 7 x 5 in image

    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.

    ## Saving 7 x 5 in image

    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.
    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.
    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.
    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.

![](credit_model_calibration_files/figure-gfm/warning==FALSE-1.png)<!-- -->

    ## Saving 7 x 5 in image

    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.
    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.
    ## Don't know how to automatically pick scale for object of type ts. Defaulting to continuous.

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

    ## Time Series:
    ## Start = 2008 
    ## End = 2016 
    ## Frequency = 1 
    ##      round(households/total * 100, 1) round(firms/total * 100, 1)
    ## 2008                             36.1                        63.9
    ## 2009                             33.9                        66.1
    ## 2010                             33.5                        66.5
    ## 2011                             36.0                        64.0
    ## 2012                             38.9                        61.1
    ## 2013                             41.2                        58.8
    ## 2014                             43.5                        56.5
    ## 2015                             44.7                        55.3
    ## 2016                             46.9                        53.1
    ##      round(rural/firms * 100, 1) round(realestate/firms * 100, 1)
    ## 2008                        12.8                              3.1
    ## 2009                        10.7                              4.1
    ## 2010                         9.1                              4.8
    ## 2011                         8.9                              6.0
    ## 2012                         8.5                              7.2
    ## 2013                         9.0                              7.5
    ## 2014                         9.9                              8.1
    ## 2015                         8.9                              8.3
    ## 2016                         9.3                              8.7
    ##      round(BNDES/firms * 100, 1) round(other/firms * 100, 1)
    ## 2008                        70.2                        13.9
    ## 2009                        73.3                        11.9
    ## 2010                        76.6                         9.5
    ## 2011                        77.4                         7.7
    ## 2012                        77.2                         7.1
    ## 2013                        74.6                         8.9
    ## 2014                        73.2                         8.8
    ## 2015                        73.0                         9.8
    ## 2016                        71.0                        11.1

</details>

## Data in logs

    ##                 2011     2015
    ## consumption 9.636931 9.600179
    ## investment  8.288929 7.975681
    ## output      9.871980 9.772580

# Policy design

The transition path will be computed as a transition from the minimum
non-earmarked earmarked ration gap to the
maximum.

![](credit_model_calibration_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

    ##      max  min
    ## [1,] 4.2 3.51
