# fkr_psgc_code() fetches live reference data via the psgc package.
skip_if_offline()

test_that("fkr_psgc_code returns well-formed codes per level", {
  expect_true(all(grepl("^\\d{9,10}$", fkr_psgc_code(10, level = "region"))))
  expect_true(all(grepl("^\\d{9,10}$", fkr_psgc_code(10, level = "province"))))
  expect_true(all(grepl("^\\d{9,10}$", fkr_psgc_code(10, level = "city"))))
  expect_true(all(grepl("^\\d{9,10}$", fkr_psgc_code(10, level = "municipality"))))
  expect_true(all(grepl("^\\d{9,10}$", fkr_psgc_code(10, level = "barangay"))))
})

test_that("fkr_psgc_code filters resolve to the right nested area", {
  df <- psgc::get_psgc()

  region_code <- fkr_psgc_code(1, level = "region", region = "Region VII (Central Visayas)")
  expect_true(startsWith(region_code, substr(df$psgc_code[df$area_name == "Region VII (Central Visayas)" & df$geographic_level == "Reg"][1], 1, 2)))

  prov_codes <- fkr_psgc_code(10, level = "province", region = "Region VII (Central Visayas)")
  cebu_prefix <- substr(df$psgc_code[df$area_name == "Cebu" & df$geographic_level == "Prov"][1], 1, 2)
  expect_true(all(substr(prov_codes, 1, 2) == cebu_prefix))

  city_codes <- fkr_psgc_code(5, level = "city", province = "Cebu")
  expect_true(all(substr(city_codes, 1, 5) == substr(df$psgc_code[df$area_name == "Cebu" & df$geographic_level == "Prov"][1], 1, 5)))

  # "Davao City" (fkr_city()-style) resolves against the real PSGC
  # name "City of Davao" via the City-of-X normalization.
  davao_code <- fkr_psgc_code(1, level = "city", city = "Davao City")
  expect_equal(davao_code, df$psgc_code[df$area_name == "City of Davao"][1])

  bgy_codes <- fkr_psgc_code(10, level = "barangay", city = "Davao City")
  expect_true(all(substr(bgy_codes, 1, 8) == substr(davao_code, 1, 8)))
})

test_that("fkr_psgc_code errors on unrecognized names and empty combinations", {
  expect_error(fkr_psgc_code(5, region = "Narnia"))
  expect_error(fkr_psgc_code(5, level = "province", province = "Narnia"))
  expect_error(fkr_psgc_code(5, level = "city", city = "Narnia"))
  expect_error(fkr_psgc_code(5, level = "city", region = "Region I (Ilocos Region)", province = "Cebu"))
})

test_that("fkr_psgc_code validates n and level", {
  expect_equal(fkr_psgc_code(0), character(0))
  expect_equal(length(fkr_psgc_code(7)), 7)
  expect_error(fkr_psgc_code(-1))
  expect_error(fkr_psgc_code(5, level = "country"))
})
