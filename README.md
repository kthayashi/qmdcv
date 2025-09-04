
<!-- README.md is generated from README.Rmd. Please edit that file -->

# qmdcv

<!-- badges: start -->

[![R-CMD-check](https://github.com/kthayashi/qmdcv/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/kthayashi/qmdcv/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Overview

`qmdcv` is an R package that facilitates creation of a curriculum vitae
(CV) with [Quarto](https://quarto.org). The core functionality of the
package is to convert data that comprise a CV, supplied in
[YAML](https://yaml.org) format, into Quarto’s flavor of
[Markdown](https://quarto.org/docs/authoring/markdown-basics.html) text.
This text can be inserted into a Quarto (.qmd) document and rendered to
HTML.

This package is intended for personal use and was inspired by the
[`datadrivencv`](https://nickstrayer.me/datadrivencv) and
[`vitae`](https://pkg.mitchelloharawild.com/vitae) packages.

## Installation

Install `qmdcv` from GitHub:

``` r
install.packages(pak)
pak::pkg_install("kthayashi/qmdcv")
```

Users will also need to [install
Quarto](https://quarto.org/docs/get-started) to make use of the
functionality of this package. Recent versions of RStudio come bundled
with Quarto.

## Usage

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
#> :::{.columns}
#> :::{.column style='width:80%; text-align:left;'}
#> **Ph.D. in XXXXX**  
#> University of XXXXX  
#> Advisor: Dr. XXXXX  
#> :::
#> :::{.column style='width:20%; text-align:right;'}
#> YYYY - YYYY
#> :::
#> :::
#> 
#> :::{.columns}
#> :::{.column style='width:80%; text-align:left;'}
#> **B.S. in XXXXX**  
#> XXXX College  
#> :::
#> :::{.column style='width:20%; text-align:right;'}
#> YYYY - YYYY
#> :::
#> :::
```

Set `output: asis` in code chunks to ensure that the inserted Markdown
text is rendered properly.

See [here](https://github.com/kthayashi/cv) for my personal CV built
using `qmdcv`.

## Disclaimers

This package is neither associated with nor endorsed by the Quarto open
source project.
