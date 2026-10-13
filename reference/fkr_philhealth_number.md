# Generate PhilHealth number-style identifiers

Produces values matching the `NN-NNNNNNNNN-N` format used by the
Philippine Health Insurance Corporation. **The digits are uniformly
random** and do not correspond to any real member; see the package-level
disclaimer in [`?fkr`](https://yng-me.github.io/fkr/reference/fkr.md).

## Usage

``` r
fkr_philhealth_number(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_philhealth_number(5)
#> [1] "66-803853745-0" "81-875481886-8" "58-955612012-5" "41-898116351-6"
#> [5] "85-974855747-2"
```
