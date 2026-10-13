# Generate birthdates

Generates a birthdate for each of `n` simulated people by first drawing
an age with
[`fkr_age()`](https://yng-me.github.io/fkr/reference/fkr_age.md), then
drawing a uniformly random date within that age's exact 1-year window
relative to `ref_date`.

## Usage

``` r
fkr_birthday(n, ..., age = NULL, ref_date = Sys.Date())
```

## Arguments

- n:

  Number of birthdates to generate. A single non-negative whole number.

- ...:

  Passed on to
  [`fkr_age()`](https://yng-me.github.io/fkr/reference/fkr_age.md) (e.g.
  `age_range`, `bias`). Ignored if `age` is supplied.

- age:

  Optional precomputed ages (e.g. from a prior
  [`fkr_age()`](https://yng-me.github.io/fkr/reference/fkr_age.md) call)
  to generate birthdates for, instead of drawing new ones. Must be a
  non-negative numeric vector of length `n`. Passing this keeps an `age`
  column and a `date_of_birth` column consistent with each other instead
  of each being drawn independently;
  [`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md) does this
  automatically when both
  [`fkr_age()`](https://yng-me.github.io/fkr/reference/fkr_age.md) and
  `fkr_birthday()` appear (unwrapped) in the same `specs`.

- ref_date:

  Reference "today" that ages are computed against. Default
  [`Sys.Date()`](https://rdrr.io/r/base/Sys.time.html).

## Value

A `Date` vector of length `n`.

## Examples

``` r
fkr_birthday(5)
#> [1] "2024-12-13" "2020-01-07" "2022-09-05" "2020-01-31" "1982-10-03"
fkr_birthday(5, age_range = 18:65)
#> [1] "1980-06-11" "1978-06-16" "2000-08-13" "2000-08-14" "1975-06-17"

ages <- fkr_age(5, age_range = 18:65)
fkr_birthday(5, age = ages) # birthdates consistent with `ages`
#> [1] "1975-12-03" "1995-12-05" "1977-10-04" "2005-02-20" "1985-08-13"
```
