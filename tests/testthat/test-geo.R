test_that("fkr_region returns only known regions", {
  expect_true(all(fkr_region(20) %in% .ph_regions))
  expect_error(fkr_province(5, region = "Narnia"))
})

test_that(".ph_geo region groupings match the latest PSGC (NIR split, MIMAROPA/BARMM naming)", {
  expect_equal(length(.ph_regions), 18)
  expect_true("Negros Island Region (NIR)" %in% .ph_regions)
  expect_true("MIMAROPA Region" %in% .ph_regions)
  expect_false("Region IV-B (MIMAROPA)" %in% .ph_regions)
  expect_true("Bangsamoro Autonomous Region In Muslim Mindanao (BARMM)" %in% .ph_regions)

  nir_provinces <- .ph_geo$province[.ph_geo$region == "Negros Island Region (NIR)"]
  expect_setequal(nir_provinces, c("Negros Occidental", "Negros Oriental"))

  # Sulu is PSGC-coded under Region IX even though it is a BARMM province
  # politically -- see the comment in R/data-geo.R.
  expect_equal(.ph_geo$region[.ph_geo$province == "Sulu"], "Region IX (Zamboanga Peninsula)")
})

test_that("fkr_province and fkr_city respect the region filter", {
  provinces <- fkr_province(30, region = "Region VII (Central Visayas)")
  expect_true(all(provinces %in% .ph_geo$province[.ph_geo$region == "Region VII (Central Visayas)"]))

  cities <- fkr_city(30, province = "Cebu")
  expect_true(all(cities %in% .ph_geo$city[.ph_geo$province == "Cebu"]))

  expect_error(fkr_city(5, province = "Cebu", region = "Region I (Ilocos Region)"))
})

test_that("fkr_zip_code returns 4-digit codes consistent with city", {
  zips <- fkr_zip_code(20, city = "Davao City")
  expect_true(all(zips == "8000"))
  expect_true(all(grepl("^\\d{4}$", fkr_zip_code(20))))
})

test_that("fkr_address rows are internally consistent", {
  addr <- fkr_address(50)
  expect_named(addr, c("street", "barangay", "city", "province", "region", "zip"))
  expect_equal(nrow(addr), 50)

  for (i in seq_len(nrow(addr))) {
    match_row <- .ph_geo[.ph_geo$city == addr$city[i] & .ph_geo$province == addr$province[i], ]
    expect_equal(nrow(match_row), 1L)
    expect_equal(match_row$region, addr$region[i])
    expect_equal(match_row$zip, addr$zip[i])
  }
})

test_that("fkr_barangay and fkr_street_address look realistic", {
  expect_true(all(fkr_barangay(20) %in% .ph_barangays))
  expect_true(all(grepl("^\\d+ .+ (Street|Avenue|Road|Extension|Highway)$", fkr_street_address(20))))
})
