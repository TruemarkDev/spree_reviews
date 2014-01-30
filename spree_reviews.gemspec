Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reviews'
  s.version     = '2.2.0'
  s.summary     = 'Basic review and ratings facility for Spree'
  s.authors 	  = ['Paul Callaghan']
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.homepage          = 'https://github.com/spree/spree-reviews/'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.2.0.beta'

  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'database_cleaner', '1.0.1'
  s.add_development_dependency 'poltergeist', '1.4.1'
  s.add_development_dependency 'rspec-rails', '~> 2.12'
  s.add_development_dependency 'factory_girl_rails', '~> 4.2'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'pry'
end
