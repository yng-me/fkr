# Generate prices in Philippine pesos

Draws prices on a log scale between `min` and `max` so that, like real
retail pricing, low values are much more common than high ones.

## Usage

``` r
fkr_price(n, min = 10, max = 10000, format = c("currency", "numeric"))
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- min:

  Minimum price. Default `10`.

- max:

  Maximum price. Default `10000`. Must be greater than `min`.

- format:

  `"currency"` (default) returns a formatted character vector like
  `"PHP 1,234.56"`; `"numeric"` returns a raw numeric vector rounded to
  2 decimal places.

## Value

A character vector (if `format = "currency"`) or numeric vector (if
`format = "numeric"`) of length `n`.

## Examples

``` r
fkr_price(5)
#> [1] "PHP 832.44"   "PHP 109.46"   "PHP 185.47"   "PHP 6,580.01" "PHP 141.80"  
fkr_price(5, min = 100, max = 500, format = "numeric")
#> [1] 144.47 303.73 101.60 301.71 357.57
```
