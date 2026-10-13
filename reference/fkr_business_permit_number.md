# Generate business/mayor's permit-style numbers

Produces values matching the `BP-YYYY-NNNNNN` format commonly used by
local government Business Permits and Licensing Offices (BPLOs). **The
digits are uniformly random** and do not correspond to any real
business; see the package-level disclaimer in
[`?fkr`](https://yng-me.github.io/fkr/reference/fkr.md).

## Usage

``` r
fkr_business_permit_number(n, year = as.integer(format(Sys.Date(), "%Y")))
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- year:

  Permit year. Default is the current year. Must be a single 4-digit
  whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_business_permit_number(5)
#> [1] "BP-2026-781979" "BP-2026-348464" "BP-2026-531027" "BP-2026-850348"
#> [5] "BP-2026-473084"
fkr_business_permit_number(5, year = 2023)
#> [1] "BP-2023-043998" "BP-2023-744551" "BP-2023-173974" "BP-2023-477633"
#> [5] "BP-2023-093888"
```
