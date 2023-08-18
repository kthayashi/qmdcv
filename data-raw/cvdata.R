# Load example YAML file
cvdata <- yaml::read_yaml("data-raw/cvdata.yaml")

# Save example data
usethis::use_data(cvdata, overwrite = TRUE)
