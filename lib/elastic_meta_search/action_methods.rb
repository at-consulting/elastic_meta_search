module ElasticMetaSearch
  module ActionMethods

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def enable_fast_search
        define_method "fs" do
          term         = "*#{params[:term]}*"
          index_fields = params[:display]
          results = Tire.search(params[:index]) do
            query { string term }
            highlight *index_fields, options: { tag: '' }
          end.results
          highlights = results.map(&:highlight).flatten.map(&:to_hash)
          data = []
          highlights.each do |hash|
            hash.each do |k,v|
              data << { column: I18n.t(k, scope: "elastic_meta_search.#{params[:index]}"), value: v.first, label: v.first }
            end
          end

          render json: data.uniq.to_json
        end
      end
    end
  end
end
