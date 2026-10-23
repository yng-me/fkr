# Generate birthdates as separate year/month/day components

A convenience wrapper around
[`fkr_birthday()`](https://yng-me.github.io/fkr/reference/fkr_birthday.md)
that splits each generated date into its year, month, and day parts –
handy for forms that collect date of birth as three separate fields.

## Usage

``` r
fkr_birthday_split(n, ..., age = NULL, ref_date = Sys.Date())
```

## Arguments

- n:

  Number of birthdates to generate. A single non-negative whole number.

- ...:

  Passed on to
  [`fkr_age()`](https://yng-me.github.io/fkr/reference/fkr_age.md) (e.g.
  `age_range`, `bias`). Ignored if `age` is supplied.

- age:

  Optional precomputed ages to generate birthdates for; see
  [`fkr_birthday()`](https://yng-me.github.io/fkr/reference/fkr_birthday.md)'s
  `age` argument.

- ref_date:

  Reference "today" that ages are computed against. Default
  [`Sys.Date()`](https://rdrr.io/r/base/Sys.time.html).

## Value

A `data.frame` with `n` rows and character columns `year` (`"YYYY"`),
`month` (`"MM"`), and `day` (`"DD"`).

## Examples

``` r
fkr_birthday_split(5)
#>   year month day
#> 1 2024    01  08
#> 2 1990    05  29
#> 3 2019    01  29
#> 4 1996    05  04
#> 5 2019    11  11
```
