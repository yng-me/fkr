#' Generate a complete fake dataset
#'
#' A dataset-level abstraction over the individual `fkr_*()`
#' generators: describe each column with a `specs` list and get back a
#' single, ready-to-use `data.frame` with `n` rows.
#'
#' @param n Number of rows to generate. A single non-negative whole number.
#' @param specs A named list describing each column. Names become
#'   column names and must be unique and non-empty. Each element can be:
#'   * A **function of `n`** -- the common case -- called as `spec(n)`.
#'     This covers every `fkr_*()` generator directly, including ones
#'     with extra optional arguments (their defaults just apply), and
#'     `function(n) fkr_city(n, province = "Cebu")` to fix extra
#'     arguments.
#'   * A **function with a `data` argument** -- for a column that
#'     depends on columns generated earlier in `specs` -- called as
#'     `spec(n, data = data)`, where `data` is the partial result built
#'     so far (a `data.frame` with one column per already-processed
#'     spec, in `specs` order). The argument must be named exactly
#'     `data` for this to trigger; its position doesn't matter.
#'   * An **already-generated vector or data.frame** with length/`nrow`
#'     equal to `n`.
#'   * A **single scalar**, recycled to length `n` (e.g. a constant
#'     column like `country = "Philippines"`).
#'
#'   When a spec (whether a function's result or a literal value) is a
#'   `data.frame` -- e.g. [fkr_address()] or [fkr_coordinates()] --
#'   its columns are flattened into the output, prefixed with the
#'   spec's own name (`address` becomes `address_street`,
#'   `address_city`, ...).
#'
#' @section Age/birthday consistency:
#' If [fkr_age()] and either [fkr_birthday()] or
#' [fkr_birthday_split()] both appear *unwrapped* (i.e. passed as the
#' bare function, not e.g. `function(n) fkr_age(n, age_range = 18:65)`)
#' among `specs`, `fkr()` draws the age once and feeds it to the
#' birthday spec(s), so the generated age and the age implied by the
#' birthdate always agree -- instead of each independently drawing its
#' own random age. Wrap either in an anonymous function (even a trivial
#' `function(n) fkr_age(n)`) to opt out and get independent draws.
#'
#' @return A `data.frame` with `n` rows and one column per (flattened)
#'   spec, in the order given in `specs`.
#' @export
#'
#' @examples
#' fkr_seed(1)
#' fkr(5, list(
#'   first_name = fkr_first_name,
#'   last_name = fkr_last_name,
#'   sex = fkr_sex,
#'   age = fkr_age,
#'   date_of_birth = fkr_birthday,
#'   address = fkr_address,
#'   coordinates = fkr_coordinates
#' ))
#'
#' # A column that depends on one generated earlier in `specs`:
#' fkr(5, list(
#'   age = fkr_age,
#'   civil_status = function(n, data) {
#'     ifelse(data$age < 18, "Single", fkr_civil_status(n))
#'   }
#' ))
fkr <- function(n, specs) {
  n <- .check_n(n)

  if (!is.list(specs) || length(specs) == 0L) {
    stop("`specs` must be a non-empty list.", call. = FALSE)
  }
  spec_names <- names(specs)
  if (is.null(spec_names) || anyNA(spec_names) || any(!nzchar(spec_names))) {
    stop("Every element of `specs` must have a non-empty name.", call. = FALSE)
  }
  if (anyDuplicated(spec_names) != 0L) {
    stop("`specs` names must be unique; found duplicate(s): ",
         paste(unique(spec_names[duplicated(spec_names)]), collapse = ", "), call. = FALSE)
  }

  is_age_spec <- function(spec) identical(spec, fkr_age)
  is_birthday_spec <- function(spec) identical(spec, fkr_birthday) || identical(spec, fkr_birthday_split)

  shared_age <- NULL
  if (any(vapply(specs, is_age_spec, logical(1))) && any(vapply(specs, is_birthday_spec, logical(1)))) {
    shared_age <- fkr_age(n)
  }

  columns <- list()

  for (nm in spec_names) {
    spec <- specs[[nm]]

    if (!is.null(shared_age) && is_age_spec(spec)) {
      value <- shared_age
    } else if (!is.null(shared_age) && is_birthday_spec(spec)) {
      value <- spec(n, age = shared_age)
    } else if (is.function(spec)) {
      spec_formals <- names(formals(spec))
      if (length(spec_formals) == 0L) {
        stop(sprintf(
          "Spec `%s` is a function but takes no arguments; it must take `n` (and optionally a `data` argument).",
          nm
        ), call. = FALSE)
      }
      if ("data" %in% spec_formals) {
        partial <- if (length(columns) == 0L) {
          data.frame(row.names = seq_len(n))
        } else {
          as.data.frame(columns, stringsAsFactors = FALSE, check.names = FALSE)
        }
        value <- spec(n, data = partial)
      } else {
        value <- spec(n)
      }
    } else if (!is.data.frame(spec) && !is.list(spec) && length(spec) == 1L) {
      value <- rep(spec, n)
    } else {
      value <- spec
    }

    len <- if (is.data.frame(value)) nrow(value) else NROW(value)
    if (len != n) {
      stop(sprintf("Spec `%s` produced %d row(s)/element(s); expected %d.", nm, len, n), call. = FALSE)
    }

    if (is.data.frame(value)) {
      names(value) <- paste0(nm, "_", names(value))
      for (col in names(value)) columns[[col]] <- value[[col]]
    } else {
      columns[[nm]] <- value
    }
  }

  as.data.frame(columns, stringsAsFactors = FALSE, check.names = FALSE)
}
