
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

## Installation

You can install `qmdcv` from GitHub:

``` r
install.packages(pak)
pak::pkg_install("kthayashi/qmdcv")
```

You will also need to [install
Quarto](https://quarto.org/docs/get-started) to make use of the
functionality of this package. Recent versions of RStudio come bundled
with Quarto.

## Usage

``` r
library(qmdcv)
```

`qmdcv` provides a YAML file containing example CV data:

``` r
write_example()
#> education:
#>   - title: Ph.D. in Biology
#>     start: 2018
#>     end: 2025
#>     details: University of California, Los Angeles
#>     notes: >-
#>       Causes and consequences of competition in spatially variable environments
#>       for plant coexistence and distributions: a study with California annual
#>       plants
#>   - title: B.S. in Biology
#>     start: 2014
#>     end: 2018
#>     details: Brown University
#> publications:
#>   - citation: >-
#>       **Hayashi, K. T.**, & Kraft, N. J. B. (2025). Competition contributes to
#>       quantitative mismatches between plant fitness and occurrence along
#>       environmental gradients. *Journal of Ecology*, 113(9), 2590–2602.
#>       <https://doi.org/10.1111/1365-2745.70115>
#>   - citation: >-
#>       McGuire, R. M.\*, **Hayashi, K. T.**\*, Yan, X.\*, Caritá Vaz, M.,
#>       Cinoğlu, D., Cowen, M. C., Martínez-Blancas, A., Sullivan, L. L.,
#>       Vazquez-Morales, S., & Kandlikar, G. S. (2022). EcoEvoApps: Interactive
#>       apps for theoretical models in ecology and evolutionary biology. *Ecology
#>       and Evolution*, 12(12), e9556. <https://doi.org/10.1002/ece3.9556>
#>   - citation: >-
#>       Miller, E. C., **Hayashi, K. T.**, Song, D., & Wiens, J. J. (2018).
#>       Explaining the ocean’s richest biodiversity hotspot and global patterns of
#>       fish diversity. *Proceedings of the Royal Society B: Biological Sciences*,
#>       285(1888), 20181314. <https://doi.org/10.1098/rspb.2018.1314>
#>     notes: 'Featured in&nbsp;[The New York Times](https://www.nytimes.com/2018/10/17/science/coral-reef-biodiversity.html)'
#> teaching:
#>   - title: Plant Ecology
#>     years: '2019, 2021--2024'
#>   - title: Plant Physiology
#>     years: [2020, 2022]
#>   - title: Plant Diversity and Evolution
#>     start: 2020
```

We can read this YAML file into R as a list:

``` r
cvdata <- read_example()
```

Or equivalently:

``` r
cvdata <- yaml::read_yaml(file = system.file("example.yaml", package = "qmdcv"))
```

where `file` can be replaced with the path to your own CV data.

The family of `insert()` functions converts a list of CV data into
Markdown text in a number of pre-defined formats. For example, we can
insert education history into a CV with:

``` r
insert(cvdata$education)
#> :::{.columns}
#> :::{.column style='width:80%; text-align:left;'}
#> **Ph.D. in Biology**  
#> University of California, Los Angeles  
#> [Causes and consequences of competition in spatially variable environments for plant coexistence and distributions: a study with California annual plants]{style='display:flex; color:gray; font-size:0.8em; margin: 0px auto;'}
#> :::
#> :::{.column style='width:20%; text-align:right;'}
#> 2018--2025
#> :::
#> :::
#> 
#> :::{.columns}
#> :::{.column style='width:80%; text-align:left;'}
#> **B.S. in Biology**  
#> Brown University  
#> :::
#> :::{.column style='width:20%; text-align:right;'}
#> 2014--2018
#> :::
#> :::
```

⚠️ Set `output: asis` (or `results: asis` for `knitr`) in code chunks to
ensure that this Markdown text is treated as such upon render.

You can get started by using `write_example()` to copy the example YAML
file to your machine as a template. See
[here](https://github.com/kthayashi/cv) for my personal CV built using
`qmdcv`.

## Disclaimers

This package is intended for personal use and was inspired by the
[`datadrivencv`](https://nickstrayer.me/datadrivencv) and
[`vitae`](https://pkg.mitchelloharawild.com/vitae) packages.

This package is neither associated with nor endorsed by the Quarto open
source project.
