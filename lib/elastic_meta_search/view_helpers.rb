#coding: utf-8
require "simple_form"
module ElasticMetaSearch
  module ViewHelpers
    
    def search_bar(opts = {})
      content_tag :div, class: "search input-append" do
        elastic_search_bar(opts[:elastic_search]) + meta_search_link(opts[:meta_search])
      end
    end

    def elastic_search_bar(opts = {})
      text_field_tag(:elastic_search, nil, class: "span4", data: { source: es_path(index: opts.delete(:index)) }) +
      button_tag(:elastic_search, class: "btn")
    end

    def meta_search_link(opts={})
      link_to(meta_search_link_name(opts[:performed]),
              '#',
              class: "btn meta-search-link #{opts[:class]}",
              title: 'Расширенный поиск',
              "data-content" => "#{ render(opts[:partial], opts[:render_opts]).html_safe }")
    end

    def meta_search_link_name(performed = false)
      ('<span class="caret"/>' + (performed ? '<i class="icon-filter"></i>' : '')).html_safe
    end
  end
end