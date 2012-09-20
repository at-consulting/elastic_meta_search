#coding: utf-8
require "simple_form"
require "elastic_meta_search/utils"
module ElasticMetaSearch
  module ViewHelpers
    
    def search_bar(search)
      content_tag :div, class: "search input-append", style: "text-align:center;" do
        elastic_search_bar + meta_search_link(search)
      end
    end

    def elastic_search_bar
      text_field_tag(:elastic_search, nil, class: "span2") +
      button_tag(:elastic_search, class: "btn")
    end

    def meta_search_link(search)
      link_to(meta_search_link_name(search.search_attributes),
              '#',
              class: 'btn meta-search-link',
              title: 'Расширенный поиск',
              "data-content" => "#{ meta_search_bar(search).html_safe }")
    end

    def meta_search_bar(search)
      if search
        model_name = search.base.model_name
        search_settings = ElasticMetaSearch::Utils.model_settings model_name
        grouped_metasearch_settings = search_settings.first[:meta_search].in_groups_of 4, false
        content_tag :div, class: "well" do
          simple_form_for search, as: :q,
                                  url: url_for(controller: controller.controller_name, action: controller.action_name),
                                  html: { method: :get, class: 'filter-form' } do |f|
            grouped_metasearch_settings.each do |group|
              concat(content_tag(:div, class: "row") do
                group.each do |filter|
                  filter_opts = ElasticMetaSearch::Utils.serialize(filter).delete(:opts) || {}
                  concat(f.input filter[:attr], filter_opts.reverse_merge({ input_html:{ class: "span2" }, wrapper_html:{ class: "span2" } }))
                end
              end)
            end
            concat(content_tag(:div, class: "form-actions") do
              f.button(:submit, "Найти", class: 'btn btn-primary') +
              link_to( "Очистить", url_for(controller: controller.controller_name, action: controller.action_name), class: 'btn')
            end)
          end
        end
      else
        raise NotImplementedError
      end
    end

    def meta_search_link_name(attrs)
      ('<span class="caret"/>' + (ElasticMetaSearch::Utils.meta_search_performed?(attrs)? '<i class="icon-filter"></i>' : '')).html_safe
    end
  end
end