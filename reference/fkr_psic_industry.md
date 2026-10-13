# Generate PSIC-classified industries

Draws industry/economic-activity titles from the Philippine Standard
Industrial Classification (PSIC), the Philippine Statistics Authority's
official industry taxonomy (aligned with ISIC Rev. 4), together with
their real classification code. Complements
[`fkr_industry()`](https://yng-me.github.io/fkr/reference/fkr_industry.md),
which draws from an informal, uncoded list.

## Usage

``` r
fkr_psic_industry(
  n,
  level = c("divisions", "sections", "groups", "classes", "sub-classes"),
  section = NULL
)
```

## Arguments

- n:

  Number of industries to generate. A single non-negative whole number.

- level:

  PSIC hierarchy level to draw from: `"sections"` (broadest, e.g.
  "Manufacturing"), `"divisions"`, `"groups"`, `"classes"`, or
  `"sub-classes"` (most specific). Default `"divisions"`.

- section:

  Optional section title to restrict the draw to (e.g.
  `"Manufacturing"`, `"Construction"`). See `fkr_psic_industry()`'s
  `section` output column for valid values.

## Value

A `data.frame` with `n` rows and columns `title` (the industry/activity
title), `psic_code` (its PSIC code), and `section` (its top-level PSIC
section title).

## Details

Data is fetched live via the phscs package (which caches its data
locally after the first call) and kept in memory for the rest of the R
session, so the first call in a session may require network access.

## Examples

``` r
if (FALSE) { # interactive()
fkr_psic_industry(5)
fkr_psic_industry(5, level = "sections")
fkr_psic_industry(5, section = "Manufacturing")
}
```
