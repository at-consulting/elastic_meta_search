module ElasticMetaSearch
  module Utils
    module ClassMethods
      def model_settings(name)
        ElasticMetaSearch.models.select{ |model| model.keys.first == name }.first[name]
      end

      def serialize(object)
        Marshal.load Marshal.dump(object)
      end
      
      def meta_search_performed?(attrs)
        attrs.delete_if{ |_,v| v.blank? }.present?
      end
    end

    extend ClassMethods
  end
end