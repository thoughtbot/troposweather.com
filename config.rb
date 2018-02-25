set :css_dir, "assets/stylesheets"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :layout, "layouts/application"

activate :autoprefixer

configure :production do
  activate :asset_hash
  activate :gzip
  activate :minify_css
  activate :minify_html
end
