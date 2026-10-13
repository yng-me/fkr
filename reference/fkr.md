# Generate a complete fake dataset

A dataset-level abstraction over the individual `fkr_*()` generators:
describe each column with a `specs` list and get back a single,
ready-to-use `data.frame` with `n` rows.

## Usage

``` r
fkr(n, specs)
```

## Arguments

- n:

  Number of rows to generate. A single non-negative whole number.

- specs:

  A named list describing each column. Names become column names and
  must be unique and non-empty. Each element can be:

  - A **function of `n`** – the common case – called as `spec(n)`. This
    covers every `fkr_*()` generator directly, including ones with extra
    optional arguments (their defaults just apply), and
    `function(n) fkr_city(n, province = "Cebu")` to fix extra arguments.

  - A **function with a `data` argument** – for a column that depends on
    columns generated earlier in `specs` – called as
    `spec(n, data = data)`, where `data` is the partial result built so
    far (a `data.frame` with one column per already-processed spec, in
    `specs` order). The argument must be named exactly `data` for this
    to trigger; its position doesn't matter.

  - An **already-generated vector or data.frame** with length/`nrow`
    equal to `n`.

  - A **single scalar**, recycled to length `n` (e.g. a constant column
    like `country = "Philippines"`).

  When a spec (whether a function's result or a literal value) is a
  `data.frame` – e.g.
  [`fkr_address()`](https://yng-me.github.io/fkr/reference/fkr_address.md)
  or
  [`fkr_coordinates()`](https://yng-me.github.io/fkr/reference/fkr_coordinates.md)
  – its columns are flattened into the output, prefixed with the spec's
  own name (`address` becomes `address_street`, `address_city`, ...).

## Value

A `data.frame` with `n` rows and one column per (flattened) spec, in the
order given in `specs`.

## Age/birthday consistency

If [`fkr_age()`](https://yng-me.github.io/fkr/reference/fkr_age.md) and
either
[`fkr_birthday()`](https://yng-me.github.io/fkr/reference/fkr_birthday.md)
or
[`fkr_birthday_split()`](https://yng-me.github.io/fkr/reference/fkr_birthday_split.md)
both appear *unwrapped* (i.e. passed as the bare function, not e.g.
`function(n) fkr_age(n, age_range = 18:65)`) among `specs`, `fkr()`
draws the age once and feeds it to the birthday spec(s), so the
generated age and the age implied by the birthdate always agree –
instead of each independently drawing its own random age. Wrap either in
an anonymous function (even a trivial `function(n) fkr_age(n)`) to opt
out and get independent draws.

## Examples

``` r
fkr_seed(1)
fkr(5, list(
  first_name = fkr_first_name,
  last_name = fkr_last_name,
  sex = fkr_sex,
  age = fkr_age,
  date_of_birth = fkr_birthday,
  address = fkr_address,
  coordinates = fkr_coordinates
))
#>   first_name last_name    sex age date_of_birth       address_street
#> 1    Raymond Dela Cruz   Male   6    2020-03-26 422 Magsaysay Avenue
#> 2    Lazarus    Cortez   Male   9    2017-07-30        111 Luna Road
#> 3     Joseph Dela Cruz   Male  16    2010-10-10 404 Aguinaldo Avenue
#> 4      Quinn    Javier   Male  47    1979-01-10 924 Magsaysay Avenue
#> 5     Tamara    Garcia Female   4    2022-07-29     532 Luna Highway
#>   address_barangay         address_city  address_province
#> 1          Malinta               Bontoc Mountain Province
#> 2         Tagumpay        Batangas City          Batangas
#> 3       Santa Rosa          Iligan City   Lanao del Norte
#> 4             Looc           Nabunturan      Davao de Oro
#> 5        Poblacion Puerto Princesa City           Palawan
#>                           address_region address_zip coordinates_latitude
#> 1 Cordillera Administrative Region (CAR)        2616             9.272849
#> 2               Region IV-A (CALABARZON)        4200            11.268917
#> 3           Region X (Northern Mindanao)        9200            17.090777
#> 4               Region XI (Davao Region)        8800            16.700753
#> 5                        MIMAROPA Region        5300            10.059854
#>   coordinates_longitude
#> 1              124.4400
#> 2              126.2180
#> 3              121.1162
#> 4              123.8114
#> 5              120.7799

# A column that depends on one generated earlier in `specs`:
fkr(5, list(
  age = fkr_age,
  civil_status = function(n, data) {
    ifelse(data$age < 18, "Single", fkr_civil_status(n))
  }
))
#>   age civil_status
#> 1   7       Single
#> 2  28       Single
#> 3   4       Single
#> 4  24       Single
#> 5   2       Single
```
