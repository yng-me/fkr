.filter_geo_rows <- function(region = NULL, province = NULL, city = NULL) {
  rows <- seq_len(nrow(.ph_geo))

  if (!is.null(region)) {
    .check_scalar_string(region, "region")
    .check_choice(region, .ph_regions, "region")
    rows <- rows[.ph_geo$region[rows] == region]
  }
  if (!is.null(province)) {
    .check_scalar_string(province, "province")
    .check_choice(province, unique(.ph_geo$province), "province")
    rows <- rows[.ph_geo$province[rows] == province]
  }
  if (!is.null(city)) {
    .check_scalar_string(city, "city")
    .check_choice(city, unique(.ph_geo$city), "city")
    rows <- rows[.ph_geo$city[rows] == city]
  }

  if (length(rows) == 0L) {
    stop("No matching Philippine location for the given region/province/city combination.",
         call. = FALSE)
  }

  rows
}

#' Generate Philippine regions
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`, drawn from the Philippines'
#'   17 administrative regions.
#' @export
#'
#' @examples
#' fkr_region(5)
fkr_region <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_regions)
}

#' Generate Philippine provinces
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param region Optional region name to restrict the draw to (one of
#'   [fkr_region()]'s possible outputs).
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_province(5)
#' fkr_province(5, region = "Region VII (Central Visayas)")
fkr_province <- function(n, region = NULL) {
  n <- .check_n(n)
  rows <- .filter_geo_rows(region = region)
  .sample_weighted(n, unique(.ph_geo$province[rows]))
}

#' Generate Philippine cities/municipalities
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param province Optional province name to restrict the draw to.
#' @param region Optional region name to restrict the draw to.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_city(5)
#' fkr_city(5, province = "Cebu")
fkr_city <- function(n, province = NULL, region = NULL) {
  n <- .check_n(n)
  rows <- .filter_geo_rows(region = region, province = province)
  .sample_weighted(n, .ph_geo$city[rows])
}

#' Generate Philippine ZIP codes
#'
#' @param n Number of values to generate. A single non-negative whole number.
#' @param province Optional province name to restrict the draw to.
#' @param city Optional city/municipality name to restrict the draw to.
#'
#' @return A character vector of length `n` of 4-digit ZIP codes.
#' @export
#'
#' @examples
#' fkr_zip_code(5)
#' fkr_zip_code(5, city = "Davao City")
fkr_zip_code <- function(n, province = NULL, city = NULL) {
  n <- .check_n(n)
  rows <- .filter_geo_rows(province = province, city = city)
  .sample_weighted(n, .ph_geo$zip[rows])
}

#' Generate barangay names
#'
#' Draws from a curated list of barangay names that recur across many
#' Philippine cities and municipalities (e.g. "Poblacion", "San Isidro").
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_barangay(5)
fkr_barangay <- function(n) {
  n <- .check_n(n)
  .sample_weighted(n, .ph_barangays)
}

#' Generate street addresses
#'
#' Generates a house/unit number followed by a common Philippine street
#' name and street type (e.g. `"482 Mabini Street"`).
#'
#' @param n Number of values to generate. A single non-negative whole number.
#'
#' @return A character vector of length `n`.
#' @export
#'
#' @examples
#' fkr_street_address(5)
fkr_street_address <- function(n) {
  n <- .check_n(n)
  house_number <- sample(1:999, n, replace = TRUE)
  street_name <- .sample_weighted(n, .ph_street_names)
  street_type <- .sample_weighted(n, .ph_street_types)
  paste(house_number, street_name, street_type)
}

#' Generate complete, internally-consistent Philippine addresses
#'
#' Each generated row shares a single, real region/province/city/ZIP
#' combination, so unlike calling the individual `fkr_*` geo functions
#' separately, the fields are always geographically consistent with each
#' other.
#'
#' @param n Number of addresses to generate. A single non-negative whole number.
#' @param region Optional region name to restrict the draw to.
#'
#' @return A `data.frame` with `n` rows and character columns `street`,
#'   `barangay`, `city`, `province`, `region`, `zip`.
#' @export
#'
#' @examples
#' fkr_address(5)
fkr_address <- function(n, region = NULL) {
  n <- .check_n(n)
  rows <- .filter_geo_rows(region = region)
  picked <- sample(rows, n, replace = TRUE)

  data.frame(
    street = fkr_street_address(n),
    barangay = fkr_barangay(n),
    city = .ph_geo$city[picked],
    province = .ph_geo$province[picked],
    region = .ph_geo$region[picked],
    zip = .ph_geo$zip[picked],
    stringsAsFactors = FALSE
  )
}
