# Generate TIN-style identifiers

Produces values matching the `NNN-NNN-NNN-NNN` format used for
Philippine Bureau of Internal Revenue Tax Identification Numbers. **The
digits are uniformly random** and do not correspond to any real
taxpayer; see the package-level disclaimer in
[`?fkr`](https://yng-me.github.io/fkr/reference/fkr.md).

## Usage

``` r
fkr_tin_number(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_tin_number(5)
#> [1] "262-659-447-291" "919-530-527-270" "666-956-945-746" "328-659-861-273"
#> [5] "630-738-753-723"
```
