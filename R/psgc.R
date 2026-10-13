.psgc_level_map <- c(
  region = "Reg", province = "Prov", city = "City", municipality = "Mun", barangay = "Bgy"
)

.get_psgc_table <- function() {
  .cached("psgc", function() psgc::get_psgc())
}

# PSGC spells almost every city "City of <Name>" (e.g. "City of Davao"),
# except for a handful of historical exceptions ("Quezon City"). Strip
# either form down to its bare name so fkr_city()-style inputs like
# "Davao City" still resolve.
.psgc_norm_city_name <- function(x) {
  x <- tolower(trimws(x))
  x <- sub("^city of ", "", x)
  x <- sub(" city$", "", x)
  x
}

.match_psgc_city <- function(df, city) {
  hit <- df[df$geographic_level %in% c("City", "Mun") & df$area_name == city, ]
  if (nrow(hit) > 0L) return(hit)

  norm <- .psgc_norm_city_name(city)
  hit <- df[df$geographic_level %in% c("City", "Mun") & vapply(df$area_name, .psgc_norm_city_name, character(1)) == norm, ]
  if (nrow(hit) > 1L && any(hit$geographic_level == "City")) {
    hit <- hit[hit$geographic_level == "City", ]
  }
  hit
}

.filter_psgc_rows <- function(df, level, region = NULL, province = NULL, city = NULL) {
  prefix <- NULL

  if (!is.null(region)) {
    .check_scalar_string(region, "region")
    hit <- df[df$geographic_level == "Reg" & df$area_name == region, ]
    if (nrow(hit) == 0L) {
      stop("`region` is not a recognized PSGC region name. See unique(psgc::get_psgc(geographic_level = \"Reg\")$area_name) for valid values.",
           call. = FALSE)
    }
    prefix <- substr(hit$psgc_code[1], 1, 2)
  }

  if (!is.null(province)) {
    .check_scalar_string(province, "province")
    hit <- df[df$geographic_level == "Prov" & df$area_name == province, ]
    if (!is.null(prefix)) hit <- hit[substr(hit$psgc_code, 1, 2) == prefix, ]
    if (nrow(hit) == 0L) {
      stop("`province` is not a recognized PSGC province name (optionally within the given `region`).",
           call. = FALSE)
    }
    prefix <- substr(hit$psgc_code[1], 1, 5)
  }

  if (!is.null(city)) {
    .check_scalar_string(city, "city")
    hit <- .match_psgc_city(df, city)
    if (!is.null(prefix)) hit <- hit[substr(hit$psgc_code, 1, nchar(prefix)) == prefix, ]
    if (nrow(hit) == 0L) {
      stop("`city` is not a recognized PSGC city/municipality name (optionally within the given `region`/`province`).",
           call. = FALSE)
    }
    prefix <- substr(hit$psgc_code[1], 1, 8)
  }

  target <- df[df$geographic_level == .psgc_level_map[[level]], ]
  if (!is.null(prefix)) {
    target <- target[substr(target$psgc_code, 1, nchar(prefix)) == prefix, ]
  }
  target
}

#' Generate Philippine Standard Geographic Code (PSGC) codes
#'
#' Draws real PSGC codes -- the Philippine Statistics Authority's official
#' hierarchical coding system for regions, provinces, cities,
#' municipalities, and barangays -- at the requested level, optionally
#' restricted to a specific region/province/city.
#'
#' Codes are fetched live via the \pkg{psgc} package (which caches its
#' data locally after the first call) and kept in memory for the rest of
#' the R session, so the first call in a session may require network
#' access.
#'
#' @param n Number of codes to generate. A single non-negative whole number.
#' @param level Geographic level of the code: `"region"`, `"province"`,
#'   `"city"`, `"municipality"`, or `"barangay"`. Default `"city"`.
#' @param region Optional region name to restrict the draw to (see
#'   [fkr_region()]).
#' @param province Optional province name to restrict the draw to (see
#'   [fkr_province()]).
#' @param city Optional city/municipality name to restrict the draw to
#'   (useful with `level = "barangay"` to get barangay codes within a
#'   specific city, or on its own to look up a specific city's code).
#'
#' @return A character vector of length `n` of 9- or 10-digit PSGC codes.
#' @export
#'
#' @examplesIf interactive()
#' fkr_psgc_code(5)
#' fkr_psgc_code(5, level = "region")
#' fkr_psgc_code(5, level = "barangay", city = "Davao City")
fkr_psgc_code <- function(n, level = c("city", "region", "province", "municipality", "barangay"), region = NULL, province = NULL, city = NULL) {
  n <- .check_n(n)
  level <- match.arg(level)

  df <- .get_psgc_table()
  rows <- .filter_psgc_rows(df, level, region = region, province = province, city = city)
  if (nrow(rows) == 0L) {
    stop("No PSGC area matches the given level/region/province/city combination.", call. = FALSE)
  }

  if (n == 0L) return(character(0))
  sample(rows$psgc_code, n, replace = TRUE)
}
