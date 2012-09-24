ElasticMetaSearch.setup do |config|
  config.indexes = {
    Post => { id: { type: 'integer' },
               }
  }
end
