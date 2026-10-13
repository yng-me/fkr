# Internal helpers shared by all fkr_* generators.
# Nothing here is exported: names start with "." so the historical
# `exportPattern("^[[:alpha:]]+")` in NAMESPACE (now replaced by explicit
# @export tags) never picks them up.

.check_n <- function(n) {
  if (!is.numeric(n) || length(n) != 1L || is.na(n) ||
      n != as.integer(n) || n < 0) {
    stop("`n` must be a single non-negative whole number, not: ",
         paste(deparse(n), collapse = " "), call. = FALSE)
  }
  as.integer(n)
}

.check_choice <- function(x, choices, arg_name = "value") {
  bad <- setdiff(x, choices)
  if (length(bad) > 0) {
    stop(sprintf(
      "`%s` contains invalid value(s): %s.\nValid choices are: %s.",
      arg_name, paste(bad, collapse = ", "), paste(choices, collapse = ", ")
    ), call. = FALSE)
  }
  invisible(x)
}

.check_scalar_string <- function(x, arg_name = "value") {
  if (!is.character(x) || length(x) != 1L || is.na(x)) {
    stop(sprintf("`%s` must be a single, non-NA character string.", arg_name),
         call. = FALSE)
  }
  invisible(x)
}

.check_probability <- function(p, arg_name = "value") {
  if (!is.numeric(p) || length(p) != 1L || is.na(p) || p < 0 || p > 1) {
    stop(sprintf("`%s` must be a single number between 0 and 1.", arg_name),
         call. = FALSE)
  }
  invisible(p)
}

.sample_weighted <- function(n, values, weights = NULL) {
  if (!is.null(weights) && length(weights) != length(values)) {
    stop("`weights` must be the same length as the values being sampled from.",
         call. = FALSE)
  }
  if (n == 0L) return(values[0])
  # sample() treats a length-1 numeric `values` as shorthand for 1:values
  # rather than "the one value to draw" -- short-circuit that pitfall.
  if (length(values) == 1L) return(rep(values, n))
  sample(values, size = n, replace = TRUE, prob = weights)
}

.paste_na_omit <- function(parts, sep = " ") {
  parts <- parts[!vapply(parts, function(x) is.na(x) || !nzchar(x), logical(1))]
  paste(parts, collapse = sep)
}

.random_digit_string <- function(n_values, n_digits) {
  if (n_values == 0L) return(character(0))
  vapply(
    seq_len(n_values),
    function(i) paste(sample(0:9, n_digits, replace = TRUE), collapse = ""),
    character(1)
  )
}

# Formats a vector of plain digit strings into `pattern`, where each "#" in
# `pattern` consumes the next digit in order, e.g. pattern "##-###" with
# digits "12345" -> "12-345".
.apply_digit_pattern <- function(digit_strings, pattern) {
  vapply(digit_strings, function(digits) {
    digits <- strsplit(digits, "")[[1]]
    out <- character(0)
    di <- 1L
    for (ch in strsplit(pattern, "")[[1]]) {
      if (ch == "#") {
        out <- c(out, digits[di])
        di <- di + 1L
      } else {
        out <- c(out, ch)
      }
    }
    paste(out, collapse = "")
  }, character(1), USE.NAMES = FALSE)
}

.count_hashes <- function(pattern) {
  lengths(regmatches(pattern, gregexpr("#", pattern)))
}

# Session-lifetime cache for the (potentially network-fetched) reference
# tables pulled from the psgc/phscs packages, so fkr_psgc_code(),
# fkr_psoc_occupation(), and fkr_psic_industry() only pay the fetch
# cost once per session instead of on every call.
.fkr_cache <- new.env(parent = emptyenv())

.cached <- function(key, build) {
  if (is.null(.fkr_cache[[key]])) {
    .fkr_cache[[key]] <- build()
  }
  .fkr_cache[[key]]
}
