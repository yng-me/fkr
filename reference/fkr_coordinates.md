# Generate Philippine latitude/longitude coordinates

Draws a point uniformly at random within the decimal-degree bounding box
of the Philippines, or of a single region if `region` is given. Bounding
boxes are region-level approximations (not survey-grade), so a point is
guaranteed to fall in roughly the right part of the archipelago, not
necessarily on land.

## Usage

``` r
fkr_coordinates(n, region = NULL, precision = 10)
```

## Arguments

- n:

  Number of coordinate pairs to generate. A single non-negative whole
  number.

- region:

  Optional region name to restrict the draw to (one of
  [`fkr_region()`](https://yng-me.github.io/fkr/reference/fkr_region.md)'s
  possible outputs). If `NULL` (default), draws from the bounding box of
  the whole country.

- precision:

  Number of decimal places to round `latitude`/ `longitude` to. Default
  `10`.

## Value

A `data.frame` with `n` rows and numeric columns `latitude` and
`longitude`, each rounded to `precision` decimal places.

## Examples

``` r
fkr_coordinates(5)
#>    latitude longitude
#> 1  5.751349  125.0229
#> 2 17.010423  119.5854
#> 3 11.207030  122.5942
#> 4  6.127413  125.0163
#> 5  9.265892  117.5902
fkr_coordinates(5, region = "National Capital Region (NCR)")
#>   latitude longitude
#> 1 14.65219  121.1321
#> 2 14.65049  120.9576
#> 3 14.54950  120.9555
#> 4 14.53788  121.0051
#> 5 14.59174  120.9834
```
