# Load example YAML file
example_data <- yaml::read_yaml("data-raw/example_data.yaml")

# Save example data
usethis::use_data(example_data, overwrite = TRUE)
