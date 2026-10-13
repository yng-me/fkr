# Generate Philippine ZIP codes

Generate Philippine ZIP codes

## Usage

``` r
fkr_zip_code(n, province = NULL, city = NULL)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- province:

  Optional province name to restrict the draw to.

- city:

  Optional city/municipality name to restrict the draw to.

## Value

A character vector of length `n` of 4-digit ZIP codes.

## Examples

``` r
fkr_zip_code(5)
#> [1] "5000" "9000" "8300" "1100" "4301"
fkr_zip_code(5, city = "Davao City")
#> [1] "8000" "8000" "8000" "8000" "8000"
```
