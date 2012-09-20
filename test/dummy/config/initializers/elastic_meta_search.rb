ElasticMetaSearch.setup do |config|
  config.models = [{ "Post" =>
                               [{ meta_search:
                                               [{ attr: "author_equals", opts: {wrapper_html: {class: "span6"}, input_html: {class: "span2"}}},
                                                { attr:    "id_in", opts: { as: :select,
                                                                    collection: Post.sorted } },
                                                {attr: "author_in"},
                                                {attr: "name_contains"},
                                                {attr: "name_equals"},
                                                {attr: "id_equals"},
                                                {attr: "author_contains"}]
                               }]
                  }]
end
