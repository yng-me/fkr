# Generate Philippine Standard Geographic Code (PSGC) codes

Draws real PSGC codes – the Philippine Statistics Authority's official
hierarchical coding system for regions, provinces, cities,
municipalities, and barangays – at the requested level, optionally
restricted to a specific region/province/city.

## Usage

``` r
fkr_psgc_code(
  n,
  level = c("city", "region", "province", "municipality", "barangay"),
  region = NULL,
  province = NULL,
  city = NULL
)
```

## Arguments

- n:

  Number of codes to generate. A single non-negative whole number.

- level:

  Geographic level of the code: `"region"`, `"province"`, `"city"`,
  `"municipality"`, or `"barangay"`. Default `"city"`.

- region:

  Optional region name to restrict the draw to (see
  [`fkr_region()`](https://yng-me.github.io/fkr/reference/fkr_region.md)).

- province:

  Optional province name to restrict the draw to (see
  [`fkr_province()`](https://yng-me.github.io/fkr/reference/fkr_province.md)).

- city:

  Optional city/municipality name to restrict the draw to (useful with
  `level = "barangay"` to get barangay codes within a specific city, or
  on its own to look up a specific city's code).

## Value

A character vector of length `n` of 9- or 10-digit PSGC codes.

## Details

Codes are fetched live via the psgc package (which caches its data
locally after the first call) and kept in memory for the rest of the R
session, so the first call in a session may require network access.

## Examples

``` r
if (FALSE) { # interactive()
fkr_psgc_code(5)
fkr_psgc_code(5, level = "region")
fkr_psgc_code(5, level = "barangay", city = "Davao City")
}
```
