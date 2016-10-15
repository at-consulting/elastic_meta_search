#coding: utf-8
module ElasticMetaSearch
  module ViewHelpers

    def search_bar(opts = {})
      content_tag :div, class: "search input-append" do
        elastic_search_bar(opts[:elastic_search] || {}) + (meta_search_link(opts[:meta_search]) unless opts[:meta_search].blank?)
      end
    end

    def elastic_search_bar(opts)
      url_index   = opts.delete(  :index) || resource_class.model_name.plural
      url_display = opts.delete(:display) || ElasticMetaSearch.indexes[url_index.classify.constantize]
      url_filters = opts.delete(:filters)
      placeholder = opts.delete(:placeholder)
      source      = fs_path(index: url_index, display: url_display, filters: url_filters)
      text_val    = params[:fs][:term].gsub(/(\\)(.)/, '\2') if params[:fs]

      form_tag url_for(controller: controller_name, action: action_name), method: :get, style: "display:inline;" do |f|
        tags =
          text_field_tag("fs[term]", text_val, class: "span4 fast-search-input", maxlength: "255", placeholder: placeholder, data: { source: source }) +
          button_tag(I18n.t('elastic_meta_search.search'), disable_with: t('elastic_meta_search.searching'), class: "btn jstorage-cleanup")

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
              title: I18n.t('elastic_meta_search.advanced'),
              "data-content" => "#{ render(opts[:partial], opts[:render_opts]).html_safe }")
    end

    def meta_search_link_name(performed = false)
      (performed ? I18n.t('elastic_meta_search.change') : I18n.t('elastic_meta_search.advanced')).html_safe
    end
  end
end
