#coding: utf-8
module ElasticMetaSearch
  module ViewHelpers

    def search_bar(opts = {})
      content_tag :div, class: "search input-append" do
        elastic_search_bar(opts[:elastic_search] || {}) + (meta_search_link(opts[:meta_search]) unless opts[:meta_search].blank?)
      end
    end

    def elastic_search_bar(opts)
      url_index   = opts.delete(  :index) || resource_class.model_name.underscore.pluralize
      url_display = opts.delete(:display) || ElasticMetaSearch.indexes[url_index.classify.constantize]
      source      = fs_path(index: url_index, display: url_display)
      text_val    = params[:fs][:term].gsub(/(\\)(.)/, '\2') if params[:fs]

      form_tag url_for(controller: controller_name, action: action_name), method: :get, style: "display:inline;" do |f|
        tags =
          text_field_tag("fs[term]", text_val, class: "span4 fast-search-input", data: { source: source }) +
          button_tag("Найти", disable_with: "Поиск...", class: "btn")

        params = opts.delete(:params)
        unless params.blank?
          params.each_pair do |key, val|
            Array.wrap(val).each do |value|
              tags += hidden_field_tag(key, value)
            end
          end
        end

        tags
      end
    end

    def meta_search_link(opts={})
      link_to(meta_search_link_name(opts[:performed]),
              '#',
              class: "btn btn-link meta-search-link #{opts[:class]}",
              title: 'Расширенный поиск',
              "data-content" => "#{ render(opts[:partial], opts[:render_opts]).html_safe }")
    end

    def meta_search_link_name(performed = false)
      (performed ? 'Изменить параметры поиска' : 'Расширенный поиск').html_safe
    end
  end
end
