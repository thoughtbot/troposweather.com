# Middleman - Inline SVG Helper
# https://gist.github.com/bitmanic/0047ef8d7eaec0bf31bb

module ImageHelpers

  def inline_svg(filename, options = {})
    asset = sprockets.find_asset(filename)

    if asset.nil?
      %(
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 30"
          width="400px" height="30px"
        >
          <text font-size="16" x="8" y="20" fill="#cc0000">
            Error: '#{filename}' could not be found.
          </text>
          <rect
            x="1" y="1" width="398" height="28" fill="none"
            stroke-width="1" stroke="#cc0000"
          />
        </svg>
      )

    else
      file = asset.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"

      if options[:class].present?
        svg["class"] = options[:class]
      end

      doc
    end
  end
end
