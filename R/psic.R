.psic_level_code <- c(sections = 1L, divisions = 2L, groups = 3L, classes = 4L, `sub-classes` = 5L)

# PSIC/ISIC Rev.4 sections are defined by explicit division-number
# ranges (there is no shared code prefix between a section's letter and
# its divisions' digits, unlike PSOC), confirmed against phscs's own
# division list.
.psic_section_ranges <- data.frame(
  section = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U"),
  from =    c( 1,   5,  10,  35,  36,  41,  45,  49,  55,  58,  64,  68,  69,  77,  84,  85,  86,  90,  94,  97,  99),
  to =      c( 3,   9,  33,  35,  39,  43,  47,  53,  56,  63,  66,  68,  75,  82,  84,  85,  88,  93,  96,  98,  99),
  stringsAsFactors = FALSE
)

.get_psic_table <- function() {
  .cached("psic", function() {
    raw <- phscs::get_psic(level = "all", minimal = FALSE)

    sections <- raw[raw$level == 1L, c("value", "label")]
    names(sections) <- c("section_code", "section_title")

    division_num <- suppressWarnings(as.integer(substr(raw$value, 1, 2)))
    section_code <- vapply(division_num, function(d) {
      hit <- which(.psic_section_ranges$from <= d & d <= .psic_section_ranges$to)
      if (length(hit) == 0L) NA_character_ else .psic_section_ranges$section[hit[1]]
    }, character(1))
    raw$section_code <- ifelse(raw$level == 1L, raw$value, section_code)

    merged <- merge(raw, sections, by = "section_code", all.x = TRUE)
    merged[order(merged$level, merged$value), ]
  })
}

#' Generate PSIC-classified industries
#'
#' Draws industry/economic-activity titles from the Philippine Standard
#' Industrial Classification (PSIC), the Philippine Statistics
#' Authority's official industry taxonomy (aligned with ISIC Rev. 4),
#' together with their real classification code. Complements
#' [fkr_industry()], which draws from an informal, uncoded list.
#'
#' Data is fetched live via the \pkg{phscs} package (which caches its
#' data locally after the first call) and kept in memory for the rest of
#' the R session, so the first call in a session may require network
#' access.
#'
#' @param n Number of industries to generate. A single non-negative
#'   whole number.
#' @param level PSIC hierarchy level to draw from: `"sections"`
#'   (broadest, e.g. "Manufacturing"), `"divisions"`, `"groups"`,
#'   `"classes"`, or `"sub-classes"` (most specific). Default `"divisions"`.
#' @param section Optional section title to restrict the draw to (e.g.
#'   `"Manufacturing"`, `"Construction"`). See [fkr_psic_industry()]'s
#'   `section` output column for valid values.
#'
#' @return A `data.frame` with `n` rows and columns `title` (the
#'   industry/activity title), `psic_code` (its PSIC code), and
#'   `section` (its top-level PSIC section title).
#' @export
#'
#' @examplesIf interactive()
#' fkr_psic_industry(5)
#' fkr_psic_industry(5, level = "sections")
#' fkr_psic_industry(5, section = "Manufacturing")
fkr_psic_industry <- function(n, level = c("divisions", "sections", "groups", "classes", "sub-classes"), section = NULL) {
  n <- .check_n(n)
  level <- match.arg(level)

  df <- .get_psic_table()
  rows <- df[df$level == .psic_level_code[[level]], ]

  if (!is.null(section)) {
    .check_scalar_string(section, "section")
    .check_choice(section, unique(df$section_title), "section")
    rows <- rows[rows$section_title == section, ]
  }

  if (n == 0L) {
    return(data.frame(title = character(0), psic_code = character(0), section = character(0), stringsAsFactors = FALSE))
  }

  picked <- sample(nrow(rows), n, replace = TRUE)
  data.frame(
    title = rows$label[picked],
    psic_code = rows$value[picked],
    section = rows$section_title[picked],
    stringsAsFactors = FALSE
  )
}
