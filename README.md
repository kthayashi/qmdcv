
<!-- README.md is generated from README.Rmd. Please edit that file -->

# qmdcv

<!-- badges: start -->
<!-- badges: end -->

This package facilitates creating a curriculum vitae (CV) with
[Quarto](https://quarto.org/). The core functionality of the package is
to convert structured data for a CV, supplied as a YAML file(s) and/or
lists in R, into Markdown text. This text can be inserted into a .qmd
file and rendered as an HTML document with Quarto.

This package was inspired by the
[`vitae`](https://github.com/mitchelloharawild/vitae/) and
[`datadrivencv`](https://github.com/nstrayer/datadrivencv) packages.

## Disclaimers

- This package is neither associated with nor endorsed by the Quarto
  open source project.
- I’m building out this package as I go, primarily for my own use.
  Anyone is welcome to use this package and open issues/pull requests,
  but I may not be able to implement certain changes until they become
  necessary in my own workflow.

## Installation

You can install the development (and only) version of `qmdcv` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kthayashi/qmdcv")
```

## Example

Here’s a demonstration of the package using the bundled `example_data`:

``` r
library(qmdcv)
data(example_data)
```

The family of `insert()` functions takes a list of one or more lists
containing CV data and produces Markdown text in a select few formats.
For example, education data can be provided as:

``` r
edu <- example_data$education
str(edu)
#> List of 2
#>  $ :List of 4
#>   ..$ title  : chr "Ph.D. in XXXXX"
#>   ..$ start  : chr "YYYY"
#>   ..$ end    : chr "YYYY"
#>   ..$ details: chr [1:2] "University of XXXXX" "Advisor: Dr. XXXXX"
#>  $ :List of 4
#>   ..$ title  : chr "B.S. in XXXXX"
#>   ..$ start  : chr "YYYY"
#>   ..$ end    : chr "YYYY"
#>   ..$ details: chr "XXXX College"
```

Expected usage is to enter CV data in a YAML file, which can be read
into R using the [`yaml`](https://github.com/vubiostat/r-yaml/) package.
Here’s what the education data above would look like in YAML format:

``` r
cat(yaml::as.yaml(edu))
#> - title: Ph.D. in XXXXX
#>   start: YYYY
#>   end: YYYY
#>   details:
#>   - University of XXXXX
#>   - 'Advisor: Dr. XXXXX'
#> - title: B.S. in XXXXX
#>   start: YYYY
#>   end: YYYY
#>   details: XXXX College
```

Use `insert()` to produce Markdown text from the data in `edu`:

``` r
insert(edu)
#> ::::::{.columns}
#> :::{.column style='width:80%; text-align:left;'}
#> **Ph.D. in XXXXX**  
#> University of XXXXX  
#> Advisor: Dr. XXXXX  
#> :::
#> :::{.column style='width:20%; text-align:right;'}
#> YYYY - YYYY
#> :::
#> ::::::
#> 
#> ::::::{.columns}
#> :::{.column style='width:80%; text-align:left;'}
#> **B.S. in XXXXX**  
#> XXXX College  
#> :::
#> :::{.column style='width:20%; text-align:right;'}
#> YYYY - YYYY
#> :::
#> ::::::
```

Note: Use the Quarto option `output: asis` to get the produced Markdown
text to be rendered properly.
