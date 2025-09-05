cvdata <- yaml::read_yaml("data-raw/cvdata.yaml")
usethis::use_data(cvdata, overwrite = TRUE)
