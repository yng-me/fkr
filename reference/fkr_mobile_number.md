# Generate Philippine mobile numbers

Draws mobile numbers using real network prefixes (Smart/TNT, Globe/TM,
or DITO).

## Usage

``` r
fkr_mobile_number(
  n,
  network = c("any", "smart", "globe", "dito"),
  format = c("local", "international")
)
```

## Arguments

- n:

  Number of mobile numbers to generate. A single non-negative whole
  number.

- network:

  Restrict the draw to `"smart"`, `"globe"`, or `"dito"` prefixes, or
  `"any"` (default) to mix all networks.

- format:

  `"local"` (default) returns `"09XXXXXXXXX"`; `"international"` returns
  `"+639XXXXXXXXX"`.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_mobile_number(5)
#> [1] "09293465232" "09993921523" "09493944694" "09367429636" "09190527339"
fkr_mobile_number(5, network = "globe", format = "international")
#> [1] "+639765489353" "+639178537507" "+639055440851" "+639562765829"
#> [5] "+639174816997"
```
