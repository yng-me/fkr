# Generate PSOC-classified occupations

Draws occupation titles from the Philippine Standard Occupational
Classification (PSOC), the Philippine Statistics Authority's official
occupational taxonomy (aligned with ISCO-08), together with their real
classification code.

## Usage

``` r
fkr_psoc_occupation(
  n,
  level = c("unit", "minor", "sub-major", "major"),
  major_group = NULL
)
```

## Arguments

- n:

  Number of occupations to generate. A single non-negative whole number.

- level:

  PSOC hierarchy level to draw from: `"unit"` (most specific, e.g.
  "Finance managers"), `"minor"`, `"sub-major"`, or `"major"` (broadest,
  e.g. "Managers"). Default `"unit"`.

- major_group:

  Optional major-group title to restrict the draw to (e.g.
  `"Professionals"`, `"Elementary Occupations"`). See
  `fkr_psoc_occupation()`'s `major_group` output column for valid
  values.

## Value

A `data.frame` with `n` rows and columns `title` (the occupation/group
title), `psoc_code` (its PSOC code), and `major_group` (its top-level
PSOC major-group title).

## Details

Data is fetched live via the phscs package (which caches its data
locally after the first call) and kept in memory for the rest of the R
session, so the first call in a session may require network access.

## Examples

``` r
if (FALSE) { # interactive()
fkr_psoc_occupation(5)
fkr_psoc_occupation(5, level = "major")
fkr_psoc_occupation(5, major_group = "Professionals")
}
```
