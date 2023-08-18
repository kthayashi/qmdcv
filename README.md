
<!-- README.md is generated from README.Rmd. Please edit that file -->

# qmdcv

<!-- badges: start -->

[![R-CMD-check](https://github.com/kthayashi/qmdcv/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/kthayashi/qmdcv/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Overview

This package facilitates creating a curriculum vitae (CV) with
[Quarto](https://quarto.org/). The core functionality of the package is
to convert structured data for a CV, supplied as a YAML file and/or
lists in R, into Markdown text. This text can be inserted into a .qmd
file and rendered as an HTML document with Quarto.

This package was inspired by the
[`vitae`](https://github.com/mitchelloharawild/vitae/) and
[`datadrivencv`](https://github.com/nstrayer/datadrivencv) packages. Go
check them out if you are looking for a more robust, general-purpose
package.

## Disclaimers

- I’m building this package primarily for my own use. Anyone is welcome
  to use, fork, or open issues/pull requests for this package, but I may
  not be able to implement certain changes until they become necessary
  in my own usage.
- This package is neither associated with nor endorsed by the Quarto
  open source project.

## Installation

Install `qmdcv` from [GitHub](https://github.com/kthayashi/qmdcv) with:

``` r
# install.packages("devtools")
devtools::install_github("kthayashi/qmdcv")
```

To make use of the functionality of this package, you will need to
install [Quarto](https://quarto.org/docs/get-started/) separately. If
you are using a recent version of RStudio, Quarto may already be
available to you. In addition, one function in this package
(`insert_pubs_web()`) uses the [Font Awesome
Extension](https://github.com/quarto-ext/fontawesome) for Quarto - if
you would like to use this function, you will need to install this
extension to the root directory of your project.

## Example

Here’s a demonstration of `qmdcv` using the bundled `cvdata`:

``` r
library(qmdcv)
data(cvdata)
```

The family of `insert()` functions takes a list of one or more lists
containing CV data and produces Markdown text in a select few formats.
For example, education data can be provided as:

``` r
(edu <- cvdata$education)
#> [[1]]
#> [[1]]$title
#> [1] "Ph.D. in XXXXX"
#> 
#> [[1]]$start
#> [1] "YYYY"
#> 
#> [[1]]$end
#> [1] "YYYY"
#> 
#> [[1]]$details
#> [1] "University of XXXXX" "Advisor: Dr. XXXXX" 
#> 
#> 
#> [[2]]
#> [[2]]$title
#> [1] "B.S. in XXXXX"
#> 
#> [[2]]$start
#> [1] "YYYY"
#> 
#> [[2]]$end
#> [1] "YYYY"
#> 
#> [[2]]$details
#> [1] "XXXX College"
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

See [here](https://github.com/kthayashi/cv) for my personal CV built
using `qmdcv`.
