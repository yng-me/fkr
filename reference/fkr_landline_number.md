# Generate Philippine landline numbers

Draws landline numbers using real area codes for Metro Manila and a
curated set of major provincial cities.

## Usage

``` r
fkr_landline_number(n, area_code = NULL)
```

## Arguments

- n:

  Number of landline numbers to generate. A single non-negative whole
  number.

- area_code:

  Optional city name to restrict the area code to (one of
  `names(fkr:::.ph_landline_area_codes)`, e.g. `"Cebu"`, `"Davao"`). If
  `NULL` (default), a city is drawn at random for each number.

## Value

A character vector of length `n`, formatted as
`"(area code) subscriber number"`, e.g. `"(02) 8123 4567"` or
`"(032) 234 5678"`.

## Examples

``` r
fkr_landline_number(5)
#> [1] "(032) 049 7188" "(045) 778 3934" "(032) 936 7104" "(043) 984 7839"
#> [5] "(02) 5143 0570"
fkr_landline_number(3, area_code = "Cebu")
#> [1] "(032) 202 5763" "(032) 241 4429" "(032) 167 1960"
```
