activate :inline_svg

config[:css_dir] = "assets/stylesheets"
config[:fonts_dir] = "assets/fonts"
config[:images_dir] = "assets/images"
config[:js_dir] = "assets/javascripts"

configure :production do
  activate :asset_hash
  activate :gzip
  activate :minify_css
  activate :minify_html
end
