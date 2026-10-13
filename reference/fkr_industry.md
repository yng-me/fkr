# Generate industry names

Draws from industries prominent in the Philippine economy (e.g. BPO,
agriculture, remittance services).

## Usage

``` r
fkr_industry(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_industry(5)
#> [1] "Business Consulting"     "Telecommunications"     
#> [3] "Tourism and Hospitality" "Business Consulting"    
#> [5] "E-commerce"             
```
