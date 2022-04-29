# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tdameritrade/version'

Gem::Specification.new do |spec|
  spec.name          = "tdameritrade-api-ruby"
  spec.version       = TDAmeritrade::VERSION
  spec.authors       = ["Winston Kotzan"]
  spec.email         = ["wak@wakproductions.com"]
  spec.summary       = %q{This is a simple gem for connecting to the TD Ameritrade Developers OAuth API}
  spec.description   = "This is a gem for connecting to the OAuth/JSON-based TD Ameritrade Developers API released " \
                       "in 2018. Go to https://developer.tdameritrade.com/ for the official documentation and to " \
                       "create your OAuth application."
  spec.homepage      = "https://github.com/wakproductions/tdameritrade-api-ruby"
  spec.license       = "MIT"

  spec.files         = [`git ls-files`.split($/)] + Dir["lib/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"
  spec.add_dependency "hashie"
  spec.add_dependency "httparty", "~> 0.13"
  spec.add_dependency "nokogiri", "~> 1.6"

  spec.add_development_dependency "clipboard"
  spec.add_development_dependency "httplog"
  spec.add_development_dependency "rspec", ">= 3.2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
