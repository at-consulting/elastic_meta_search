module ElasticMetaSearch
  module ActionMethods
    
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      def enable_fast_search
        define_method "es" do
          term = "*#{params[:term]}*"
          results = Tire.search(params[:index]) do
            query { string term }
            highlight :name, :author, options: { tag: '' }
          end.results
          highlights = results.map(&:highlight).flatten.map(&:to_hash)
          res = []
          highlights.each do |hash|
            hash.each do |k,v|
              res << { column: k, value: v.first, label: v.first }
            end
          end
          
          render json: res.to_json
        end
      end
    end
  end
end
