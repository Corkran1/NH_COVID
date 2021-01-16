#Render to .tex
library(rmarkdown) 
rmarkdown::render("Documentation/ModelDescription.Rmd", output_format = latex_document())
