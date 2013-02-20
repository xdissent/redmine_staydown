module RedmineStaydown
  module Helper
    def initial_page_content(page)
      %(# #{page.pretty_title})
    end

    def wikitoolbar_for(field_id)
      heads_for_wiki_formatter
      url = "#{Redmine::Utils.relative_url_root}/plugin_assets/redmine_staydown/help/wiki_syntax.html"
      javascript_tag("var wikiToolbar = new jsToolBar(document.getElementById('#{field_id}')); wikiToolbar.setHelpLink('#{escape_javascript url}'); wikiToolbar.draw();")
    end

    def heads_for_wiki_formatter
      unless @heads_for_wiki_formatter_included
        content_for :header_tags do
          javascript_include_tag("jstoolbar/jstoolbar") +
          javascript_include_tag("jstoolbar", plugin: :redmine_staydown) +
          javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
          stylesheet_link_tag("jstoolbar") +
          stylesheet_link_tag("wiki", plugin: :redmine_staydown)
        end
        @heads_for_wiki_formatter_included = true
      end
    end
  end
end