module RedmineStaydown
  module Entities
    def normal_text(text)
      text = coder.encode coder.decode(text), :named
      text.gsub! /&([rl]d)?quot?;/, '"'
      text.gsub /&[rl]squo;/, '\''
    end

    private

    def coder
      @coder ||= HTMLEntities.new :html4
    end
  end

  module Widont
    def header(text, header_level)
      text.strip!
      text[text.rindex(" "), 1] = "&nbsp;" if text.rindex(" ")
      %(<h#{header_level}>#{text}</h#{header_level}>)
    end
  end

  module BlockQuotes
    def block_quote(quote)
      text = quote.gsub /\n([^<])/,'<br>\1'
      %(<blockquote>#{text}</blockquote>)
    end
  end

  module Highlighting
    def hilite(code, language)
      Redmine::SyntaxHighlighting.highlight_by_language code, language
    end

    def block_code(code, language)
      return %(<pre>#{CGI.escapeHTML code}</pre>) unless language.present?
      hilited = hilite code, language
      %(<pre><code class="#{language} syntaxhl">#{hilited}</code></pre>)
    end
  end

  class Renderer < Redcarpet::Render::HTML
    include Widont
    include Entities
    include BlockQuotes
    include Highlighting
  end
end