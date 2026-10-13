test_that("fkr_coordinates stays within the Philippines bounding box", {
  out <- fkr_coordinates(50)
  expect_named(out, c("latitude", "longitude"))
  expect_true(all(out$latitude >= min(.ph_region_bbox$lat_min) & out$latitude <= max(.ph_region_bbox$lat_max)))
  expect_true(all(out$longitude >= min(.ph_region_bbox$lon_min) & out$longitude <= max(.ph_region_bbox$lon_max)))
})

test_that("fkr_coordinates respects the region filter and bbox keys match .ph_regions", {
  expect_setequal(.ph_region_bbox$region, .ph_regions)

  ncr <- "National Capital Region (NCR)"
  bbox <- .ph_region_bbox[.ph_region_bbox$region == ncr, ]
  out <- fkr_coordinates(50, region = ncr)
  expect_true(all(out$latitude >= bbox$lat_min & out$latitude <= bbox$lat_max))
  expect_true(all(out$longitude >= bbox$lon_min & out$longitude <= bbox$lon_max))

  expect_error(fkr_coordinates(5, region = "Narnia"))
})
