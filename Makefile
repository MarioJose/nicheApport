README.md : README.Rmd
	Rscript -e 'rmarkdown::render("README.Rmd")'
	pandoc README.md -o README.html

