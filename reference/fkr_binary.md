# Generate binary (0/1) values

Generate binary (0/1) values

## Usage

``` r
fkr_binary(n, values = c(0L, 1L), prob = 0.5)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- values:

  The two values to draw from, as `c(value_for_0, value_for_1)`. Default
  `c(0L, 1L)`.

- prob:

  Probability of drawing `values[2]`. Default `0.5`.

## Value

A vector of length `n`, with the same type as `values`.

## Examples

``` r
fkr_binary(5)
#> [1] 0 1 0 0 0
fkr_binary(5, values = c("No", "Yes"), prob = 0.8)
#> [1] "Yes" "Yes" "Yes" "Yes" "Yes"
```
