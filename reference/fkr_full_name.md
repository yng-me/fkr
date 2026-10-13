# Generate full Filipino names

Combines
[`fkr_first_name()`](https://yng-me.github.io/fkr/reference/fkr_first_name.md)
and
[`fkr_last_name()`](https://yng-me.github.io/fkr/reference/fkr_last_name.md),
optionally with a middle initial, in the common Filipino "First Middle.
Last" convention.

## Usage

``` r
fkr_full_name(n, sex = c("any", "male", "female"), middle_initial = FALSE)
```

## Arguments

- n:

  Number of names to generate. A single non-negative whole number.

- sex:

  Restrict the given name to `"male"`, `"female"`, or `"any"` (default).

- middle_initial:

  If `TRUE`, include a random middle initial (e.g.
  `"Juan D. Dela Cruz"`). Default `FALSE`.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_full_name(5)
#> [1] "Gene Ramos"       "Nigel Garcia"     "Plato Rivera"     "Erik Perez"      
#> [5] "Johnson Gonzales"
fkr_full_name(5, sex = "male", middle_initial = TRUE)
#> [1] "Scot L. Dela Cruz"    "Nicholas R. Gonzales" "Justin L. Mahinay"   
#> [4] "Lance G. Fernando"    "William D. Buenafe"  
```
