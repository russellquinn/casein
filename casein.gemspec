# frozen_string_literal: true

$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'casein/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'casein'
  s.version     = Casein::VERSION
  s.authors     = ['Russell Quinn']
  s.date        = '2020-08-02'
  s.description = 'A lightweight CMS toolkit for Ruby on Rails, based on Bootstrap.'
  s.summary     = 'A lightweight CMS toolkit for Ruby on Rails, based on Bootstrap.'
  s.email       = ['mail@russellquinn.com']
  s.homepage    = 'http://www.caseincms.com/'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.rdoc']
  s.extra_rdoc_files = [
    'LICENSE',
    'README.rdoc'
  ]

  s.add_dependency 'authlogic', '~> 6.1'
  s.add_dependency 'bootstrap-sass', '~> 3.4.0'
  s.add_dependency 'jquery-rails', '>= 0'
  s.add_dependency 'sassc-rails', '>= 2.0.0'
  s.add_dependency 'scrypt', '>= 1.2.1'
  s.add_dependency 'will_paginate', '>= 3.1.5'

  s.add_development_dependency 'capybara', '~> 3.0'
  s.add_development_dependency 'capybara-rails', '>= 0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-rails', '>= 0'
  s.add_development_dependency 'sqlite3', '>= 0'
end
