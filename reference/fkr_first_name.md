# Generate Filipino first names

Draws `n` given names from a lookup of ~700 male and ~760 female
Filipino first names, optionally restricted by sex.

## Usage

``` r
fkr_first_name(n, sex = c("any", "male", "female"))
```

## Arguments

- n:

  Number of names to generate. A single non-negative whole number.

- sex:

  Restrict the draw to `"male"` or `"female"` names, or `"any"` (the
  default) to draw from both pools combined.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_first_name(5)
#> [1] "Mitch"     "Manila"    "Richmond"  "Manila"    "Isabelita"
fkr_first_name(5, sex = "female")
#> [1] "Philomena" "Darcel"    "Ahtisa"    "Guadalupe" "Tiara"    
```
