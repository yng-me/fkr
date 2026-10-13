test_that("government-ID generators match their documented formats", {
  expect_true(all(grepl("^\\d{2}-\\d{7}-\\d{1}$", fkr_sss_number(20))))
  expect_true(all(grepl("^\\d{3}-\\d{3}-\\d{3}-\\d{3}$", fkr_tin_number(20))))
  expect_true(all(grepl("^\\d{2}-\\d{9}-\\d{1}$", fkr_philhealth_number(20))))
  expect_true(all(grepl("^\\d{4}-\\d{4}-\\d{4}$", fkr_pagibig_number(20))))
  expect_true(all(grepl("^\\d{4}-\\d{4}-\\d{4}-\\d{4}$", fkr_philsys_number(20))))
})
