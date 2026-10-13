.psoc_level_code <- c(major = 1L, `sub-major` = 2L, minor = 3L, unit = 4L)

.get_psoc_table <- function() {
  .cached("psoc", function() {
    raw <- phscs::get_psoc(level = "all", minimal = FALSE)

    # phscs stores codes numerically under the hood, which silently drops
    # leading zeros for the Armed Forces branch (major group "0"): e.g. a
    # sub-major code that should read "01" comes back as "1", colliding
    # with major group "1" (Managers). Re-pad every code to its level's
    # canonical width before doing any prefix-based parent lookups.
    width <- c(`1` = 1L, `2` = 2L, `3` = 3L, `4` = 4L)[as.character(raw$level)]
    raw$code <- sprintf(paste0("%0", width, "d"), as.integer(raw$value))

    major <- raw[raw$level == 1L, c("code", "label")]
    names(major) <- c("major_code", "major_title")
    raw$major_code <- substr(raw$code, 1, 1)

    merged <- merge(raw, major, by = "major_code", all.x = TRUE)
    merged[order(merged$level, merged$code), ]
  })
}

#' Generate PSOC-classified occupations
#'
#' Draws occupation titles from the Philippine Standard Occupational
#' Classification (PSOC), the Philippine Statistics Authority's official
#' occupational taxonomy (aligned with ISCO-08), together with their
#' real classification code.
#'
#' Data is fetched live via the \pkg{phscs} package (which caches its
#' data locally after the first call) and kept in memory for the rest of
#' the R session, so the first call in a session may require network
#' access.
#'
#' @param n Number of occupations to generate. A single non-negative
#'   whole number.
#' @param level PSOC hierarchy level to draw from: `"unit"` (most
#'   specific, e.g. "Finance managers"), `"minor"`, `"sub-major"`, or
#'   `"major"` (broadest, e.g. "Managers"). Default `"unit"`.
#' @param major_group Optional major-group title to restrict the draw to
#'   (e.g. `"Professionals"`, `"Elementary Occupations"`). See
#'   [fkr_psoc_occupation()]'s `major_group` output column for valid
#'   values.
#'
#' @return A `data.frame` with `n` rows and columns `title` (the
#'   occupation/group title), `psoc_code` (its PSOC code), and
#'   `major_group` (its top-level PSOC major-group title).
#' @export
#'
#' @examplesIf interactive()
#' fkr_psoc_occupation(5)
#' fkr_psoc_occupation(5, level = "major")
#' fkr_psoc_occupation(5, major_group = "Professionals")
fkr_psoc_occupation <- function(n, level = c("unit", "minor", "sub-major", "major"), major_group = NULL) {
  n <- .check_n(n)
  level <- match.arg(level)

  df <- .get_psoc_table()
  rows <- df[df$level == .psoc_level_code[[level]], ]

  if (!is.null(major_group)) {
    .check_scalar_string(major_group, "major_group")
    .check_choice(major_group, unique(df$major_title), "major_group")
    rows <- rows[rows$major_title == major_group, ]
  }

  if (n == 0L) {
    return(data.frame(title = character(0), psoc_code = character(0), major_group = character(0), stringsAsFactors = FALSE))
  }

  picked <- sample(nrow(rows), n, replace = TRUE)
  data.frame(
    title = rows$label[picked],
    psoc_code = rows$code[picked],
    major_group = rows$major_title[picked],
    stringsAsFactors = FALSE
  )
}
