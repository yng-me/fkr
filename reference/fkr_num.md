# Generate numbers

Draws numbers uniformly at random between `min` and `max`.

## Usage

``` r
fkr_num(n, min = 0, max = 1, decimals = 2)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- min:

  Minimum value (inclusive). Default `0`.

- max:

  Maximum value (inclusive). Default `1`. Must be `>= min`.

- decimals:

  Number of decimal places to round to. Default `2`.

## Value

A numeric vector of length `n`.

## Examples

``` r
fkr_num(5)
#> [1] 0.46 0.05 0.18 0.06 0.94
fkr_num(5, min = 0, max = 100, decimals = 1)
#> [1] 34.3 51.8 62.5 23.7 51.6
```
