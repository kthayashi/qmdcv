# Load example YAML file
qcvexample <- yaml::read_yaml("data-raw/qcvexample.yaml")

# Save example data
usethis::use_data(qcvexample, overwrite = TRUE)
