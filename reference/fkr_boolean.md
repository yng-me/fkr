# Generate boolean values

Generate boolean values

## Usage

``` r
fkr_boolean(n, prob = 0.5)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- prob:

  Probability of drawing `TRUE`. Default `0.5`.

## Value

A logical vector of length `n`.

## Examples

``` r
fkr_boolean(5)
#> [1]  TRUE  TRUE FALSE FALSE  TRUE
fkr_boolean(5, prob = 0.9)
#> [1]  TRUE FALSE  TRUE  TRUE  TRUE
```
