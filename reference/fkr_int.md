# Generate whole numbers

Draws integers uniformly at random between `min` and `max`, inclusive.

## Usage

``` r
fkr_int(n, min = 0, max = 100)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- min:

  Minimum value (inclusive). Default `0`.

- max:

  Maximum value (inclusive). Default `100`. Must be `>= min`.

## Value

An integer vector of length `n`.

## Examples

``` r
fkr_int(5)
#> [1] 88 72 20 20 78
fkr_int(5, min = 18, max = 65)
#> [1] 54 41 31 24 44
```
