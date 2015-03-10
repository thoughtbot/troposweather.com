set :build_dir, "tmp"
set :css_dir, "assets/stylesheets"
set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :js_dir, "assets/javascripts"
set :layout, "layouts/application"

activate :directory_indexes

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
end
