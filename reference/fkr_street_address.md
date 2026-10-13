# Generate street addresses

Generates a house/unit number followed by a common Philippine street
name and street type (e.g. `"482 Mabini Street"`).

## Usage

``` r
fkr_street_address(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_street_address(5)
#> [1] "374 Quezon Street"            "818 Maharlika Highway Street"
#> [3] "34 Shaw Boulevard Road"       "516 Commonwealth Extension"  
#> [5] "13 Maharlika Highway Street" 
```
