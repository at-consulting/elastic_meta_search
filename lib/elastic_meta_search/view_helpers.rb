#coding: utf-8
module ElasticMetaSearch
  module ViewHelpers

    def search_bar(opts = {})
      content_tag :div, class: "search input-append" do
        elastic_search_bar(opts[:elastic_search] || {}) + meta_search_link(opts[:meta_search])
      end
    end

    def elastic_search_bar(opts)
      url_index   = opts.delete(  :index) || resource_class.model_name.underscore.pluralize
      url_display = opts.delete(:display) || url_index.classify.constantize.mapping.keys
      source      = fs_path(index: url_index, display: url_display)
      text_val    = params[:fs][:term] if params[:fs]

      form_tag url_for(controller: controller_name, action: action_name), method: :get, style: "display:inline;" do |f|
        tags =
          text_field_tag("fs[term]", text_val, class: "span4", data: { source: source }) +
          button_tag("Найти", disable_with: "Поиск...", class: "btn")

        opts.delete(:params).each_pair do |key, val|
          tags += hidden_field_tag(key, val)
        end

        tags
      end
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
