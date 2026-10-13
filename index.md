# fkr

**fkr** generates realistic-looking, made-up (fake) data for the
Philippines – names, addresses, phone numbers, ages, job titles,
ID-style numbers, and more – for building and testing software, writing
tutorials, or teaching, **without using any real person’s information.**

Nothing this package produces is looked up from a real database. Every
value – including anything formatted to look like a government ID number
(SSS, TIN, PhilHealth, Pag-IBIG, PhilSys) – is randomly made up on the
spot. It does not belong to any real person, business, or record, and
won’t work anywhere official.

## Installation

``` r

install.packages("remotes")
remotes::install_github("yng-me/fkr")
```

## Quick start

Every function starts with `fkr_`. The first thing you tell it is always
**how many fake values you want**:

``` r

library(fkr)

fkr_full_name(3)
#> [1] "Tanisha Magsino" "Socorro Cunanan" "Joyce Alcantara"
fkr_age(3)
#> [1]  2 50  1
fkr_mobile_number(3)
#> [1] "09910021516" "09187189635" "09489378455"
fkr_address(3)
#>                       street   barangay        city         province
#> 1         464 Legarda Avenue San Isidro Iligan City  Lanao del Norte
#> 2        366 Recto Extension   Maligaya Butuan City Agusan del Norte
#> 3 342 Shaw Boulevard Highway      Tibig   Las Piñas     Metro Manila
#>                          region  zip
#> 1  Region X (Northern Mindanao) 9200
#> 2          Region XIII (Caraga) 8600
#> 3 National Capital Region (NCR) 1740
```

Want a whole pretend dataset – many columns, many rows – in one go? Use
[`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md) and list which
generator fills each column:

``` r

fkr(5, list(
  first_name = fkr_first_name,
  last_name = fkr_last_name,
  sex = fkr_sex,
  age = fkr_age,
  date_of_birth = fkr_birthday
))
#>   first_name last_name    sex age date_of_birth
#> 1     Jordan  Abubakar Female   6    2020-10-07
#> 2       Iris  Gonzales   Male   6    2020-02-28
#> 3     Editha Dela Cruz   Male   6    2020-07-12
#> 4     Warren Natividad   Male   5    2021-07-25
#> 5    Loretta   Mahinay   Male  15    2011-10-13
```

`age` and `date_of_birth` automatically agree with each other – fkr
makes sure a person’s birthdate actually matches the age shown for them.

For a friendlier, step-by-step walkthrough (including how to attach
extra settings to a column, or make one column depend on another), see
`vignette("fkr")` after installing.

## What can it generate?

| Category | Examples |
|----|----|
| People | first/last/full name, sex, civil status, age, birthday |
| Contact details | email, mobile number, landline number |
| Addresses | region, province, city, barangay, street address, ZIP code, full address |
| Government ID-style numbers | SSS, TIN, PhilHealth, Pag-IBIG, PhilSys (see disclaimer above) |
| Official PH classifications | PSGC geographic codes, PSOC occupations, PSIC industries |
| Business | company name, job title, industry, product, price, business permit number |
| General-purpose helpers | plain numbers, whole numbers, yes/no, “select all that apply”, labeled categories, unique IDs, coordinates |
| Whole datasets | [`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md) – build a complete fake table in one call |

Every function has its own help page with more detail and examples, e.g.
[`?fkr_address`](https://yng-me.github.io/fkr/reference/fkr_address.md).

## A note on realism

Names, surnames, addresses, and job titles are drawn from real
Philippine reference data where possible (e.g. actual
region/province/city names, and the official PSGC, PSOC, and PSIC
classification systems), so the *shape* of the data is realistic – but
the specific combination assigned to any one fake record is always
random and fictional.

## License

MIT © [Bhas Abdulsamad](https://github.com/yng-me)
