.clean_for_email <- function(x) {
  gsub("[^a-z0-9]", "", tolower(x))
}

.recycle_to_n <- function(x, n, arg_name) {
  if (length(x) == 1L) return(rep(x, n))
  if (length(x) == n) return(x)
  stop(sprintf("`%s` must have length 1 or length %d (matching `n`).", arg_name, n),
       call. = FALSE)
}

#' Generate email addresses
#'
#' Builds realistic email addresses from (optionally supplied) first and
#' last names, using the mix of free email providers most commonly seen
#' in the Philippines.
#'
#' @param n Number of email addresses to generate. A single non-negative
#'   whole number.
#' @param first_name Optional character vector of first names to build
#'   addresses from. Must have length 1 or length `n`. If `NULL`
#'   (default), names are drawn with [fkr_first_name()].
#' @param last_name Optional character vector of last names, same
#'   recycling rule as `first_name`. If `NULL` (default), names are drawn
#'   with [fkr_last_name()].
#' @param domain Optional character vector of email domains (e.g.
#'   `"gmail.com"`) to use instead of the default weighted provider mix.
#'   Must have length 1 or length `n`.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_email(5)
#' fkr_email(3, first_name = "Juan", last_name = "Dela Cruz")
fkr_email <- function(n, first_name = NULL, last_name = NULL, domain = NULL) {
  n <- .check_n(n)
  if (n == 0L) return(character(0))

  first_name <- if (is.null(first_name)) fkr_first_name(n) else .recycle_to_n(first_name, n, "first_name")
  last_name <- if (is.null(last_name)) fkr_last_name(n) else .recycle_to_n(last_name, n, "last_name")

  domain <- if (is.null(domain)) {
    .sample_weighted(n, .ph_email_domains, weights = .ph_email_domain_weights)
  } else {
    .recycle_to_n(domain, n, "domain")
  }

  separators <- sample(c(".", "_", ""), n, replace = TRUE, prob = c(0.6, 0.15, 0.25))
  suffix_digits <- ifelse(
    stats::runif(n) < 0.4,
    as.character(sample(0:999, n, replace = TRUE)),
    ""
  )

  local_part <- paste0(
    .clean_for_email(first_name), separators, .clean_for_email(last_name), suffix_digits
  )

  paste0(local_part, "@", domain)
}

#' Generate Philippine mobile numbers
#'
#' Draws mobile numbers using real network prefixes (Smart/TNT, Globe/TM,
#' or DITO).
#'
#' @param n Number of mobile numbers to generate. A single non-negative
#'   whole number.
#' @param network Restrict the draw to `"smart"`, `"globe"`, or `"dito"`
#'   prefixes, or `"any"` (default) to mix all networks.
#' @param format `"local"` (default) returns `"09XXXXXXXXX"`;
#'   `"international"` returns `"+639XXXXXXXXX"`.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_mobile_number(5)
#' fkr_mobile_number(5, network = "globe", format = "international")
fkr_mobile_number <- function(n, network = c("any", "smart", "globe", "dito"), format = c("local", "international")) {
  n <- .check_n(n)
  network <- match.arg(network)
  format <- match.arg(format)
  if (n == 0L) return(character(0))

  prefixes <- if (network == "any") unlist(.ph_mobile_prefixes, use.names = FALSE) else .ph_mobile_prefixes[[network]]

  prefix <- .sample_weighted(n, prefixes)
  subscriber <- .random_digit_string(n, 7)
  local <- paste0(prefix, subscriber)

  if (format == "local") local else paste0("+63", substring(local, 2))
}

#' Generate Philippine landline numbers
#'
#' Draws landline numbers using real area codes for Metro Manila and a
#' curated set of major provincial cities.
#'
#' @param n Number of landline numbers to generate. A single non-negative
#'   whole number.
#' @param area_code Optional city name to restrict the area code to (one
#'   of `names(fkr:::.ph_landline_area_codes)`, e.g. `"Cebu"`,
#'   `"Davao"`). If `NULL` (default), a city is drawn at random for each
#'   number.
#'
#' @return A character vector of length `n`, formatted as
#'   `"(area code) subscriber number"`, e.g. `"(02) 8123 4567"` or
#'   `"(032) 234 5678"`.
#' @export
#'
#' @examples
#' fkr_landline_number(5)
#' fkr_landline_number(3, area_code = "Cebu")
fkr_landline_number <- function(n, area_code = NULL) {
  n <- .check_n(n)

  if (is.null(area_code)) {
    cities <- sample(names(.ph_landline_area_codes), n, replace = TRUE)
  } else {
    .check_scalar_string(area_code, "area_code")
    .check_choice(area_code, names(.ph_landline_area_codes), "area_code")
    cities <- rep(area_code, n)
  }

  codes <- unname(.ph_landline_area_codes[cities])

  vapply(codes, function(code) {
    if (code == "02") {
      subscriber <- .random_digit_string(1, 8)
      paste0("(", code, ") ", substr(subscriber, 1, 4), " ", substr(subscriber, 5, 8))
    } else {
      subscriber <- .random_digit_string(1, 7)
      paste0("(", code, ") ", substr(subscriber, 1, 3), " ", substr(subscriber, 4, 7))
    }
  }, character(1), USE.NAMES = FALSE)
}
