require "simple_form"
require "meta_search"
require "elastic_meta_search/view_helpers"
require "elastic_meta_search/utils"

module ElasticMetaSearch
  mattr_accessor :models
  
  def self.setup
    yield self
  end
  
  def self.user_class
    @@user_class.constantize
  end
  
end

ActionView::Base.send :include, ElasticMetaSearch::ViewHelpers
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