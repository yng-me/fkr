test_that("fkr() builds a data.frame from function specs", {
  out <- fkr(10, list(
    first_name = fkr_first_name,
    age = fkr_age,
    sex = fkr_sex
  ))
  expect_s3_class(out, "data.frame")
  expect_equal(nrow(out), 10)
  expect_named(out, c("first_name", "age", "sex"))
  expect_true(all(out$sex %in% c("Male", "Female")))
})

test_that("fkr() passes extra optional arguments through untouched", {
  out <- fkr(20, list(name = function(n) fkr_first_name(n, sex = "female")))
  expect_true(all(out$name %in% .ph_female_names))
})

test_that("fkr() flattens data.frame specs with a name prefix", {
  out <- fkr(5, list(address = fkr_address, coordinates = fkr_coordinates))
  expect_true(all(c(
    "address_street", "address_barangay", "address_city", "address_province",
    "address_region", "address_zip", "coordinates_latitude", "coordinates_longitude"
  ) %in% names(out)))
  expect_equal(nrow(out), 5)
})

test_that("fkr() supports dependent columns via a `data` argument", {
  out <- fkr(30, list(
    age = function(n) fkr_age(n, age_range = c(10, 20)),
    stage = function(n, data) ifelse(data$age < 18, "Minor", "Adult")
  ))
  expect_equal(out$stage, ifelse(out$age < 18, "Minor", "Adult"))
})

test_that("fkr() recycles scalar specs and accepts pre-materialized vectors", {
  out <- fkr(4, list(country = "Philippines", x = fkr_uuid))
  expect_equal(out$country, rep("Philippines", 4))

  n <- 4
  out2 <- fkr(n, list(first = fkr_first_name(n), last = fkr_last_name(n)))
  expect_equal(nrow(out2), 4)
})

test_that("fkr() handles n = 0", {
  out <- fkr(0, list(age = fkr_age, address = fkr_address))
  expect_equal(nrow(out), 0)
  expect_named(out, c("age", "address_street", "address_barangay", "address_city",
                       "address_province", "address_region", "address_zip"))
})

implied_age_from_dob <- function(dob, today) {
  by <- as.integer(format(dob, "%Y"))
  not_yet <- format(dob, "%m%d") > format(today, "%m%d")
  as.integer(format(today, "%Y")) - by - as.integer(not_yet)
}

test_that("fkr() reconciles bare fkr_age + fkr_birthday to agree", {
  today <- Sys.Date()
  out <- fkr(50, list(age = fkr_age, date_of_birth = fkr_birthday))
  implied <- implied_age_from_dob(as.Date(out$date_of_birth), today)
  expect_equal(implied, out$age)
})

test_that("fkr() reconciles bare fkr_age + fkr_birthday_split to agree", {
  today <- Sys.Date()
  out <- fkr(50, list(age = fkr_age, dob = fkr_birthday_split))
  rebuilt <- as.Date(paste(out$dob_year, out$dob_month, out$dob_day, sep = "-"))
  implied <- implied_age_from_dob(rebuilt, today)
  expect_equal(implied, out$age)
})

test_that("fkr() does not force consistency when either spec is wrapped", {
  today <- Sys.Date()
  out <- fkr(500, list(age = fkr_age, dob = function(n) fkr_birthday(n)))
  implied <- implied_age_from_dob(as.Date(out$dob), today)
  expect_true(mean(implied == out$age) < 0.5) # should look independent, not ~100%
})

test_that("fkr() reconciliation doesn't kick in with only one of the pair", {
  out_age_only <- fkr(5, list(age = fkr_age))
  expect_named(out_age_only, "age")

  out_dob_only <- fkr(5, list(dob = fkr_birthday))
  expect_named(out_dob_only, "dob")
})

test_that("fkr() still supports manual age/birthday wiring via `data`", {
  today <- Sys.Date()
  out <- fkr(10, list(
    age = fkr_age,
    dob = function(n, data) fkr_birthday(n, age = data$age)
  ))
  implied <- implied_age_from_dob(as.Date(out$dob), today)
  expect_equal(implied, out$age)
})

test_that("fkr() validates `specs`", {
  expect_error(fkr(5, "not a list"))
  expect_error(fkr(5, list()))
  expect_error(fkr(5, list(fkr_age))) # unnamed
  expect_error(fkr(5, list(a = fkr_age, a = fkr_sex))) # duplicate name
  expect_error(fkr(5, list(age = fkr_age(3)))) # length mismatch
  expect_error(fkr(5, list(a = function() 1))) # zero-arg function
  expect_error(fkr(-1, list(age = fkr_age)))
})
