# Generate company names

Builds realistic Philippine business names by combining one or two
surnames, a business-type word, and a corporate suffix (e.g.
`"Dela Cruz Trading Corp."`, `"Santos & Reyes Enterprises, Inc."`).

## Usage

``` r
fkr_company(n)
```

## Arguments

- n:

  Number of company names to generate. A single non-negative whole
  number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_company(5)
#> [1] "Cruz & Pangan General Services Inc." "Dela Cruz Realty Co."               
#> [3] "Ramos Holdings Co."                  "Agustin & Rosales Enterprises Ltd." 
#> [5] "Reyes Consultancy Ltd."             
```
