test_that("fkr_email builds a valid-looking address and honors fixed names/domain", {
  out <- fkr_email(20)
  expect_true(all(grepl("^[a-z0-9._]+@[a-z.]+$", out)))

  fixed <- fkr_email(5, first_name = "Juan", last_name = "Dela Cruz", domain = "example.com")
  expect_true(all(grepl("^juan.*delacruz.*@example\\.com$", fixed)))

  expect_error(fkr_email(5, first_name = c("A", "B", "C")))
})

test_that("fkr_mobile_number uses real network prefixes and formats", {
  local <- fkr_mobile_number(30, network = "globe")
  expect_true(all(nchar(local) == 11))
  expect_true(all(substr(local, 1, 4) %in% .ph_mobile_prefixes$globe))

  intl <- fkr_mobile_number(10, format = "international")
  expect_true(all(grepl("^\\+63", intl)))

  expect_equal(fkr_mobile_number(0, format = "international"), character(0))
  expect_error(fkr_mobile_number(5, network = "sun"))
})

test_that("fkr_landline_number respects area_code and uses 8 digits for Metro Manila", {
  ncr <- fkr_landline_number(10, area_code = "Metro Manila")
  expect_true(all(grepl("^\\(02\\) \\d{4} \\d{4}$", ncr)))

  cebu <- fkr_landline_number(10, area_code = "Cebu")
  expect_true(all(grepl("^\\(032\\) \\d{3} \\d{4}$", cebu)))

  expect_error(fkr_landline_number(5, area_code = "Atlantis"))
})
