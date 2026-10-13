.fkr_id <- function(n, pattern) {
  digits <- .random_digit_string(n, .count_hashes(pattern))
  .apply_digit_pattern(digits, pattern)
}

#' Generate SSS number-style identifiers
#'
#' Produces values matching the `NN-NNNNNNN-N` format used by the
#' Philippine Social Security System. **The digits are uniformly random**
#' and do not correspond to any real SSS member; see the package-level
#' disclaimer in `?fkr`.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_sss_number(5)
fkr_sss_number <- function(n) {
  n <- .check_n(n)
  .fkr_id(n, "##-#######-#")
}

#' Generate TIN-style identifiers
#'
#' Produces values matching the `NNN-NNN-NNN-NNN` format used for
#' Philippine Bureau of Internal Revenue Tax Identification Numbers.
#' **The digits are uniformly random** and do not correspond to any real
#' taxpayer; see the package-level disclaimer in `?fkr`.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_tin_number(5)
fkr_tin_number <- function(n) {
  n <- .check_n(n)
  .fkr_id(n, "###-###-###-###")
}

#' Generate PhilHealth number-style identifiers
#'
#' Produces values matching the `NN-NNNNNNNNN-N` format used by the
#' Philippine Health Insurance Corporation. **The digits are uniformly
#' random** and do not correspond to any real member; see the
#' package-level disclaimer in `?fkr`.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_philhealth_number(5)
fkr_philhealth_number <- function(n) {
  n <- .check_n(n)
  .fkr_id(n, "##-#########-#")
}

#' Generate Pag-IBIG (HDMF) number-style identifiers
#'
#' Produces values matching the `NNNN-NNNN-NNNN` format used by the Home
#' Development Mutual Fund (Pag-IBIG Fund). **The digits are uniformly
#' random** and do not correspond to any real member; see the
#' package-level disclaimer in `?fkr`.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_pagibig_number(5)
fkr_pagibig_number <- function(n) {
  n <- .check_n(n)
  .fkr_id(n, "####-####-####")
}

#' Generate PhilSys Number (PSN) card-style identifiers
#'
#' Produces values matching the `NNNN-NNNN-NNNN-NNNN` format printed on
#' the Philippine national ID (PhilSys). **The digits are uniformly
#' random** and do not correspond to any real registrant; see the
#' package-level disclaimer in `?fkr`.
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_philsys_number(5)
fkr_philsys_number <- function(n) {
  n <- .check_n(n)
  .fkr_id(n, "####-####-####-####")
}
