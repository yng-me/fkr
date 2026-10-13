test_that("fkr_seed makes subsequent draws reproducible", {
  fkr_seed(42)
  a <- fkr_full_name(10)
  fkr_seed(42)
  b <- fkr_full_name(10)
  expect_identical(a, b)

  expect_error(fkr_seed("abc"))
  expect_error(fkr_seed(1.5))
})

test_that("fkr_boolean and fkr_binary respect prob and custom values", {
  expect_type(fkr_boolean(10), "logical")
  expect_error(fkr_boolean(5, prob = 1.5))

  always_true <- fkr_boolean(20, prob = 1)
  expect_true(all(always_true))

  custom <- fkr_binary(20, values = c("No", "Yes"), prob = 1)
  expect_true(all(custom == "Yes"))

  expect_error(fkr_binary(5, values = c("a", "b", "c")))
})

test_that("fkr_multiple_response combines entries in original order with no repeats", {
  out <- fkr_multiple_response(200, values = LETTERS[1:4])
  expect_true(all(grepl("^[ABCD]+$", out)))
  expect_true(all(nchar(out) >= 1 & nchar(out) <= 4))

  for (x in out) {
    letters_in_x <- strsplit(x, "")[[1]]
    expect_equal(letters_in_x, unique(letters_in_x)) # no repeats
    expect_true(!is.unsorted(match(letters_in_x, LETTERS[1:4]))) # original order
  }

  # every possible response length should show up over a large sample
  expect_setequal(unique(nchar(out)), 1:4)
})

test_that("fkr_multiple_response respects sep and multiple = FALSE", {
  out <- fkr_multiple_response(20, values = c("Email", "Phone", "SMS"), sep = ", ")
  expect_true(all(out %in% c(
    "Email", "Phone", "SMS",
    "Email, Phone", "Email, SMS", "Phone, SMS",
    "Email, Phone, SMS"
  )))

  single <- fkr_multiple_response(20, values = LETTERS[1:4], multiple = FALSE)
  expect_true(all(nchar(single) == 1))
  expect_true(all(single %in% LETTERS[1:4]))
})

test_that("fkr_multiple_response validates its arguments", {
  expect_equal(fkr_multiple_response(0, values = LETTERS[1:4]), character(0))
  expect_equal(length(fkr_multiple_response(7, values = LETTERS[1:4])), 7)
  expect_equal(fkr_multiple_response(3, values = "X"), rep("X", 3))

  expect_error(fkr_multiple_response(5, values = character(0)))
  expect_error(fkr_multiple_response(5, values = c("A", NA)))
  expect_error(fkr_multiple_response(5, values = LETTERS[1:4], multiple = "yes"))
  expect_error(fkr_multiple_response(5, values = LETTERS[1:4], sep = NA))
  expect_error(fkr_multiple_response(-1, values = LETTERS[1:4]))
})

test_that("fkr_num respects min/max/decimals", {
  out <- fkr_num(50, min = 10, max = 20, decimals = 3)
  expect_true(all(out >= 10 & out <= 20))
  expect_true(all(round(out, 3) == out))

  expect_equal(fkr_num(0), numeric(0))
  expect_error(fkr_num(5, min = 10, max = 5))
  expect_error(fkr_num(5, decimals = -1))
  expect_error(fkr_num(5, decimals = 1.5))
})

test_that("fkr_int respects min/max and handles a degenerate single-value range", {
  out <- fkr_int(50, min = 18, max = 65)
  expect_true(all(out >= 18 & out <= 65))
  expect_true(all(out == as.integer(out)))

  expect_equal(fkr_int(5, min = 7, max = 7), rep(7L, 5))
  expect_equal(fkr_int(0), integer(0))
  expect_error(fkr_int(5, min = 10, max = 5))
  expect_error(fkr_int(5, min = 1.5))
})

test_that("fkr_factor builds a labeled factor with the right levels", {
  out <- fkr_factor(30, values = c(1, 2), labels = c("Male", "Female"))
  expect_s3_class(out, "factor")
  expect_equal(levels(out), c("Male", "Female"))
  expect_true(all(out %in% c("Male", "Female")))

  unlabeled <- fkr_factor(10, values = c("A", "B", "C"))
  expect_equal(levels(unlabeled), c("A", "B", "C"))
})

test_that("fkr_factor attaches a variable `label` without affecting value labels", {
  out <- fkr_factor(5, values = c(1, 2), labels = c("Male", "Female"), label = "Sex")
  expect_equal(attr(out, "label"), "Sex")
  expect_equal(levels(out), c("Male", "Female"))

  no_label <- fkr_factor(5, values = c(1, 2))
  expect_null(attr(no_label, "label"))
})

test_that("fkr_factor respects sampling weights via prob", {
  out <- fkr_factor(3000, values = c(1, 2, 3), prob = c(0.8, 0.15, 0.05))
  props <- prop.table(table(out))
  expect_true(props[["1"]] > props[["2"]])
  expect_true(props[["2"]] > props[["3"]])
})

test_that("fkr_factor validates its arguments and handles n = 0", {
  out0 <- fkr_factor(0, values = c(1, 2), labels = c("Male", "Female"))
  expect_equal(length(out0), 0)
  expect_equal(levels(out0), c("Male", "Female"))

  expect_error(fkr_factor(5, values = character(0)))
  expect_error(fkr_factor(5, values = c(1, NA)))
  expect_error(fkr_factor(5, values = c(1, 2), labels = "Only one"))
  expect_error(fkr_factor(5, values = c(1, 2), labels = c("a", NA)))
  expect_error(fkr_factor(5, values = c(1, 2), label = c("a", "b")))
  expect_error(fkr_factor(5, values = c(1, 2), prob = c(-1, 2)))
  expect_error(fkr_factor(-1, values = c(1, 2)))
})
