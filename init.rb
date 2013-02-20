require "redmine_staydown"

Redmine::Plugin.register :redmine_staydown do
  name "Redmine Staydown"
  author "Greg Thornton"
  description "A killer Markdown formatter for Redmine - hopefully."
  version "0.0.1"
  author_url "http://xdissent.com"
  requires_redmine version_or_higher: "2.2.3"

  wiki_format_provider "markdown", RedmineStaydown::Formatter, RedmineStaydown::Helper
end
