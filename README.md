cmip
====



[![Build Status](https://travis-ci.org/ropenscilabs/cmip.svg?branch=master)](https://travis-ci.org/ropenscilabs/cmip)

Client for CMIP data

[CMIP Data available via FTP](http://gdo-dcp.ucllnl.org/downscaled_cmip_projections/dcpInterface.html#Projections:%20Complete%20Archives)

## Install

Development version


```r
devtools::install_github("ropenscilabs/cmip")
```


```r
library("cmip")
```

## List files


```r
head(list_files('bcsd/yearly'))
#>         date            file
#> 1 2007-09-16   bccr_bcm2_0.1
#> 2 2007-09-16 cccma_cgcm3_1.1
#> 3 2007-09-17 cccma_cgcm3_1.2
#> 4 2007-09-17 cccma_cgcm3_1.3
#> 5 2007-09-17 cccma_cgcm3_1.4
#> 6 2007-09-17 cccma_cgcm3_1.5
head(list_files('bcsd/yearly/cccma_cgcm3_1.1'))
#>         date                                         file
#> 1 2007-09-16 cccma_cgcm3_1.1.sresa1b.monthly.Prcp.1950.nc
#> 2 2007-09-16 cccma_cgcm3_1.1.sresa1b.monthly.Prcp.1951.nc
#> 3 2007-09-16 cccma_cgcm3_1.1.sresa1b.monthly.Prcp.1952.nc
#> 4 2007-09-16 cccma_cgcm3_1.1.sresa1b.monthly.Prcp.1953.nc
#> 5 2007-09-16 cccma_cgcm3_1.1.sresa1b.monthly.Prcp.1954.nc
#> 6 2007-09-16 cccma_cgcm3_1.1.sresa1b.monthly.Prcp.1955.nc
```

## Download data


```r
key <- "bcsd/yearly/cnrm_cm3.1/cnrm_cm3.1.sresa1b.monthly.Prcp.2034.nc"
(res <- cmip_fetch(key))
#> <CMIP file>
#>    File: /Users/sacmac/Library/Caches/cmip/cnrm_cm3.1.sresa1b.monthly.Prcp.2034.nc
#>    File size: 4.93842 MB
```

## Read data into R

Can load in a single file (gives `RasterLayer`), or many (gives `RasterBrick`)


```r
out <- cmip_read(res)
```

## Plot


```r
library("sp")
plot(out)
```

![](inst/img/unnamed-chunk-7-1.png)


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/cmip/issues).
* License: MIT
* Get citation information for `cmip` in R doing `citation(package = 'cmip')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![rofooter](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)