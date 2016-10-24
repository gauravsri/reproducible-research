User Usage report
========================================================
author: Gaurav Srivastva
date: Oct 21, 2016
autosize: true

About the project
========================================================

This project allows viewing of usage for a product by various companies.

- Filtering can be done for a range of users using the product
- Table of product usage can be customized for various columns of interest
- Searching capability for product table



Summary of Data
========================================================

Distribution of users enabled/disabled in the product for various companies

```r
summary(orgList$default_plan_code)
```

```
      license license-async  license-demo license-guest 
            7           154           106             9 
```

```r
summary(orgList$status)
```

```
GROUP_CANCELED_SUBSCRIPTION   GROUP_NORMAL_SUBSCRIPTION 
                         57                         219 
```

```r
summary(orgList$enabled_users)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    2.00   19.25    8.00 3171.00 
```

```r
summary(orgList$disabled_users)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    1.00   11.49    3.00  614.00 
```

License usage
========================================================


```
               
                 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 16 17 18 19
  license        5  0  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
  license-async 46 16 19  6  6  6  5  3  5  4  4  1  2  1  5  1  2  2  3
  license-demo  44 10 11  5  3  2  4  3  2  0  2  2  1  0  1  1  0  0  2
  license-guest  8  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
               
                20 21 22 24 25 26 27 28 30 34 35 36 38 40 41 45 50 51 62
  license        0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
  license-async  4  1  1  1  0  1  1  0  0  1  1  1  1  1  0  0  0  1  0
  license-demo   1  0  0  1  1  0  0  1  1  0  0  0  0  0  1  1  1  0  1
  license-guest  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
               
                67 72 107 122 202 3171
  license        0  0   0   0   0    0
  license-async  1  0   0   0   1    0
  license-demo   0  1   1   1   0    1
  license-guest  0  0   0   0   0    0
```

Summary
========================================================


1. There are **276** companies using the product. 
2. Out of **276** Orgs, **219** Orgs have a valid subscription and **57** have been disabled. 
