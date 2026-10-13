#' Seed fkr's random number generation
#'
#' A thin, self-documenting wrapper around [set.seed()] so a whole
#' sequence of `fkr_*()` calls can be made reproducible.
#'
#' @param seed A single whole number.
#'
#' @return `NULL`, invisibly. Called for its side effect.
#' @export
#'
#' @examples
#' fkr_seed(123)
#' fkr_first_name(3)
fkr_seed <- function(seed) {
  if (!is.numeric(seed) || length(seed) != 1L || is.na(seed) || seed != as.integer(seed)) {
    stop("`seed` must be a single whole number.", call. = FALSE)
  }
  set.seed(as.integer(seed))
  invisible(NULL)
}

#' Generate boolean values
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param prob Probability of drawing `TRUE`. Default `0.5`.
#'
#' @return A logical vector of length `n`.
#' @export
#'
#' @examples
#' fkr_boolean(5)
#' fkr_boolean(5, prob = 0.9)
fkr_boolean <- function(n, prob = 0.5) {
  n <- .check_n(n)
  .check_probability(prob, "prob")
  stats::runif(n) < prob
}

#' Generate binary (0/1) values
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param values The two values to draw from, as `c(value_for_0, value_for_1)`.
#'   Default `c(0L, 1L)`.
#' @param prob Probability of drawing `values[2]`. Default `0.5`.
#'
#' @return A vector of length `n`, with the same type as `values`.
#' @export
#'
#' @examples
#' fkr_binary(5)
#' fkr_binary(5, values = c("No", "Yes"), prob = 0.8)
fkr_binary <- function(n, values = c(0L, 1L), prob = 0.5) {
  n <- .check_n(n)
  if (length(values) != 2L) {
    stop("`values` must have length 2: c(value_for_0, value_for_1).", call. = FALSE)
  }
  .check_probability(prob, "prob")
  values[fkr_boolean(n, prob = prob) + 1L]
}

#' Generate multiple-response (select-all-that-apply) values
#'
#' Simulates a "select all that apply" survey item: each generated value
#' is one or more entries from `values` combined together, e.g. with
#' `values = LETTERS[1:4]` a result might be `"A"`, `"AC"`, or `"ABCD"`.
#' Selected entries always keep their original order from `values` (so
#' `"AC"` can occur but `"CA"` cannot), and never repeat within a single
#' generated value.
#'
#' The number of entries selected for each value is drawn uniformly from
#' `1:length(values)` (not uniformly over all non-empty subsets), so
#' picking exactly 1 entry is just as likely as picking all of them.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param values A non-empty vector of candidate entries, with no `NA`s,
#'   to combine (e.g. `LETTERS[1:4]`, or option labels like
#'   `c("Email", "Phone", "SMS")`).
#' @param multiple If `TRUE` (default), each generated value may combine
#'   more than one entry from `values`. If `FALSE`, exactly one entry is
#'   drawn per value, as in a single-response ("select one") item.
#' @param sep String used to join multiple selected entries together.
#'   Default `""`, which reads naturally when `values` are single
#'   characters (e.g. `"AC"`); for multi-character `values`, pass
#'   something like `sep = ", "` to keep entries distinguishable (e.g.
#'   `"Email, SMS"`).
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_multiple_response(5, values = LETTERS[1:4])
#' fkr_multiple_response(5, values = c("Email", "Phone", "SMS"), sep = ", ")
#' fkr_multiple_response(5, values = LETTERS[1:4], multiple = FALSE)
fkr_multiple_response <- function(n, values, multiple = TRUE, sep = "") {
  n <- .check_n(n)
  if (!is.atomic(values) || length(values) < 1L || anyNA(values)) {
    stop("`values` must be a non-empty atomic vector with no NAs.", call. = FALSE)
  }
  if (!is.logical(multiple) || length(multiple) != 1L || is.na(multiple)) {
    stop("`multiple` must be a single TRUE/FALSE value.", call. = FALSE)
  }
  .check_scalar_string(sep, "sep")

  if (n == 0L) return(character(0))

  m <- length(values)

  if (!multiple) {
    return(as.character(values[sample.int(m, n, replace = TRUE)]))
  }

  vapply(seq_len(n), function(i) {
    k <- sample.int(m, 1L)
    chosen <- sort(sample.int(m, k))
    paste(values[chosen], collapse = sep)
  }, character(1))
}

#' Generate numbers
#'
#' Draws numbers uniformly at random between `min` and `max`.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param min Minimum value (inclusive). Default `0`.
#' @param max Maximum value (inclusive). Default `1`. Must be `>= min`.
#' @param decimals Number of decimal places to round to. Default `2`.
#'
#' @return A numeric vector of length `n`.
#' @export
#'
#' @examples
#' fkr_num(5)
#' fkr_num(5, min = 0, max = 100, decimals = 1)
fkr_num <- function(n, min = 0, max = 1, decimals = 2) {
  n <- .check_n(n)
  if (!is.numeric(min) || length(min) != 1L || is.na(min)) {
    stop("`min` must be a single number.", call. = FALSE)
  }
  if (!is.numeric(max) || length(max) != 1L || is.na(max) || max < min) {
    stop("`max` must be a single number greater than or equal to `min`.", call. = FALSE)
  }
  if (!is.numeric(decimals) || length(decimals) != 1L || is.na(decimals) ||
      decimals != as.integer(decimals) || decimals < 0) {
    stop("`decimals` must be a single non-negative whole number.", call. = FALSE)
  }

  round(stats::runif(n, min, max), decimals)
}

#' Generate whole numbers
#'
#' Draws integers uniformly at random between `min` and `max`, inclusive.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param min Minimum value (inclusive). Default `0`.
#' @param max Maximum value (inclusive). Default `100`. Must be `>= min`.
#'
#' @return An integer vector of length `n`.
#' @export
#'
#' @examples
#' fkr_int(5)
#' fkr_int(5, min = 18, max = 65)
fkr_int <- function(n, min = 0, max = 100) {
  n <- .check_n(n)
  if (!is.numeric(min) || length(min) != 1L || is.na(min) || min != as.integer(min)) {
    stop("`min` must be a single whole number.", call. = FALSE)
  }
  if (!is.numeric(max) || length(max) != 1L || is.na(max) || max != as.integer(max) || max < min) {
    stop("`max` must be a single whole number greater than or equal to `min`.", call. = FALSE)
  }

  as.integer(.sample_weighted(n, as.integer(min):as.integer(max)))
}

#' Generate a factor variable with value labels and an optional variable label
#'
#' Draws from `values` (the underlying, often numeric, codes) and
#' returns a [factor()] over them, optionally relabeled with
#' human-readable `labels` (the value set) and tagged with a `label` (a
#' variable-level description), mirroring the "variable label" /
#' "value labels" distinction common in survey/statistical data (e.g.
#' SPSS, Stata, \pkg{haven}).
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param values A non-empty atomic vector of underlying codes/levels,
#'   with no `NA`s (e.g. `c(1, 2)` or `c("M", "F")`).
#' @param labels Optional character vector of display labels, the same
#'   length as `values` and in the same order (e.g. `c("Male", "Female")`
#'   for `values = c(1, 2)`). If `NULL` (default), `values` are used as
#'   their own labels, as in a plain [factor()].
#' @param label Optional single string describing the variable itself
#'   (e.g. `"Respondent's biological sex"`), attached as
#'   `attr(x, "label")` -- not to be confused with `labels`, the
#'   per-value display text.
#' @param prob Optional numeric vector of sampling weights, the same
#'   length as `values`. Default `NULL` draws every value with equal
#'   probability.
#'
#' @return A `factor` of length `n` with levels `values` (coerced to
#'   character, per [factor()]'s usual behavior) and, if given, an
#'   `attr(x, "label")` variable description. Note that
#'   `as.integer()` on the result gives each value's *position* in
#'   `values`, not the original code -- use `levels()` or `as.character()`
#'   to recover the original values.
#' @export
#'
#' @examples
#' fkr_factor(5, values = c(1, 2), labels = c("Male", "Female"))
#' fkr_factor(5,
#'   values = c(1, 2), labels = c("Male", "Female"),
#'   label = "Respondent's biological sex"
#' )
#' fkr_factor(5, values = c(1, 2, 3), prob = c(0.7, 0.2, 0.1))
fkr_factor <- function(n, values, labels = NULL, label = NULL, prob = NULL) {
  n <- .check_n(n)
  if (!is.atomic(values) || length(values) < 1L || anyNA(values)) {
    stop("`values` must be a non-empty atomic vector with no NAs.", call. = FALSE)
  }
  if (!is.null(labels) && (length(labels) != length(values) || anyNA(labels))) {
    stop("`labels` must be the same length as `values`, with no NAs.", call. = FALSE)
  }
  if (!is.null(label)) {
    .check_scalar_string(label, "label")
  }
  if (!is.null(prob) && (!is.numeric(prob) || anyNA(prob) || any(prob < 0))) {
    stop("`prob` must be a non-negative numeric vector with no NAs.", call. = FALSE)
  }

  codes <- .sample_weighted(n, values, weights = prob)
  result <- factor(codes, levels = values, labels = if (is.null(labels)) as.character(values) else labels)

  if (!is.null(label)) {
    attr(result, "label") <- label
  }

  result
}
