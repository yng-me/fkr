# Getting Started with fkr

``` r

library(fkr)
```

## What does this package do?

**fkr** makes pretend (fake) data that looks like it came from the
Philippines – names, addresses, phone numbers, ages, job titles, and
more – without using any real person’s information.

Why would you want “fake” data?

- You’re building an app or a form and want to **see what it looks like
  with data in it**, before any real user has signed up.
- You’re **teaching a class or writing a tutorial** and need
  realistic-looking example data, without handing out anyone’s real
  details.
- You’re **testing software**: trying it with 10,000 pretend customers
  is much safer (and easier) than testing with real ones.

Every single value this package produces – every name, every address,
every number – is made up on the spot. Nothing is looked up from a real
database of real people.

> **A note on ID numbers.** Some functions produce values formatted to
> look like Philippine government ID numbers (an SSS number, a TIN, a
> PhilSys number, and so on). These are **entirely random digits
> arranged in the right pattern** – they are not real ID numbers, they
> don’t belong to anyone, and they will not work if you try to use them
> anywhere official. They exist only so that test data looks complete.

## Installing fkr

If this is your first time, you’ll need R installed on your computer
(see [r-project.org](https://www.r-project.org)). Once R is running,
install fkr with:

``` r

# install.packages("devtools")
pak::pak("yng-me/fkr")
```

Then, every time you want to use it, start your R session with:

``` r

library(fkr)
```

## Your first fake value

Every function in this package starts with `fkr_`, so they’re easy to
spot and to search for. Let’s make one fake first name:

``` r

fkr_first_name(1)
#> [1] "Precious"
```

That `1` tells the function “I want **one** value.” Want five instead?
Change the `1` to a `5`:

``` r

fkr_first_name(5)
#> [1] "Wesley"   "Rainer"   "Casimiro" "Rey"      "Sherlock"
```

That’s the pattern for *everything* in this package: the first thing you
tell a `fkr_*` function is always **how many fake values you want**.

``` r

fkr_age(5)
#> [1] 26 29 41  3  0
fkr_boolean(5)
#> [1] TRUE TRUE TRUE TRUE TRUE
fkr_civil_status(5)
#> [1] "Single"    "Separated" "Single"    "Married"   "Married"
```

## A quick tour of what you can generate

### People

``` r

fkr_first_name(3)
#> [1] "Shaun"   "Celeste" "Tai"
fkr_last_name(3)
#> [1] "Dela Cruz" "Alcantara" "Torres"
fkr_full_name(3)
#> [1] "Bituin Yumul"        "Wilkinson Dela Cruz" "Roberta Dela Cruz"
fkr_sex(3)
#> [1] "Male"   "Female" "Male"
fkr_civil_status(3)
#> [1] "Married"   "Annulled"  "Separated"
fkr_age(3)
#> [1]  9 12  7
fkr_birthday(3)
#> [1] "2022-12-22" "2011-03-24" "2013-04-10"
```

### Contact details

``` r

fkr_email(3)
#> [1] "xavier.francisco873@gmail.com" "elaine.mariano642@gmail.com"  
#> [3] "ricky.ramos@gmail.com"
fkr_mobile_number(3)
#> [1] "09216552817" "09950065891" "09185695462"
fkr_landline_number(3)
#> [1] "(082) 050 0146" "(02) 0366 7178" "(043) 285 8421"
```

### Addresses and places in the Philippines

``` r

fkr_region(3)
#> [1] "Region IX (Zamboanga Peninsula)" "Region III (Central Luzon)"     
#> [3] "Region I (Ilocos Region)"
fkr_province(3)
#> [1] "Southern Leyte" "Batangas"       "Tawi-Tawi"
fkr_city(3)
#> [1] "Kalibo"     "Pateros"    "Nabunturan"
fkr_barangay(3)
#> [1] "Santa Maria" "Pasong Tamo" "Mabuhay"
fkr_street_address(3)
#> [1] "484 Burgos Road"     "705 Recto Extension" "515 Luna Road"
```

Need a full, ready-made address (street, barangay, city, province,
region, and ZIP code, all matching each other)? There’s a function for
that too, and it gives you back a small table instead of a single value:

``` r

fkr_address(3)
#>                         street  barangay                 city     province
#> 1 466 Marcos Highway Extension San Roque Puerto Princesa City      Palawan
#> 2           812 Osmena Highway   Malinta                 Boac   Marinduque
#> 3            950 Mabini Avenue     Ilaya               Taguig Metro Manila
#>                          region  zip
#> 1               MIMAROPA Region 5300
#> 2               MIMAROPA Region 4900
#> 3 National Capital Region (NCR) 1630
```

### Government ID-style numbers

As mentioned above, these are random digits in the right pattern – not
real IDs.

``` r

fkr_sss_number(3)
#> [1] "93-2738063-7" "97-6889828-2" "06-4835762-7"
fkr_tin_number(3)
#> [1] "277-161-904-918" "806-308-893-519" "199-142-314-452"
fkr_philhealth_number(3)
#> [1] "07-757217694-7" "94-230816297-2" "00-899419713-4"
fkr_pagibig_number(3)
#> [1] "6333-2454-2384" "5669-5471-9715" "5044-5800-8317"
fkr_philsys_number(3)
#> [1] "6696-5498-5729-9196" "6369-1895-9118-0000" "8128-4750-3921-6991"
```

### Businesses and jobs

``` r

fkr_company(3)
#> [1] "Caballes General Services Ltd."      
#> [2] "Sotto & Aguilar Marketing Inc."      
#> [3] "Magat & Mercado Agro-Industrial Inc."
fkr_job_title(3)
#> [1] "Store Supervisor" "Loans Officer"    "Civil Engineer"
fkr_industry(3)
#> [1] "Logistics and Transportation" "Electronics Assembly"        
#> [3] "Business Consulting"
fkr_product(3)
#> [1] "Rubber Tsinelas"      "Tabletop Rice Cooker" "Longganisa Pack"
fkr_price(3)
#> [1] "PHP 17.18"    "PHP 11.31"    "PHP 1,529.47"
```

### Small, general-purpose helpers

These aren’t Philippines-specific – they’re handy building blocks for
any fake dataset.

``` r

fkr_num(5, min = 0, max = 100)          # plain numbers, e.g. a score or a rating
#> [1] 97.08 53.52 16.65  5.82 45.91
fkr_int(5, min = 18, max = 65)          # whole numbers, e.g. an age range
#> [1] 65 24 65 22 23
fkr_boolean(5)                          # TRUE / FALSE, e.g. "has a Facebook account?"
#> [1] FALSE  TRUE FALSE  TRUE FALSE
fkr_uuid(3)                             # a unique ID for each record
#> [1] "4c04b893-afd5-492e-b20f-7483289807f5"
#> [2] "95724f85-c90d-4835-90a2-a08a0d91cc79"
#> [3] "9f038afc-c012-4107-8cd6-41b69cb6991a"
```

Two more worth a closer look:

**[`fkr_multiple_response()`](https://yng-me.github.io/fkr/reference/fkr_multiple_response.md)**
pretends to be a survey question where someone can pick more than one
answer (a “select all that apply” question):

``` r

fkr_multiple_response(5, values = c("Email", "Phone", "SMS"), sep = ", ")
#> [1] "Phone, SMS"        "Email, Phone, SMS" "Phone"            
#> [4] "Email, Phone, SMS" "Email"
```

**[`fkr_factor()`](https://yng-me.github.io/fkr/reference/fkr_factor.md)**
creates a fake *category* column, where each code has a friendlier label
attached – similar to how survey or statistics software lets you store
`1`/`2` but *display* “Male”/“Female”:

``` r

fkr_factor(5, values = c(1, 2), labels = c("Male", "Female"))
#> [1] Female Female Female Female Female
#> Levels: Male Female
```

You can also attach a short description of the whole column (not each
value) using `label`:

``` r

sex <- fkr_factor(
  5,
  values = c(1, 2), labels = c("Male", "Female"),
  label = "Respondent's biological sex"
)
sex
#> [1] Male   Male   Female Female Male  
#> attr(,"label")
#> [1] Respondent's biological sex
#> Levels: Male Female
attr(sex, "label")
#> [1] "Respondent's biological sex"
```

## Building a whole pretend dataset at once

So far we’ve made one column at a time. Most of the time, though, you
want a whole **table** of fake data – like a spreadsheet with many
columns and many rows, where each row is one pretend person or one
pretend record.

That’s what the [`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md)
function is for. You give it:

1.  `n`: how many rows (pretend people) you want, and
2.  `specs`: a list that says, **for each column, which `fkr_*` function
    should fill it in**.

``` r

fkr(5, list(
  first_name = fkr_first_name,
  last_name = fkr_last_name,
  sex = fkr_sex,
  age = fkr_age,
  date_of_birth = fkr_birthday,
  mobile_number = fkr_mobile_number
))
#>   first_name last_name    sex age date_of_birth mobile_number
#> 1  Katherine   Quijano   Male  15    2011-06-21   09656100892
#> 2    Emerald    Zamora   Male   5    2021-08-17   09179377460
#> 3      Xandy  Custodio Female  32    1994-10-03   09261872134
#> 4      Qamra Dela Cruz Female  58    1968-09-30   09062002832
#> 5     Dennis   Marcelo   Male  10    2016-03-12   09790073591
```

Notice that we wrote `fkr_first_name`, not
[`fkr_first_name()`](https://yng-me.github.io/fkr/reference/fkr_first_name.md)
– no parentheses. We’re telling
[`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md) *which tool to
use* for that column; it takes care of calling it the right number of
times for you.

If a column’s generator gives back a whole mini-table of its own – like
[`fkr_address()`](https://yng-me.github.io/fkr/reference/fkr_address.md)
does – [`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md)
automatically spreads its pieces out into separate columns, named after
the column you asked for:

``` r

fkr(3, list(
  name = fkr_full_name,
  address = fkr_address
))
#>             name       address_street address_barangay         address_city
#> 1   Saturn Reyes      295 Taft Avenue      Pasong Tamo           Vigan City
#> 2 Hilario Garcia    919 Lacson Street         Caniogan City of San Fernando
#> 3  Renato Castro 519 Mabini Extension         Masagana        Sorsogon City
#>   address_province             address_region address_zip
#> 1       Ilocos Sur   Region I (Ilocos Region)        2700
#> 2         Pampanga Region III (Central Luzon)        2000
#> 3         Sorsogon    Region V (Bicol Region)        4700
```

### Fixing extra settings for a column

Some generators accept extra settings. For example,
[`fkr_city()`](https://yng-me.github.io/fkr/reference/fkr_city.md) can
be limited to one province. To use that inside
[`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md), wrap it in a
small “recipe”:

``` r

fkr(5, list(
  city_in_cebu = function(n) fkr_city(n, province = "Cebu")
))
#>   city_in_cebu
#> 1    Cebu City
#> 2 Mandaue City
#> 3 Mandaue City
#> 4    Cebu City
#> 5    Cebu City
```

Read `function(n) fkr_city(n, province = "Cebu")` as: “to make this
column, call `fkr_city`, asking for `n` values, always from the province
of Cebu.”

### Making one column depend on another

Sometimes a column’s value should depend on another column you already
made – for example, whether someone is a “Minor” or an “Adult” depends
on their `age`. Add a second ingredient, `data`, to see the columns
built so far:

``` r

fkr(6, list(
  age = fkr_age,
  stage = function(n, data) ifelse(data$age < 18, "Minor", "Adult")
))
#>   age stage
#> 1  25 Adult
#> 2   3 Minor
#> 3   5 Minor
#> 4  37 Adult
#> 5   8 Minor
#> 6   1 Minor
```

## Keeping an age and a birthday that agree with each other

If you ask for both an `age` column and a birthday column in the *same*
[`fkr()`](https://yng-me.github.io/fkr/reference/fkr.md) call, fkr is
smart about it: it makes sure the birthday it generates actually matches
the age in that same row. You don’t have to do anything extra – just ask
for both, by name, as shown below:

``` r

people <- fkr(5, list(
  age = fkr_age,
  date_of_birth = fkr_birthday
))
people
#>   age date_of_birth
#> 1   0    2026-07-07
#> 2   2    2024-06-26
#> 3   0    2026-07-15
#> 4  26    2000-03-24
#> 5  51    1975-06-10
```

(If you ever *want* them to be unrelated – unusual, but possible – wrap
one of them in `function(n) ...`, the same trick shown above for “extra
settings.” That tells fkr you’re taking manual control of that column.)

## Making your “random” results repeatable

Everything in this package is random by design – that’s the point of
fake data! But sometimes you want to **get the exact same fake data
again**, for example to write a tutorial where your readers see the same
numbers you did.

Call [`fkr_seed()`](https://yng-me.github.io/fkr/reference/fkr_seed.md)
with any whole number right before generating your data:

``` r

fkr_seed(2024)
fkr_first_name(3)
#> [1] "Sebastian" "Zach"      "Severina"

fkr_seed(2024)
fkr_first_name(3) # identical to the line above
#> [1] "Sebastian" "Zach"      "Severina"
```

## Where to go next

- Every function has its own help page. In R, type a question mark
  followed by the function’s name,
  e.g. [`?fkr_address`](https://yng-me.github.io/fkr/reference/fkr_address.md),
  to see exactly what settings it accepts.
- The package’s README has a shorter, at-a-glance summary of everything
  covered here.
