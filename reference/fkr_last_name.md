# Generate Filipino last names (surnames)

Draws `n` surnames from the ~1,000 most common Philippine surnames,
ranked by real-world frequency (Spanish-derived names like "Dela Cruz",
"Garcia", and "Reyes" dominate the Philippine namescape). By default the
draw is weighted by that ranking, so rank-1 surnames come up far more
often than rank-1000 ones, the way they would in an actual population
sample.

## Usage

``` r
fkr_last_name(n, weighted = TRUE)
```

## Arguments

- n:

  Number of surnames to generate. A single non-negative whole number.

- weighted:

  If `TRUE` (default), weight the draw by real-world frequency rank. If
  `FALSE`, draw uniformly from all ~1,000 surnames.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_last_name(5)
#> [1] "Garcia"    "Hernandez" "Dela Cruz" "Dela Cruz" "Dela Cruz"
fkr_last_name(5, weighted = FALSE)
#> [1] "Villagracia" "Labrador"    "Clemente"    "Nicolas"     "Roxas"      
```
