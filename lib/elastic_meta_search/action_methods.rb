module ElasticMetaSearch
  module ActionMethods

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def enable_fast_search
        define_method "fs" do
          data = []
          tire_search_results(params[:term], { :autocomplete => true } ).each do |result|
            result.highlight.to_hash.each do |k,v|
              data << { column: I18n.t(k, scope: "elastic_meta_search.#{params[:index]}"), value: result.send(k), label: result.send(k) }
            end
          end

          render json: data.uniq.to_json
        end

        define_method "tire_search_results" do |*args|
          term    = args[0]
          opts    = args[1] || {}
          index   = params[:index]   || opts[:index]   || resource_class.model_name.underscore.pluralize
          fields  = params[:display] || opts[:display] || ElasticMetaSearch.indexes[index.classify.constantize]
          term.gsub!(/([\+\!\(\)\{\}\[\]\^\"\~\*\?\:\\-])/, '\\\\\1')
          Tire.search(index, opts) do
            query { string term, fields: fields, default_operator: "AND" }
            size index.camelize.classify.constantize.count
            highlight(*fields, options: { tag: '' }) if opts[:autocomplete]
          end.results
        end

        private :tire_search_results

      end
    end
  end
end
