#' fkr: Realistic Fake Data Generator for the Philippines
#'
#' `fkr` generates realistic, locale-aware synthetic data for the
#' Philippines: personal data (names, sex, civil status, ages, birthdays,
#' contact details, addresses, government-ID-style numbers) and business
#' data (company names, industries, job titles, departments, products,
#' prices, and permit numbers).
#'
#' @section Conventions:
#' * Every generator's first argument is `n`, the number of values to draw.
#' * Generators sample with replacement, so duplicate values are possible
#'   and expected, just as they would be in a real population sample.
#' * Use [fkr_seed()] before a sequence of calls to make them
#'   reproducible.
#' * Restriction arguments (e.g. `sex`, `region`) are validated against a
#'   fixed, documented set of categories and raise an informative error
#'   (listing the valid choices) when given anything else.
#' * Multi-field results (e.g. [fkr_address()]) are returned as a
#'   `data.frame` with one row per generated record, never as nested
#'   lists, so results compose directly with `cbind()` / `dplyr::bind_cols()`.
#'
#' @section Important disclaimer:
#' Every value produced by this package -- including values formatted to
#' resemble government identifiers (SSS, PhilHealth, Pag-IBIG, TIN,
#' PhilSys) -- is drawn uniformly at random purely for software testing,
#' prototyping, and teaching. These values are synthetic: they are not
#' derived from, do not belong to, and will not validate against any real
#' individual, business, or government record.
#'
#' @keywords internal
#' @aliases fkr-package
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
