module ElasticMetaSearch
  module Utils
    module ClassMethods

      def create_indexes
        ElasticMetaSearch.indexes.each do |model, indexes|
          model.send :include, Tire::Model::Search
          model.send :include, Tire::Model::Callbacks

          model.tire do
            mapping do
              indexes.each_pair do |method_name, params|
                indexes method_name, params
              end
            end
          end
        end
      end

    end

    extend ClassMethods
  end
end
