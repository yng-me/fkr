# Seed fkr's random number generation

A thin, self-documenting wrapper around
[`set.seed()`](https://rdrr.io/r/base/Random.html) so a whole sequence
of `fkr_*()` calls can be made reproducible.

## Usage

``` r
fkr_seed(seed)
```

## Arguments

- seed:

  A single whole number.

## Value

`NULL`, invisibly. Called for its side effect.

## Examples

``` r
fkr_seed(123)
fkr_first_name(3)
#> [1] "Palmer"   "Ram"      "Gulliver"
```
