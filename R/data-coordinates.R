# Approximate decimal-degree bounding boxes per Philippine region, used by
# fkr_coordinates(). Deliberately coarse (region-level, not city-level)
# -- good enough to place a point within the right part of the archipelago
# for synthetic/test data, not survey-grade. Keys must exactly match
# .ph_regions (R/data-geo.R, kept in sync with the latest PSGC); a test
# enforces this. Region VI/VII boxes are narrowed to exclude Negros
# island, which now has its own Negros Island Region (NIR) entry.

.ph_region_bbox <- data.frame(
  region = c(
    "National Capital Region (NCR)",
    "Region I (Ilocos Region)",
    "Region II (Cagayan Valley)",
    "Region III (Central Luzon)",
    "Region IV-A (CALABARZON)",
    "MIMAROPA Region",
    "Region V (Bicol Region)",
    "Region VI (Western Visayas)",
    "Region VII (Central Visayas)",
    "Region VIII (Eastern Visayas)",
    "Region IX (Zamboanga Peninsula)",
    "Region X (Northern Mindanao)",
    "Region XI (Davao Region)",
    "Region XII (SOCCSKSARGEN)",
    "Region XIII (Caraga)",
    "Cordillera Administrative Region (CAR)",
    "Negros Island Region (NIR)",
    "Bangsamoro Autonomous Region In Muslim Mindanao (BARMM)"
  ),
  lat_min = c(14.35, 15.0, 16.0, 14.5, 13.3, 8.0, 12.2, 10.3, 8.4, 9.5, 6.5, 7.5, 5.5, 5.5, 8.0, 16.2, 8.9, 4.6),
  lat_max = c(14.78, 18.5, 18.6, 16.5, 14.8, 13.5, 14.2, 11.8, 11.3, 12.7, 8.7, 9.0, 8.0, 7.6, 10.4, 17.8, 10.9, 8.0),
  lon_min = c(120.90, 119.6, 121.0, 119.8, 120.3, 116.9, 122.5, 121.8, 123.2, 124.0, 121.8, 123.6, 125.3, 123.9, 125.2, 120.5, 122.6, 119.3),
  lon_max = c(121.15, 120.9, 122.3, 121.4, 122.0, 122.0, 124.3, 123.2, 124.6, 125.8, 123.9, 125.4, 126.6, 125.6, 126.5, 121.4, 123.4, 124.5),
  stringsAsFactors = FALSE
)
