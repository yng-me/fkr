# Generate Philippine provinces

Generate Philippine provinces

## Usage

``` r
fkr_province(n, region = NULL)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- region:

  Optional region name to restrict the draw to (one of
  [`fkr_region()`](https://yng-me.github.io/fkr/reference/fkr_region.md)'s
  possible outputs).

## Value

A character vector of length `n`.

## Examples

``` r
fkr_province(5)
#> [1] "Sultan Kudarat"  "Southern Leyte"  "Negros Oriental" "Romblon"        
#> [5] "Aklan"          
fkr_province(5, region = "Region VII (Central Visayas)")
#> [1] "Bohol" "Cebu"  "Bohol" "Cebu"  "Cebu" 
```
