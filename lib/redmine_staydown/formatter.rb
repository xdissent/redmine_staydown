module RedmineStaydown
  class Formatter < Redmine::WikiFormatting::NullFormatter::Formatter

    MARKDOWN_OPTIONS = {
      fenced_code_blocks: true, 
      superscript: true, 
      space_after_headers: true, 
      autolink: true, 
      no_intra_emphasis: true, 
      tables: true
    }

    def renderer
      Redcarpet::Markdown.new Renderer, MARKDOWN_OPTIONS
    end

    # Add the `external` class to every link
    def external_links(html)
      html.gsub /<a\s/, %(<a class="external")
    end

    # Fix smarty pants in post.
    def smarty_pants(html)
      Redcarpet::Render::SmartyPants.render html.gsub("&#39;", "'")
    end

    def to_html(*args)
      smarty_pants(external_links(renderer.render(@text)))
    rescue => e
      "<pre>problem parsing wiki text: #{e.message}\noriginal text:\n#{@text}</pre>"
    end
  end
end