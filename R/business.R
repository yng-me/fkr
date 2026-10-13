#' Generate company names
#'
#' Builds realistic Philippine business names by combining one or two
#' surnames, a business-type word, and a corporate suffix (e.g.
#' `"Dela Cruz Trading Corp."`, `"Santos & Reyes Enterprises, Inc."`).
#'
#' @param n Number of company names to generate. A single non-negative
#'   whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_company(5)
fkr_company <- function(n) {
  n <- .check_n(n)

  founder <- fkr_last_name(n)
  two_founders <- stats::runif(n) < 0.3
  co_founder <- fkr_last_name(sum(two_founders))

  name_part <- founder
  name_part[two_founders] <- paste(founder[two_founders], "&", co_founder)

  word <- .sample_weighted(n, .ph_company_words)
  suffix <- fkr_company_suffix(n)

  trimws(paste(name_part, word, suffix))
}

#' Generate company suffixes
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n` (e.g. `"Inc."`, `"Corp."`, `"OPC"`).
#' @export
#'
#' @examples
#' fkr_company_suffix(5)
fkr_company_suffix <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_company_suffixes)
}

#' Generate industry names
#'
#' Draws from industries prominent in the Philippine economy (e.g. BPO,
#' agriculture, remittance services).
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_industry(5)
fkr_industry <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_industries)
}

#' Generate job titles
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_job_title(5)
fkr_job_title <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_job_titles)
}

#' Generate company department names
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_department(5)
fkr_department <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_departments)
}

#' Generate product names
#'
#' Draws from a curated list of products typical of Philippine retail and
#' sari-sari (small variety) stores.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_product(5)
fkr_product <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_product_items)
}

#' Generate prices in Philippine pesos
#'
#' Draws prices on a log scale between `min` and `max` so that, like real
#' retail pricing, low values are much more common than high ones.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param min Minimum price. Default `10`.
#' @param max Maximum price. Default `10000`. Must be greater than `min`.
#' @param format `"currency"` (default) returns a formatted character
#'   vector like `"PHP 1,234.56"`; `"numeric"` returns a raw numeric
#'   vector rounded to 2 decimal places.
#'
#' @return A character vector (if `format = "currency"`) or numeric
#'   vector (if `format = "numeric"`) of length `n`.
#' @export
#'
#' @examples
#' fkr_price(5)
#' fkr_price(5, min = 100, max = 500, format = "numeric")
fkr_price <- function(n, min = 10, max = 10000, format = c("currency", "numeric")) {
  n <- .check_n(n)
  format <- match.arg(format)

  if (!is.numeric(min) || length(min) != 1L || is.na(min) || min < 0) {
    stop("`min` must be a single non-negative number.", call. = FALSE)
  }
  if (!is.numeric(max) || length(max) != 1L || is.na(max) || max <= min) {
    stop("`max` must be a single number greater than `min`.", call. = FALSE)
  }

  if (n == 0L) return(if (format == "numeric") numeric(0) else character(0))

  min_pos <- max(min, 0.01)
  values <- round(exp(stats::runif(n, log(min_pos), log(max))), 2)
  values <- pmax(values, min)

  if (format == "numeric") return(values)

  paste0("PHP ", formatC(values, format = "f", digits = 2, big.mark = ","))
}

#' Generate business/mayor's permit-style numbers
#'
#' Produces values matching the `BP-YYYY-NNNNNN` format commonly used by
#' local government Business Permits and Licensing Offices (BPLOs).
#' **The digits are uniformly random** and do not correspond to any real
#' business; see the package-level disclaimer in `?fkr`.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param year Permit year. Default is the current year. Must be a single
#'   4-digit whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_business_permit_number(5)
#' fkr_business_permit_number(5, year = 2023)
fkr_business_permit_number <- function(n, year = as.integer(format(Sys.Date(), "%Y"))) {
  n <- .check_n(n)
  if (!is.numeric(year) || length(year) != 1L || is.na(year) ||
      year != as.integer(year) || year < 1900 || year > 9999) {
    stop("`year` must be a single 4-digit whole number.", call. = FALSE)
  }
  if (n == 0L) return(character(0))
  paste0("BP-", as.integer(year), "-", .random_digit_string(n, 6))
}
