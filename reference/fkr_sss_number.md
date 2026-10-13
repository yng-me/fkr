# Generate SSS number-style identifiers

Produces values matching the `NN-NNNNNNN-N` format used by the
Philippine Social Security System. **The digits are uniformly random**
and do not correspond to any real SSS member; see the package-level
disclaimer in [`?fkr`](https://yng-me.github.io/fkr/reference/fkr.md).

## Usage

``` r
fkr_sss_number(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_sss_number(5)
#> [1] "43-5894288-8" "27-9698230-6" "49-6889646-4" "58-1471088-5" "48-9357556-0"
```
