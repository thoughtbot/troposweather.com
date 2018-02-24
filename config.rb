set :css_dir, "assets/stylesheets"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :layout, "layouts/application"

activate :autoprefixer
activate :directory_indexes

configure :build do
  activate :asset_hash
  activate :gzip
  activate :minify_css
  activate :minify_html
end
