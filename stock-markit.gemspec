require './lib/stock-markit'

Gem::Specification.new do |gem|
  gem.name        = 'stock-markit'
  gem.license     = 'MIT'
  gem.version     = StockMarkit::VERSION
  gem.summary     = 'stock-markit is the ruby interface for Markit on Demand.'
  gem.description = "the stock-markit gem brings all the great information from Markit on Demand to your ruby project (http://dev.markitondemand.com/)"
  gem.authors     = ['Michael Heijmans']
  gem.email       = 'parabuzzle@gmail.com'
  gem.homepage    = 'https://github.com/parabuzzle/stock-markit'
  gem.files       = Dir.glob("lib/**/*")

  gem.add_dependency('httparty', '~> 0.14')
  gem.add_dependency('oj', '~> 2.17')
  gem.add_dependency('activesupport', '~> 4.2')

  gem.add_development_dependency 'rspec', '~>3.0'
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
end
