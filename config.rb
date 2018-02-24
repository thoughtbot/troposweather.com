set :css_dir, "assets/stylesheets"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :layout, "layouts/application"

activate :directory_indexes

activate :autoprefixer do |config|
  config.browsers = ["last 2 versions"]
  config.cascade = false
end

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_html
end
