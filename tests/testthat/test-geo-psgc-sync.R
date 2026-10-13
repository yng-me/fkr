# Cross-checks .ph_geo's hand-curated region/province/city data against
# the live PSGC (via the psgc package), so drift from future PSGC
# releases (new regions, renamed/split provinces, etc.) gets caught here
# instead of silently going stale.
skip_if_offline()

test_that(".ph_geo region names and province groupings match the live PSGC", {
  df <- psgc::get_psgc()

  real_regions <- df$area_name[df$geographic_level == "Reg"]
  expect_true(all(.ph_regions %in% real_regions))

  real_provs <- df[df$geographic_level == "Prov", c("psgc_code", "area_name")]
  real_regs <- df[df$geographic_level == "Reg", c("psgc_code", "area_name")]
  prov_region <- function(province) {
    hit <- real_provs[real_provs$area_name == province, ]
    if (nrow(hit) == 0L) return(NA_character_)
    prefix <- substr(hit$psgc_code[1], 1, 2)
    real_regs$area_name[substr(real_regs$psgc_code, 1, 2) == prefix][1]
  }

  my_provs <- unique(.ph_geo[.ph_geo$province != "Metro Manila", c("province", "region")])
  for (i in seq_len(nrow(my_provs))) {
    expect_equal(
      prov_region(my_provs$province[i]), my_provs$region[i],
      info = paste("province:", my_provs$province[i])
    )
  }
})

test_that(".ph_geo city names all resolve against the live PSGC", {
  df <- psgc::get_psgc()
  norm <- function(x) {
    x <- tolower(trimws(x))
    x <- sub("^city of ", "", x)
    sub(" city$", "", x)
  }
  real_city_mun <- vapply(df$area_name[df$geographic_level %in% c("City", "Mun")], norm, character(1))

  for (city in .ph_geo$city) {
    expect_true(norm(city) %in% real_city_mun, info = paste("city:", city))
  }
})
