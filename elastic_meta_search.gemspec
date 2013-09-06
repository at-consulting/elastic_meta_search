$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "elastic_meta_search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "elastic_meta_search"
  s.version     = ElasticMetaSearch::VERSION
  s.authors     = ["dtataurov", "ddonskoi"]
  s.email       = ["dtataurov@at-consulting.ru", "ddonskoi@at-consulting.ru"]
  s.homepage    = "https://github.com/at-consulting/elastic_meta_search.git"
  s.summary     = ""
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency       "rails", ">= 3.1.3"
  s.add_dependency       "tire", ">= 0.4.2"
  s.add_dependency       "jquery-rails", "= 2.1.3"
  s.add_dependency       "i18n", ">= 0.6.1"

  s.add_development_dependency "sqlite3"
end
