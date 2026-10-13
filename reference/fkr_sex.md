# Generate biological sex

Generate biological sex

## Usage

``` r
fkr_sex(n, levels = c("Male", "Female"))
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- levels:

  Labels to use for the two sexes, as `c(male_label, female_label)`.
  Defaults to `c("Male", "Female")`.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_sex(5)
#> [1] "Female" "Male"   "Female" "Female" "Female"
```
