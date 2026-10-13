# Generate email addresses

Builds realistic email addresses from (optionally supplied) first and
last names, using the mix of free email providers most commonly seen in
the Philippines.

## Usage

``` r
fkr_email(n, first_name = NULL, last_name = NULL, domain = NULL)
```

## Arguments

- n:

  Number of email addresses to generate. A single non-negative whole
  number.

- first_name:

  Optional character vector of first names to build addresses from. Must
  have length 1 or length `n`. If `NULL` (default), names are drawn with
  [`fkr_first_name()`](https://yng-me.github.io/fkr/reference/fkr_first_name.md).

- last_name:

  Optional character vector of last names, same recycling rule as
  `first_name`. If `NULL` (default), names are drawn with
  [`fkr_last_name()`](https://yng-me.github.io/fkr/reference/fkr_last_name.md).

- domain:

  Optional character vector of email domains (e.g. `"gmail.com"`) to use
  instead of the default weighted provider mix. Must have length 1 or
  length `n`.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_email(5)
#> [1] "vidar_agustin764@gmail.com"   "glenda_amante@gmail.com"     
#> [3] "yaelvillar@yahoo.com"         "lotlot.delacruz673@gmail.com"
#> [5] "roxannealfonso@icloud.com"   
fkr_email(3, first_name = "Juan", last_name = "Dela Cruz")
#> [1] "juan.delacruz701@yahoo.com" "juandelacruz@outlook.com"  
#> [3] "juan.delacruz290@gmail.com"
```
