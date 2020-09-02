
setwd("/icgc/dkfzlsdf/analysis/B080/guz/cola_test/cola_supplementary")

library(GetoptLong)
library(bsub)
rmd_files = scan(pipe("ls $PWD/*/*.Rmd"), what = "character")
for(f in rmd_files) {
	cmd = qq("module load R/3.6.0; module load pandoc/2.2.1; Rscript -e 'rmarkdown::render(\"@{f}\")'")
	bsub_cmd(cmd, name = qq("cola_@{gsub('.Rmd$', '', basename(f))}"), hour = 5, memory = 5)
}

knitr::knit("README.Rmd", "README.md")
