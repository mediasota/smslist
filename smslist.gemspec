$:.push File.expand_path('../lib', __FILE__)

require 'smslist/version'

Gem::Specification.new do |s|
  s.name        = 'smslist'
  s.version     = Smslist::VERSION
  s.authors     = ['Yury Lebedev']
  s.email       = ['lebedev.yurii@gmail.com']
  s.homepage    = 'https://github.com/lebedev-yury/smslist'
  s.summary     = 'Ruby wrapper for smslist API'
  s.description = 'Now you can send sms messages to your users.'
  s.licenses    = ['MIT']

  s.files = %w(MIT-LICENSE Rakefile README.md)
  s.files += Dir.glob('lib/**/*.rb')
  s.files += Dir.glob('spec/**/*')

  s.required_rubygems_version = '>= 1.3.6'

  s.add_dependency 'rails', '~> 3.2.13'
  s.add_dependency 'httparty', '>= 0.10'
  s.add_dependency 'nokogiri', '>= 1.5'

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.0'
end
