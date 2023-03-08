# Loading libraries and data;
source("spb.COVID-19.loader.r")

# Extracting countries data from JHU dataset;
source("spb.COVID-19.adjacent_countries.r")

# Transforming data;
source("spb.COVID-19.data_transformations.r")

# Printing control plots;
source("spb.COVID-19.plots.r")

# Rendering reports;
render("../texts/SPb.COVID-19.r_report.Rmd", output_format = c("md_document", "html_document"))
render("../texts/SPb.COVID-19.r_report.tweet.Rmd", output_format = c("md_document", "html_document"))
render("../texts/SPb.COVID-19.overview.Rmd", output_format = c("md_document", "html_document"))
render("../texts/SPb.COVID-19.data_critique.Rmd", output_format = c("md_document", "html_document"))
render("../texts/SPb.COVID-19.data.sources.Rmd", output_format = c("md_document", "html_document"))
