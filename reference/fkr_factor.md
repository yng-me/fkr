# Generate a factor variable with value labels and an optional variable label

Draws from `values` (the underlying, often numeric, codes) and returns a
[`factor()`](https://rdrr.io/r/base/factor.html) over them, optionally
relabeled with human-readable `labels` (the value set) and tagged with a
`label` (a variable-level description), mirroring the "variable label" /
"value labels" distinction common in survey/statistical data (e.g. SPSS,
Stata, haven).

## Usage

``` r
fkr_factor(n, values, labels = NULL, label = NULL, prob = NULL)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- values:

  A non-empty atomic vector of underlying codes/levels, with no `NA`s
  (e.g. `c(1, 2)` or `c("M", "F")`).

- labels:

  Optional character vector of display labels, the same length as
  `values` and in the same order (e.g. `c("Male", "Female")` for
  `values = c(1, 2)`). If `NULL` (default), `values` are used as their
  own labels, as in a plain
  [`factor()`](https://rdrr.io/r/base/factor.html).

- label:

  Optional single string describing the variable itself (e.g.
  `"Respondent's biological sex"`), attached as `attr(x, "label")` – not
  to be confused with `labels`, the per-value display text.

- prob:

  Optional numeric vector of sampling weights, the same length as
  `values`. Default `NULL` draws every value with equal probability.

## Value

A `factor` of length `n` with levels `values` (coerced to character, per
[`factor()`](https://rdrr.io/r/base/factor.html)'s usual behavior) and,
if given, an `attr(x, "label")` variable description. Note that
[`as.integer()`](https://rdrr.io/r/base/integer.html) on the result
gives each value's *position* in `values`, not the original code – use
[`levels()`](https://rdrr.io/r/base/levels.html) or
[`as.character()`](https://rdrr.io/r/base/character.html) to recover the
original values.

## Examples

``` r
fkr_factor(5, values = c(1, 2), labels = c("Male", "Female"))
#> [1] Male   Male   Male   Female Male  
#> Levels: Male Female
fkr_factor(5,
  values = c(1, 2), labels = c("Male", "Female"),
  label = "Respondent's biological sex"
)
#> [1] Female Female Female Female Female
#> attr(,"label")
#> [1] Respondent's biological sex
#> Levels: Male Female
fkr_factor(5, values = c(1, 2, 3), prob = c(0.7, 0.2, 0.1))
#> [1] 1 1 1 1 1
#> Levels: 1 2 3
```
