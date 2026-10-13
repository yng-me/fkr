test_that("fkr_uuid produces well-formed version-4 UUIDs", {
  out <- fkr_uuid(50)
  pattern <- "^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$"
  expect_true(all(grepl(pattern, out)))
  expect_equal(length(unique(out)), length(out))
})

test_that("fkr_uuid rejects unsupported versions", {
  expect_error(fkr_uuid(5, version = 1))
  expect_error(fkr_uuid(5, version = "4"))
})
