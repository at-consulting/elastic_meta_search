ElasticMetaSearch.setup do |config|
  config.indexes = {
    Post => %w(name author)
  }
end
