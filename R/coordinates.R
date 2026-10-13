#' Generate Philippine latitude/longitude coordinates
#'
#' Draws a point uniformly at random within the decimal-degree bounding
#' box of the Philippines, or of a single region if `region` is given.
#' Bounding boxes are region-level approximations (not survey-grade), so
#' a point is guaranteed to fall in roughly the right part of the
#' archipelago, not necessarily on land.
#'
#' @param n Number of coordinate pairs to generate. A single
#'   non-negative whole number.
#' @param region Optional region name to restrict the draw to (one of
#'   [fkr_region()]'s possible outputs). If `NULL` (default), draws
#'   from the bounding box of the whole country.
#' @param precision Number of decimal places to round `latitude`/
#'   `longitude` to. Default `10`.
#'
#' @return A `data.frame` with `n` rows and numeric columns `latitude`
#'   and `longitude`, each rounded to `precision` decimal places.
#' @export
#'
#' @examples
#' fkr_coordinates(5)
#' fkr_coordinates(5, region = "National Capital Region (NCR)")
fkr_coordinates <- function(n, region = NULL, precision = 10) {
  n <- .check_n(n)
  if (!is.numeric(precision) || length(precision) != 1L || is.na(precision) ||
      precision != as.integer(precision) || precision < 0) {
    stop("`precision` must be a single non-negative whole number.", call. = FALSE)
  }

  if (is.null(region)) {
    bbox <- data.frame(
      lat_min = min(.ph_region_bbox$lat_min), lat_max = max(.ph_region_bbox$lat_max),
      lon_min = min(.ph_region_bbox$lon_min), lon_max = max(.ph_region_bbox$lon_max)
    )
  } else {
    .check_scalar_string(region, "region")
    .check_choice(region, .ph_region_bbox$region, "region")
    bbox <- .ph_region_bbox[.ph_region_bbox$region == region, ]
  }

  if (n == 0L) {
    return(data.frame(latitude = numeric(0), longitude = numeric(0)))
  }

  data.frame(
    latitude = round(stats::runif(n, bbox$lat_min, bbox$lat_max), precision),
    longitude = round(stats::runif(n, bbox$lon_min, bbox$lon_max), precision)
  )
}
