# Generate PhilSys Number (PSN) card-style identifiers

Produces values matching the `NNNN-NNNN-NNNN-NNNN` format printed on the
Philippine national ID (PhilSys). **The digits are uniformly random**
and do not correspond to any real registrant; see the package-level
disclaimer in [`?fkr`](https://yng-me.github.io/fkr/reference/fkr.md).

## Usage

``` r
fkr_philsys_number(n)
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

## Value

A character vector of length `n`.

## Examples

``` r
fkr_philsys_number(5)
#> [1] "7422-4286-3327-7995" "9961-2716-4699-4500" "5595-8075-0927-4579"
#> [4] "7462-9044-3819-1159" "8624-0855-8271-6958"
```
