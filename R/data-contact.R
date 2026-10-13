# Curated Philippine telecom/email data used by fkr_email(),
# fkr_mobile_number(), and fkr_landline_number(). Internal only -- not
# exported.

.ph_mobile_prefixes <- list(
  smart = c("0918", "0919", "0920", "0921", "0928", "0929", "0930", "0938",
            "0939", "0946", "0947", "0948", "0949", "0950", "0989", "0998", "0999"),
  globe = c("0905", "0906", "0915", "0916", "0917", "0926", "0927", "0935",
            "0936", "0937", "0945", "0953", "0954", "0955", "0956", "0965",
            "0966", "0967", "0975", "0976", "0977", "0978", "0979", "0994",
            "0995", "0996", "0997"),
  dito  = c("0895", "0896", "0897", "0898", "0991")
)

.ph_landline_area_codes <- c(
  "Metro Manila" = "02",
  "Cebu"         = "032",
  "Iloilo"       = "033",
  "Bacolod"      = "034",
  "Batangas"     = "043",
  "Pampanga"     = "045",
  "Cavite"       = "046",
  "Laguna"       = "049",
  "Legazpi"      = "052",
  "Naga"         = "054",
  "Zamboanga"    = "062",
  "Davao"        = "082",
  "General Santos" = "083",
  "Cagayan de Oro" = "088"
)

.ph_email_domains <- c("gmail.com", "yahoo.com", "outlook.com", "ymail.com", "icloud.com")
.ph_email_domain_weights <- c(0.55, 0.20, 0.12, 0.08, 0.05)
