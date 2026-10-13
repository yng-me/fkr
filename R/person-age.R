.subtract_years <- function(date, years) {
  lt <- as.POSIXlt(date)
  lt$year <- lt$year - years
  as.Date(lt)
}

#' Generate ages
#'
#' Draws `n` ages from `age_range`, weighted by an exponential decay so
#' that, like a real population pyramid, younger ages are more common than
#' older ones by default.
#'
#' @param n Number of ages to generate. A single non-negative whole number.
#' @param age_range Integer vector of candidate ages. Default `0:130`.
#'   All values must be non-negative.
#' @param bias Exponential decay rate applied over `age_range`
#'   (`exp(bias * age)`). Negative values (the default, `-0.05`) make
#'   younger ages more likely; `0` makes every age in `age_range` equally
#'   likely; positive values make older ages more likely.
#'
#' @return An integer vector of length `n`.
#' @export
#'
#' @examples
#' fkr_age(5)
#' fkr_age(5, age_range = 18:65, bias = 0)
fkr_age <- function(n, age_range = 0:130, bias = -0.05) {
  n <- .check_n(n)

  if (!is.numeric(age_range) || length(age_range) == 0L || anyNA(age_range)) {
    stop("`age_range` must be a non-empty numeric vector with no NAs.", call. = FALSE)
  }
  if (min(age_range) < 0) {
    stop("`age_range` must not contain negative ages.", call. = FALSE)
  }
  if (!is.numeric(bias) || length(bias) != 1L || is.na(bias)) {
    stop("`bias` must be a single number.", call. = FALSE)
  }

  weights <- exp(bias * age_range)
  weights <- weights / sum(weights)

  as.integer(.sample_weighted(n, age_range, weights = weights))
}

#' Generate birthdates
#'
#' Generates a birthdate for each of `n` simulated people by first drawing
#' an age with [fkr_age()], then drawing a uniformly random date within
#' that age's exact 1-year window relative to `ref_date`.
#'
#' @param n Number of birthdates to generate. A single non-negative whole number.
#' @param ... Passed on to [fkr_age()] (e.g. `age_range`, `bias`). Ignored
#'   if `age` is supplied.
#' @param age Optional precomputed ages (e.g. from a prior [fkr_age()]
#'   call) to generate birthdates for, instead of drawing new ones. Must
#'   be a non-negative numeric vector of length `n`. Passing this keeps
#'   an `age` column and a `date_of_birth` column consistent with each
#'   other instead of each being drawn independently; [fkr()] does
#'   this automatically when both [fkr_age()] and `fkr_birthday()`
#'   appear (unwrapped) in the same `specs`.
#' @param ref_date Reference "today" that ages are computed against.
#'   Default [Sys.Date()].
#'
#' @return A `Date` vector of length `n`.
#' @export
#'
#' @examples
#' fkr_birthday(5)
#' fkr_birthday(5, age_range = 18:65)
#'
#' ages <- fkr_age(5, age_range = 18:65)
#' fkr_birthday(5, age = ages) # birthdates consistent with `ages`
fkr_birthday <- function(n, ..., age = NULL, ref_date = Sys.Date()) {
  n <- .check_n(n)
  ref_date <- as.Date(ref_date)
  if (length(ref_date) != 1L || is.na(ref_date)) {
    stop("`ref_date` must be a single, valid date.", call. = FALSE)
  }

  if (is.null(age)) {
    ages <- fkr_age(n, ...)
  } else {
    if (length(list(...)) > 0L) {
      stop("`age` cannot be combined with `...` (age_range/bias only apply when drawing a new age).", call. = FALSE)
    }
    if (!is.numeric(age) || length(age) != n || anyNA(age) || any(age < 0)) {
      stop("`age` must be a non-negative numeric vector of length `n`.", call. = FALSE)
    }
    ages <- as.integer(age)
  }

  as.Date(vapply(
    ages,
    function(one_age) {
      latest_birth <- .subtract_years(ref_date, one_age)
      earliest_birth <- .subtract_years(ref_date, one_age + 1L) + 1L

      span <- as.integer(latest_birth - earliest_birth)
      as.character(earliest_birth + sample(0:span, 1))
    },
    character(1)
  ))
}

#' Generate birthdates as separate year/month/day components
#'
#' A convenience wrapper around [fkr_birthday()] that splits each
#' generated date into its year, month, and day parts -- handy for forms
#' that collect date of birth as three separate fields.
#'
#' @param n Number of birthdates to generate. A single non-negative whole number.
#' @param ... Passed on to [fkr_age()] (e.g. `age_range`, `bias`). Ignored
#'   if `age` is supplied.
#' @param age Optional precomputed ages to generate birthdates for; see
#'   [fkr_birthday()]'s `age` argument.
#' @param ref_date Reference "today" that ages are computed against.
#'   Default [Sys.Date()].
#'
#' @return A `data.frame` with `n` rows and character columns `year`
#'   (`"YYYY"`), `month` (`"MM"`), and `day` (`"DD"`).
#' @export
#'
#' @examples
#' fkr_birthday_split(5)
fkr_birthday_split <- function(n, ..., age = NULL, ref_date = Sys.Date()) {
  x <- as.character(fkr_birthday(n, ..., age = age, ref_date = ref_date))

  data.frame(
    year = substr(x, 1, 4),
    month = substr(x, 6, 7),
    day = substr(x, 9, 10),
    stringsAsFactors = FALSE
  )
}
