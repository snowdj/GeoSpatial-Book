library(methods)
set.seed(2018)
# 加载依赖
library(ggplot2)
library(StanHeaders)
library(rstan)
# 设置环境
Sys.setenv(USE_CXX14 = 1)
is_on_travis = identical(Sys.getenv("TRAVIS"), "true")
is_online = curl::has_internet()
is_on_centos = !is_on_travis & .Platform$OS.type == "unix" & Sys.info()['nodename'] != 'ubuntu'

options(mc.cores = if(is_on_travis) 4 else 2)
rstan_options(auto_write = TRUE)

# library(tibble)
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  echo = TRUE,
  cache = TRUE,
  out.width = "70%",
  fig.align = "center",
  fig.width = 6,
  width = 69,
  fig.asp = 0.618
)

doc_type <- function() knitr::opts_knit$get('rmarkdown.pandoc.to')

knitr::knit_hooks$set(
  optipng = knitr::hook_optipng,
  pdfcrop = knitr::hook_pdfcrop,
  small.mar = function(before, options, envir) {
    if (before) par(mar = c(4.1, 4.1, 0.5, 0.5))  # smaller margin on top and right
  }
)
# https://github.com/yihui/knitr-examples/blob/master/085-pdfcrop.Rnw

options(
  digits = 3,
  citation.bibtex.max = 999,
  bitmapType = "cairo",
  stringsAsFactors = FALSE,
  BioC_mirror = "https://mirrors.tuna.tsinghua.edu.cn/bioconductor",
  repos = c(
    CRAN = if(is_on_travis) "https://cloud.r-project.org" else "https://mirrors.tuna.tsinghua.edu.cn/CRAN/",
    RForge = "https://r-forge.r-project.org",
    inla = "https://inla.r-inla-download.org/R/stable"
  ),
  knitr.graphics.auto_pdf = FALSE,
  width = 69,
  str = strOptions(strict.width = "cut"),
  tikzDefaultEngine = "xetex",
  tikzXelatexPackages = c(
    getOption("tikzXelatexPackages"),
    "\\usepackage[colorlinks, breaklinks]{hyperref}",
    "\\usepackage{color,tikz}",
    "\\usepackage[active,tightpage,xetex]{preview}",
    "\\PreviewEnvironment{pgfpicture}",
    "\\usepackage{amsmath,amsfonts,mathrsfs}"
  )
)