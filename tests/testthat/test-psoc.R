# fkr_psoc_occupation() fetches live reference data via the phscs package.
skip_if_offline()

test_that("fkr_psoc_occupation returns consistent title/code/major_group rows", {
  out <- fkr_psoc_occupation(20)
  expect_named(out, c("title", "psoc_code", "major_group"))
  expect_equal(nrow(out), 20)
  expect_true(all(nchar(out$psoc_code) == 4))

  major_only <- fkr_psoc_occupation(10, level = "major")
  expect_true(all(nchar(major_only$psoc_code) == 1))
  expect_true(all(major_only$title == major_only$major_group))
})

test_that("fkr_psoc_occupation respects the major_group filter", {
  out <- fkr_psoc_occupation(15, major_group = "Professionals")
  expect_true(all(out$major_group == "Professionals"))

  expect_error(fkr_psoc_occupation(5, major_group = "Not A Group"))
})

test_that("fkr_psoc_occupation zero-pads the armed-forces branch instead of colliding with Managers", {
  df <- fkr:::.get_psoc_table()
  armed <- df[df$major_title == "Armed forces occupations", ]
  expect_true(nrow(armed) > 0)
  expect_true(all(startsWith(armed$code, "0")))
  expect_equal(sort(armed$code[armed$level == 4]), c("0110", "0210", "0310"))

  # The major-group code "1" (Managers) must not pick up armed-forces rows.
  managers_unit <- df[df$level == 4 & df$major_code == "1", ]
  expect_false(any(grepl("armed forces", managers_unit$label, ignore.case = TRUE)))
})

test_that("fkr_psoc_occupation validates n and level", {
  expect_equal(nrow(fkr_psoc_occupation(0)), 0)
  expect_equal(nrow(fkr_psoc_occupation(7)), 7)
  expect_error(fkr_psoc_occupation(-1))
  expect_error(fkr_psoc_occupation(5, level = "nonsense"))
})
