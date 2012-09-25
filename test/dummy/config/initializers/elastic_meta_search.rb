ElasticMetaSearch.setup do |config|
  config.indexes = {
    Post => {
              id:   { type: 'integer' },
              name: { type: 'string', type: 'snowball' }
    }
  }
end
