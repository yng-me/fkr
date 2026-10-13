generators_taking_n <- list(
  fkr_first_name, fkr_last_name, fkr_full_name, fkr_sex, fkr_civil_status,
  fkr_age, fkr_birthday, fkr_birthday_split,
  fkr_email, fkr_mobile_number, fkr_landline_number,
  fkr_region, fkr_province, fkr_city, fkr_zip_code, fkr_barangay,
  fkr_street_address, fkr_address,
  fkr_sss_number, fkr_tin_number, fkr_philhealth_number, fkr_pagibig_number,
  fkr_philsys_number,
  fkr_company, fkr_company_suffix, fkr_industry, fkr_job_title,
  fkr_department, fkr_product, fkr_price, fkr_business_permit_number,
  fkr_boolean, fkr_binary,
  fkr_uuid, fkr_coordinates,
  fkr_num, fkr_int
)
# fkr_psgc_code()/fkr_psoc_occupation()/fkr_psic_industry() are
# deliberately excluded from this shared loop: they fetch live reference
# data via the psgc/phscs packages, and get their own network-aware tests
# (test-psgc.R, test-psoc.R, test-psic.R) instead.
# fkr_multiple_response()/fkr_factor() are also excluded: neither has
# a default for `values`, so a bare gen(n) call can't be used here; see
# test-misc.R.

test_that("every generator validates n and returns zero rows/elements for n = 0", {
  for (gen in generators_taking_n) {
    out <- gen(0)
    expect_equal(NROW(out), 0)
  }
})

test_that("every generator rejects invalid n", {
  for (gen in generators_taking_n) {
    expect_error(gen(-1))
    expect_error(gen(1.5))
    expect_error(gen(NA))
    expect_error(gen("5"))
    expect_error(gen(c(1, 2)))
  }
})

test_that("every generator returns exactly n rows/elements", {
  for (gen in generators_taking_n) {
    expect_equal(NROW(gen(7)), 7)
  }
})
