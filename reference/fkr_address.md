# Generate complete, internally-consistent Philippine addresses

Each generated row shares a single, real region/province/city/ZIP
combination, so unlike calling the individual `fkr_*` geo functions
separately, the fields are always geographically consistent with each
other.

## Usage

``` r
fkr_address(n, region = NULL)
```

## Arguments

- n:

  Number of addresses to generate. A single non-negative whole number.

- region:

  Optional region name to restrict the draw to.

## Value

A `data.frame` with `n` rows and character columns `street`, `barangay`,
`city`, `province`, `region`, `zip`.

## Examples

``` r
fkr_address(5)
#>                    street    barangay            city          province
#> 1 924 Marcos Highway Road      Malaya          Bontoc Mountain Province
#> 2         620 Luna Avenue Pasong Tamo     Tarlac City            Tarlac
#> 3        304 Recto Avenue Kaligayahan           Pasig      Metro Manila
#> 4      545 Katipunan Road     Dolores Tuguegarao City           Cagayan
#> 5       557 Burgos Avenue  San Miguel    Isabela City           Basilan
#>                                                    region  zip
#> 1                  Cordillera Administrative Region (CAR) 2616
#> 2                              Region III (Central Luzon) 2300
#> 3                           National Capital Region (NCR) 1600
#> 4                              Region II (Cagayan Valley) 3500
#> 5 Bangsamoro Autonomous Region In Muslim Mindanao (BARMM) 7300
```
