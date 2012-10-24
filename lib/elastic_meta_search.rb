require "tire"
require "elastic_meta_search/utils"
require "elastic_meta_search/action_methods"
require "elastic_meta_search/view_helpers"

module ElasticMetaSearch
  mattr_accessor :indexes
  mattr_accessor :filters
  mattr_accessor :index_settings
  mattr_accessor :default_field_mapping
  def self.setup
    yield self
  end

  self.index_settings = {
    analysis: {
      analyzer: {
        ngram_analyzer: {
          type: "custom",
          tokenizer: "keyword",
          filter: ["lowercase","ngram_filter"]
        },
        keyword_analyzer: {
          type: "custom",
          tokenizer: "keyword",
          filter: ["lowercase"]
        }
      },
      filter: {
        ngram_filter: {
          type: "nGram",
          min_gram: 1,
          max_gram: 100
        }
      }
    }
  }

  self.default_field_mapping = {
    type: "string",
    index_analyzer: "ngram_analyzer",
    search_analyzer: "keyword_analyzer"
  }

  class Engine < ::Rails::Engine
    # configure our plugin on boot
    initializer "elastic_meta_search.initialize" do |app|
      ActionView::Base.send :include, ElasticMetaSearch::ViewHelpers
      ActionController::Base.send :include, ElasticMetaSearch::ActionMethods
      ElasticMetaSearch::Utils.create_indexes
    end

  end
end

=begin
require 'active_record'
require 'active_support'
require 'action_view'
require 'action_controller'
require 'meta_search/searches/active_record'
require 'meta_search/helpers'

I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'meta_search', 'locale', '*.yml')]

ActiveRecord::Base.send(:include, MetaSearch::Searches::ActiveRecord)
ActionView::Helpers::FormBuilder.send(:include, MetaSearch::Helpers::FormBuilder)
ActionController::Base.helper(MetaSearch::Helpers::UrlHelper)
ActionController::Base.helper(MetaSearch::Helpers::FormHelper)
=end
