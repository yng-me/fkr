# Curated Philippine geography data: regions, a representative set of
# provinces, and their major cities/municipalities with real ZIP code
# prefixes. Not exhaustive of all ~1,600 LGUs -- covers all 18 current
# regions with enough breadth for realistic, varied output. Internal
# only -- not exported.
#
# Region/province groupings are kept in sync with the latest PSGC (via
# the psgc package) rather than the pre-2024 region map, in particular:
#   * Negros Occidental and Negros Oriental now form their own
#     Negros Island Region (NIR), not Region VI/VII.
#   * "Region IV-B (MIMAROPA)" is officially just "MIMAROPA Region".
#   * Sulu is coded under Region IX (Zamboanga Peninsula) in PSGC, not
#     BARMM, even though it is a BARMM province politically -- PSGC's
#     numeric region code for it predates BARMM and was never changed.
#   * Maguindanao was split into Maguindanao del Norte/del Sur in 2022;
#     this table keeps a single representative row (del Norte).

.ph_geo <- data.frame(
  region   = c(
    rep("National Capital Region (NCR)", 17),
    rep("Region I (Ilocos Region)", 4),
    rep("Region II (Cagayan Valley)", 4),
    rep("Region III (Central Luzon)", 7),
    rep("Region IV-A (CALABARZON)", 5),
    rep("MIMAROPA Region", 5),
    rep("Region V (Bicol Region)", 6),
    rep("Region VI (Western Visayas)", 5),
    rep("Region VII (Central Visayas)", 3),
    rep("Region VIII (Eastern Visayas)", 6),
    rep("Region IX (Zamboanga Peninsula)", 4),
    rep("Region X (Northern Mindanao)", 4),
    rep("Region XI (Davao Region)", 4),
    rep("Region XII (SOCCSKSARGEN)", 4),
    rep("Region XIII (Caraga)", 4),
    rep("Cordillera Administrative Region (CAR)", 6),
    rep("Negros Island Region (NIR)", 2),
    rep("Bangsamoro Autonomous Region In Muslim Mindanao (BARMM)", 4)
  ),
  province = c(
    # NCR
    "Metro Manila", "Metro Manila", "Metro Manila", "Metro Manila", "Metro Manila",
    "Metro Manila", "Metro Manila", "Metro Manila", "Metro Manila", "Metro Manila",
    "Metro Manila", "Metro Manila", "Metro Manila", "Metro Manila", "Metro Manila",
    "Metro Manila", "Metro Manila",
    # Region I
    "Ilocos Norte", "Ilocos Sur", "La Union", "Pangasinan",
    # Region II
    "Cagayan", "Isabela", "Nueva Vizcaya", "Quirino",
    # Region III
    "Bulacan", "Nueva Ecija", "Pampanga", "Tarlac", "Zambales", "Aurora", "Bataan",
    # Region IV-A
    "Cavite", "Laguna", "Batangas", "Rizal", "Quezon",
    # MIMAROPA
    "Occidental Mindoro", "Oriental Mindoro", "Marinduque", "Romblon", "Palawan",
    # Region V
    "Albay", "Camarines Sur", "Camarines Norte", "Sorsogon", "Masbate", "Catanduanes",
    # Region VI
    "Iloilo", "Capiz", "Aklan", "Antique", "Guimaras",
    # Region VII
    "Cebu", "Cebu", "Bohol",
    # Region VIII
    "Leyte", "Southern Leyte", "Samar", "Eastern Samar", "Northern Samar", "Biliran",
    # Region IX
    "Zamboanga del Norte", "Zamboanga del Sur", "Zamboanga Sibugay", "Sulu",
    # Region X
    "Misamis Oriental", "Misamis Occidental", "Bukidnon", "Lanao del Norte",
    # Region XI
    "Davao del Sur", "Davao del Norte", "Davao Oriental", "Davao de Oro",
    # Region XII
    "South Cotabato", "South Cotabato", "Sultan Kudarat", "Cotabato",
    # Region XIII
    "Agusan del Norte", "Agusan del Sur", "Surigao del Norte", "Surigao del Sur",
    # CAR
    "Benguet", "Mountain Province", "Ifugao", "Abra", "Apayao", "Kalinga",
    # NIR
    "Negros Occidental", "Negros Oriental",
    # BARMM
    "Maguindanao del Norte", "Lanao del Sur", "Basilan", "Tawi-Tawi"
  ),
  city = c(
    # NCR
    "Manila", "Quezon City", "Caloocan", "Las Pi\u00f1as", "Makati",
    "Malabon", "Mandaluyong", "Marikina", "Muntinlupa", "Navotas",
    "Para\u00f1aque", "Pasay", "Pasig", "San Juan", "Taguig",
    "Valenzuela", "Pateros",
    # Region I
    "Laoag City", "Vigan City", "San Fernando City", "Dagupan City",
    # Region II
    "Tuguegarao City", "Ilagan City", "Bayombong", "Cabarroguis",
    # Region III
    "Malolos City", "Cabanatuan City", "City of San Fernando", "Tarlac City",
    "Olongapo City", "Baler", "Balanga City",
    # Region IV-A
    "Dasmari\u00f1as City", "Santa Rosa City", "Batangas City", "Antipolo City", "Lucena City",
    # MIMAROPA
    "Mamburao", "Calapan City", "Boac", "Romblon", "Puerto Princesa City",
    # Region V
    "Legazpi City", "Naga City", "Daet", "Sorsogon City", "Masbate City", "Virac",
    # Region VI
    "Iloilo City", "Roxas City", "Kalibo", "San Jose", "Jordan",
    # Region VII
    "Cebu City", "Mandaue City", "Tagbilaran City",
    # Region VIII
    "Tacloban City", "Maasin City", "Catbalogan City", "Borongan City", "Catarman", "Naval",
    # Region IX
    "Dipolog City", "Pagadian City", "Ipil", "Jolo",
    # Region X
    "Cagayan de Oro City", "Oroquieta City", "Malaybalay City", "Iligan City",
    # Region XI
    "Davao City", "Tagum City", "Mati City", "Nabunturan",
    # Region XII
    "Koronadal City", "General Santos City", "Isulan", "Kidapawan City",
    # Region XIII
    "Butuan City", "Bayugan City", "Surigao City", "Tandag City",
    # CAR
    "Baguio City", "Bontoc", "Lagawe", "Bangued", "Kabugao", "Tabuk City",
    # NIR
    "Bacolod City", "Dumaguete City",
    # BARMM
    "Cotabato City", "Marawi City", "Isabela City", "Bongao"
  ),
  zip = c(
    # NCR
    "1000", "1100", "1400", "1740", "1200",
    "1470", "1550", "1800", "1770", "1485",
    "1700", "1300", "1600", "1500", "1630",
    "1440", "1620",
    # Region I
    "2900", "2700", "2500", "2400",
    # Region II
    "3500", "3300", "3700", "3400",
    # Region III
    "3000", "3100", "2000", "2300", "2200", "3200", "2100",
    # Region IV-A
    "4114", "4026", "4200", "1870", "4301",
    # MIMAROPA
    "5106", "5200", "4900", "5500", "5300",
    # Region V
    "4500", "4400", "4600", "4700", "5400", "4800",
    # Region VI
    "5000", "5800", "5600", "5700", "5045",
    # Region VII
    "6000", "6014", "6300",
    # Region VIII
    "6500", "6600", "6700", "6800", "6400", "6543",
    # Region IX
    "7100", "7016", "7001", "7400",
    # Region X
    "9000", "7207", "8700", "9200",
    # Region XI
    "8000", "8100", "8200", "8800",
    # Region XII
    "9506", "9500", "9805", "9400",
    # Region XIII
    "8600", "8502", "8400", "8300",
    # CAR
    "2600", "2616", "3600", "2800", "3808", "3800",
    # NIR
    "6100", "6200",
    # BARMM
    "9600", "9700", "7300", "7500"
  ),
  stringsAsFactors = FALSE
)

.ph_regions <- unique(.ph_geo$region)

.ph_barangays <- c(
  "Poblacion", "San Isidro", "San Jose", "San Antonio", "San Roque", "San Vicente",
  "San Pedro", "San Pablo", "San Rafael", "San Miguel", "Santo Nino", "Santa Cruz",
  "Santa Maria", "Santa Rosa", "Santo Domingo", "Bagong Silang", "Bagumbayan", "Malinta",
  "Concepcion", "Maligaya", "Mabuhay", "Tagumpay", "Pag-asa", "Libis",
  "Riverside", "Lourdes", "Fatima", "Guadalupe", "Kaligayahan", "Masagana",
  "Bayanihan", "Malaya", "Katipunan", "Dolores", "Buenavista", "Caniogan",
  "Ilaya", "Looc", "Pasong Tamo", "Tibig", "Tuktukan", "Ugong"
)

.ph_street_names <- c(
  "Rizal", "Bonifacio", "Mabini", "Del Pilar", "Quezon", "Luna", "Burgos",
  "Aguinaldo", "Katipunan", "Osmena", "Roxas", "Magsaysay", "Legarda", "Lacson",
  "Taft", "Espana", "Recto", "Ortigas", "Shaw Boulevard", "Commonwealth",
  "Marcos Highway", "Maharlika Highway"
)

.ph_street_types <- c("Street", "Avenue", "Road", "Extension", "Highway")
