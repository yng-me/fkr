# fkr_psic_industry() fetches live reference data via the phscs package.
skip_if_offline()

test_that("fkr_psic_industry returns consistent title/code/section rows", {
  out <- fkr_psic_industry(20)
  expect_named(out, c("title", "psic_code", "section"))
  expect_equal(nrow(out), 20)
  expect_true(all(nchar(out$psic_code) == 2))

  sections_only <- fkr_psic_industry(10, level = "sections")
  expect_true(all(nchar(sections_only$psic_code) == 1))
  expect_true(all(sections_only$title == sections_only$section))
})

test_that("fkr_psic_industry respects the section filter", {
  out <- fkr_psic_industry(15, section = "Manufacturing")
  expect_true(all(out$section == "Manufacturing"))
  expect_true(all(substr(out$psic_code, 1, 2) >= "10" & substr(out$psic_code, 1, 2) <= "33"))

  expect_error(fkr_psic_industry(5, section = "Not A Section"))
})

test_that("every PSIC division maps to exactly one section (no gaps)", {
  df <- fkr:::.get_psic_table()
  expect_false(anyNA(df$section_title))
  expect_equal(length(unique(df$section_code[df$level == 1])), 21)
})

test_that("fkr_psic_industry validates n and level", {
  expect_equal(nrow(fkr_psic_industry(0)), 0)
  expect_equal(nrow(fkr_psic_industry(7)), 7)
  expect_error(fkr_psic_industry(-1))
  expect_error(fkr_psic_industry(5, level = "nonsense"))
})
