# Generate company suffixes

Generate company suffixes

## Usage

``` r
fkr_company_suffix(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n` (e.g. `"Inc."`, `"Corp."`, `"OPC"`).

## Examples

``` r
fkr_company_suffix(5)
#> [1] "OPC"            "Inc."           "Ltd."           "Co."           
#> [5] "Holdings, Inc."
```
