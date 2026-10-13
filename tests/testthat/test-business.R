test_that("fkr_company produces non-empty, suffixed names", {
  out <- fkr_company(30)
  expect_true(all(nchar(out) > 0))
  expect_true(all(vapply(
    out, function(x) any(endsWith(x, .ph_company_suffixes)), logical(1)
  )))
})

test_that("fkr_price respects min/max and format", {
  numeric_prices <- fkr_price(50, min = 100, max = 500, format = "numeric")
  expect_true(all(numeric_prices >= 100 & numeric_prices <= 500))

  currency_prices <- fkr_price(10)
  expect_true(all(grepl("^PHP [0-9,]+\\.\\d{2}$", currency_prices)))

  expect_error(fkr_price(5, min = 500, max = 100))
})

test_that("fkr_business_permit_number validates year and formats correctly", {
  out <- fkr_business_permit_number(10, year = 2024)
  expect_true(all(grepl("^BP-2024-\\d{6}$", out)))
  expect_error(fkr_business_permit_number(5, year = 99))
})

test_that("categorical business generators draw from their documented sets", {
  expect_true(all(fkr_industry(20) %in% .ph_industries))
  expect_true(all(fkr_job_title(20) %in% .ph_job_titles))
  expect_true(all(fkr_department(20) %in% .ph_departments))
  expect_true(all(fkr_product(20) %in% .ph_product_items))
  expect_true(all(fkr_company_suffix(20) %in% .ph_company_suffixes))
})
