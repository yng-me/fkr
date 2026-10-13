# Generate barangay names

Draws from a curated list of barangay names that recur across many
Philippine cities and municipalities (e.g. "Poblacion", "San Isidro").

## Usage

``` r
fkr_barangay(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_barangay(5)
#> [1] "Santa Cruz"  "Pasong Tamo" "Libis"       "Guadalupe"   "Tagumpay"   
```
