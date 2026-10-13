# Generate ages

Draws `n` ages from `age_range`, weighted by an exponential decay so
that, like a real population pyramid, younger ages are more common than
older ones by default.

## Usage

``` r
fkr_age(n, age_range = 0:130, bias = -0.05)
```

## Arguments

- n:

  Number of ages to generate. A single non-negative whole number.

- age_range:

  Integer vector of candidate ages. Default `0:130`. All values must be
  non-negative.

- bias:

  Exponential decay rate applied over `age_range` (`exp(bias * age)`).
  Negative values (the default, `-0.05`) make younger ages more likely;
  `0` makes every age in `age_range` equally likely; positive values
  make older ages more likely.

## Value

An integer vector of length `n`.

## Examples

``` r
fkr_age(5)
#> [1] 18 17  1  0 20
fkr_age(5, age_range = 18:65, bias = 0)
#> [1] 63 47 45 44 18
```
