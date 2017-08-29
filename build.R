if(!require(blogdown)) {
	devtools::install_github('rstudio/blogdown')
	library(blogdown)
}

# Setup (run only once per class)
blogdown::install_hugo()
blogdown::new_site()
blogdown::install_theme(theme = 'vjeantet/hugo-theme-docdock')

# Serve site
blogdown::serve_site()

# Build site for Github pages
blogdown::build_site(method = 'html_encoded'); #file.copy('public', 'docs', recursive = TRUE, overwrite = TRUE);

unlink("docs", recursive=TRUE); file.rename('public', 'docs')
