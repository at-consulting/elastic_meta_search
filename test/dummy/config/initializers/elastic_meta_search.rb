ElasticMetaSearch.setup do |config|
  config.indexes = {
    Post => {
              name:   { type: 'string' },
              author: { type: 'string', type: 'snowball' }
    }
  }
end
