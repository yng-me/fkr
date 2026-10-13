# Generate Pag-IBIG (HDMF) number-style identifiers

Produces values matching the `NNNN-NNNN-NNNN` format used by the Home
Development Mutual Fund (Pag-IBIG Fund). **The digits are uniformly
random** and do not correspond to any real member; see the package-level
disclaimer in [`?fkr`](https://yng-me.github.io/fkr/reference/fkr.md).

## Usage

``` r
fkr_pagibig_number(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_pagibig_number(5)
#> [1] "9720-3463-0400" "1733-4537-1312" "3199-9326-1093" "4531-9020-2163"
#> [5] "6587-3007-2192"
```
