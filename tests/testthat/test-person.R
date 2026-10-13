test_that("fkr_first_name respects sex filter", {
  expect_true(all(fkr_first_name(20, sex = "male") %in% .ph_male_names))
  expect_true(all(fkr_first_name(20, sex = "female") %in% .ph_female_names))
  expect_error(fkr_first_name(5, sex = "other"))
})

test_that("the name lookup tables are reasonably large", {
  expect_gt(length(.ph_male_names), 500)
  expect_gt(length(.ph_female_names), 500)
  expect_gt(length(.ph_surnames), 900)
  expect_equal(length(.ph_surnames), length(.ph_surname_weights))
})

test_that("fkr_last_name biases toward common surnames when weighted, not when not", {
  expect_true(all(fkr_last_name(20) %in% .ph_surnames))
  expect_error(fkr_last_name(5, weighted = "yes"))

  common <- fkr_last_name(2000, weighted = TRUE)
  expect_true(mean(common == "Dela Cruz") > 0.02)

  uniform <- fkr_last_name(2000, weighted = FALSE)
  expect_true(mean(uniform == "Dela Cruz") < 0.01)
})

test_that("fkr_full_name combines first and last names", {
  out <- fkr_full_name(10)
  expect_true(all(grepl(" ", out)))

  out_mi <- fkr_full_name(10, middle_initial = TRUE)
  expect_true(all(grepl("^.+ [A-Z]\\. .+$", out_mi)))

  expect_equal(fkr_full_name(0, middle_initial = TRUE), character(0))
})

test_that("fkr_sex and fkr_civil_status return expected categories", {
  expect_true(all(fkr_sex(20) %in% c("Male", "Female")))
  expect_true(all(fkr_civil_status(20) %in% .ph_civil_status))
  expect_error(fkr_sex(5, levels = "Male"))
})

test_that("fkr_age respects age_range and rejects negative ages", {
  ages <- fkr_age(50, age_range = 18:65)
  expect_true(all(ages >= 18 & ages <= 65))
  expect_error(fkr_age(5, age_range = -5:5))
})

test_that("fkr_age handles a single-value age_range without hitting sample()'s 1:x pitfall", {
  expect_equal(fkr_age(10, age_range = 30), rep(30L, 10))
})

test_that("fkr_birthday produces dates consistent with the requested age range", {
  ref <- as.Date("2026-10-13")
  bdays <- fkr_birthday(100, age_range = 30, bias = 0, ref_date = ref)
  ages_in_years <- as.integer(format(ref, "%Y")) - as.integer(format(bdays, "%Y"))
  expect_true(all(bdays <= ref))
  expect_true(all(ages_in_years %in% c(30, 31)))
})

test_that("fkr_birthday_split returns zero-padded year/month/day columns", {
  out <- fkr_birthday_split(10)
  expect_named(out, c("year", "month", "day"))
  expect_true(all(nchar(out$year) == 4))
  expect_true(all(nchar(out$month) == 2))
  expect_true(all(nchar(out$day) == 2))
})

test_that("fkr_birthday accepts a precomputed `age` and matches it exactly", {
  ref <- as.Date("2026-10-13")
  ages <- c(0L, 1L, 30L, 65L, 100L)
  bdays <- fkr_birthday(5, age = ages, ref_date = ref)
  implied <- as.integer(format(ref, "%Y")) - as.integer(format(bdays, "%Y")) -
    as.integer(format(bdays, "%m%d") > format(ref, "%m%d"))
  expect_equal(implied, ages)

  expect_error(fkr_birthday(5, age = 1:4, ref_date = ref)) # wrong length
  expect_error(fkr_birthday(5, age = c(1, -1, 2, 3, 4), ref_date = ref)) # negative
  expect_error(fkr_birthday(5, age = 1:5, age_range = 1:10)) # age + ... conflict
  expect_equal(fkr_birthday(0, age = numeric(0)), as.Date(character(0)))
})

test_that("fkr_birthday_split accepts a precomputed `age`", {
  ages <- c(10, 20, 30, 40, 50)
  out <- fkr_birthday_split(5, age = ages)
  today <- Sys.Date()
  dob <- as.Date(paste(out$year, out$month, out$day, sep = "-"))
  not_yet <- format(dob, "%m%d") > format(today, "%m%d")
  implied <- as.integer(format(today, "%Y")) - as.integer(out$year) - as.integer(not_yet)
  expect_equal(implied, ages)
})
