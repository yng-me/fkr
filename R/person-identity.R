#' Generate Filipino first names
#'
#' Draws `n` given names from a lookup of ~700 male and ~760 female
#' Filipino first names, optionally restricted by sex.
#'
#' @param n Number of names to generate. A single non-negative whole number.
#' @param sex Restrict the draw to `"male"` or `"female"` names, or
#'   `"any"` (the default) to draw from both pools combined.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_first_name(5)
#' fkr_first_name(5, sex = "female")
fkr_first_name <- function(n, sex = c("any", "male", "female")) {
  n <- .check_n(n)
  sex <- match.arg(sex)

  pool <- switch(
    sex,
    male = .ph_male_names,
    female = .ph_female_names,
    any = c(.ph_male_names, .ph_female_names)
  )

  .sample_weighted(n, pool)
}

#' Generate Filipino last names (surnames)
#'
#' Draws `n` surnames from the ~1,000 most common Philippine surnames,
#' ranked by real-world frequency (Spanish-derived names like
#' "Dela Cruz", "Garcia", and "Reyes" dominate the Philippine namescape).
#' By default the draw is weighted by that ranking, so rank-1 surnames
#' come up far more often than rank-1000 ones, the way they would in an
#' actual population sample.
#'
#' @param n Number of surnames to generate. A single non-negative whole number.
#' @param weighted If `TRUE` (default), weight the draw by real-world
#'   frequency rank. If `FALSE`, draw uniformly from all ~1,000 surnames.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_last_name(5)
#' fkr_last_name(5, weighted = FALSE)
fkr_last_name <- function(n, weighted = TRUE) {
  n <- .check_n(n)
  if (!is.logical(weighted) || length(weighted) != 1L || is.na(weighted)) {
    stop("`weighted` must be a single TRUE/FALSE value.", call. = FALSE)
  }
  .sample_weighted(n, .ph_surnames, weights = if (weighted) .ph_surname_weights else NULL)
}

#' Generate full Filipino names
#'
#' Combines [fkr_first_name()] and [fkr_last_name()], optionally with a
#' middle initial, in the common Filipino "First Middle. Last" convention.
#'
#' @param n Number of names to generate. A single non-negative whole number.
#' @param sex Restrict the given name to `"male"`, `"female"`, or `"any"`
#'   (default).
#' @param middle_initial If `TRUE`, include a random middle initial
#'   (e.g. `"Juan D. Dela Cruz"`). Default `FALSE`.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_full_name(5)
#' fkr_full_name(5, sex = "male", middle_initial = TRUE)
fkr_full_name <- function(n, sex = c("any", "male", "female"), middle_initial = FALSE) {
  n <- .check_n(n)
  sex <- match.arg(sex)
  if (!is.logical(middle_initial) || length(middle_initial) != 1L || is.na(middle_initial)) {
    stop("`middle_initial` must be a single TRUE/FALSE value.", call. = FALSE)
  }
  if (n == 0L) return(character(0))

  first <- fkr_first_name(n, sex = sex)
  last <- fkr_last_name(n)

  if (!middle_initial) {
    return(trimws(paste(first, last)))
  }

  middle <- paste0(sample(LETTERS, n, replace = TRUE), ".")
  trimws(vapply(
    seq_len(n),
    function(i) .paste_na_omit(c(first[i], middle[i], last[i])),
    character(1)
  ))
}

#' Generate biological sex
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param levels Labels to use for the two sexes, as
#'   `c(male_label, female_label)`. Defaults to `c("Male", "Female")`.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_sex(5)
fkr_sex <- function(n, levels = c("Male", "Female")) {
  n <- .check_n(n)
  if (!is.character(levels) || length(levels) != 2L || anyNA(levels)) {
    stop("`levels` must be a character vector of length 2: c(male_label, female_label).",
         call. = FALSE)
  }
  .sample_weighted(n, levels)
}

#' Generate civil status
#'
#' Draws from the civil status categories used on Philippine government
#' and civil registry forms.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`, one of `"Single"`, `"Married"`,
#'   `"Widowed"`, `"Separated"`, or `"Annulled"`.
#' @export
#'
#' @examples
#' fkr_civil_status(5)
fkr_civil_status <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_civil_status, weights = c(0.45, 0.42, 0.06, 0.05, 0.02))
}
