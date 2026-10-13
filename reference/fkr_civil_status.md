# Generate civil status

Draws from the civil status categories used on Philippine government and
civil registry forms.

## Usage

``` r
fkr_civil_status(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`, one of `"Single"`, `"Married"`,
`"Widowed"`, `"Separated"`, or `"Annulled"`.

## Examples

``` r
fkr_civil_status(5)
#> [1] "Single"    "Married"   "Single"    "Single"    "Separated"
```
