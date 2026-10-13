# Generate multiple-response (select-all-that-apply) values

Simulates a "select all that apply" survey item: each generated value is
one or more entries from `values` combined together, e.g. with
`values = LETTERS[1:4]` a result might be `"A"`, `"AC"`, or `"ABCD"`.
Selected entries always keep their original order from `values` (so
`"AC"` can occur but `"CA"` cannot), and never repeat within a single
generated value.

## Usage

``` r
fkr_multiple_response(n, values, multiple = TRUE, sep = "")
```

## Arguments

- n:

  Number of values to generate. A single non-negative whole number.

- values:

  A non-empty vector of candidate entries, with no `NA`s, to combine
  (e.g. `LETTERS[1:4]`, or option labels like
  `c("Email", "Phone", "SMS")`).

- multiple:

  If `TRUE` (default), each generated value may combine more than one
  entry from `values`. If `FALSE`, exactly one entry is drawn per value,
  as in a single-response ("select one") item.

- sep:

  String used to join multiple selected entries together. Default `""`,
  which reads naturally when `values` are single characters (e.g.
  `"AC"`); for multi-character `values`, pass something like
  `sep = ", "` to keep entries distinguishable (e.g. `"Email, SMS"`).

## Value

A character vector of length `n`.

## Details

The number of entries selected for each value is drawn uniformly from
`1:length(values)` (not uniformly over all non-empty subsets), so
picking exactly 1 entry is just as likely as picking all of them.

## Examples

``` r
fkr_multiple_response(5, values = LETTERS[1:4])
#> [1] "ABC" "C"   "BD"  "ABC" "D"  
fkr_multiple_response(5, values = c("Email", "Phone", "SMS"), sep = ", ")
#> [1] "Email, Phone" "Email"        "SMS"          "Email, Phone" "SMS"         
fkr_multiple_response(5, values = LETTERS[1:4], multiple = FALSE)
#> [1] "A" "B" "A" "A" "C"
```
