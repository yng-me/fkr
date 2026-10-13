#' Generate UUIDs
#'
#' Generates random (version 4, RFC 4122) universally unique identifiers.
#'
#' @param n Number of UUIDs to generate. A single non-negative whole number.
#' @param version UUID version to generate. Only `4` (random) is
#'   currently supported.
#'
#' @return A character vector of length `n`, formatted as
#'   `"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"` (lowercase hex, with the
#'   version nibble fixed to `4` and the variant nibble one of `8`, `9`,
#'   `a`, `b`).
#' @export
#'
#' @examples
#' fkr_uuid(5)
fkr_uuid <- function(n, version = 4) {
  n <- .check_n(n)
  if (!identical(version, 4) && !identical(version, 4L)) {
    stop("`version` must be 4 (only version-4 random UUIDs are supported).", call. = FALSE)
  }
  if (n == 0L) return(character(0))

  hex_digits <- c(0:9, letters[1:6])
  variant_digits <- c("8", "9", "a", "b")

  vapply(seq_len(n), function(i) {
    g <- function(k) paste(sample(hex_digits, k, replace = TRUE), collapse = "")
    paste0(
      g(8), "-", g(4), "-", "4", g(3), "-",
      sample(variant_digits, 1), g(3), "-", g(12)
    )
  }, character(1))
}
