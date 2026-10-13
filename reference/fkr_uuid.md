# Generate UUIDs

Generates random (version 4, RFC 4122) universally unique identifiers.

## Usage

``` r
fkr_uuid(n, version = 4)
```

## Arguments

- n:

  Number of UUIDs to generate. A single non-negative whole number.

- version:

  UUID version to generate. Only `4` (random) is currently supported.

## Value

A character vector of length `n`, formatted as
`"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"` (lowercase hex, with the
version nibble fixed to `4` and the variant nibble one of `8`, `9`, `a`,
`b`).

## Examples

``` r
fkr_uuid(5)
#> [1] "3b509a3a-867d-44c1-acd5-87bf93ccd4f6"
#> [2] "c0779871-c486-469c-b97e-569a08cc2945"
#> [3] "caa83968-69f3-4c78-8846-dd5a099090c9"
#> [4] "a46b4983-51de-4c0f-8832-8d0139044876"
#> [5] "84c19e56-c8f0-44cb-a474-e631c00101c7"
```
