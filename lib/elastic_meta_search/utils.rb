module ElasticMetaSearch
  module Utils
    module ClassMethods

      def create_indexes
        ElasticMetaSearch.indexes.each do |model, indexes|
          model.send :include, Tire::Model::Search
          model.send :include, Tire::Model::Callbacks

          model.tire do
            settings ElasticMetaSearch.index_settings do
              mapping do
                indexes.each do |method_name|
                  indexes method_name, ElasticMetaSearch.default_field_mapping
                end
                filters = ElasticMetaSearch.filters[model]
                filters ||= {}
                filters.each do |filter_method|
                  indexes filter_method, :index => "not_analyzed"
                end
              end
            end
          end
        end
      end
    end

    extend ClassMethods
  end
end
