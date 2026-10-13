# Generate Philippine cities/municipalities

Generate Philippine cities/municipalities

## Usage

``` r
fkr_city(n, province = NULL, region = NULL)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- province:

  Optional province name to restrict the draw to.

- region:

  Optional region name to restrict the draw to.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_city(5)
#> [1] "Taguig"        "Tacloban City" "Mamburao"      "Naval"        
#> [5] "Malabon"      
fkr_city(5, province = "Cebu")
#> [1] "Mandaue City" "Cebu City"    "Cebu City"    "Cebu City"    "Cebu City"   
```
