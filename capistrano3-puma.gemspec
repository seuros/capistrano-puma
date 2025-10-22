# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'capistrano3-puma'
  spec.version = '7.1.0'
  spec.authors = ['Abdelkader Boudih']
  spec.email = ['Terminale@gmail.com']
  spec.description = %q{Puma integration for Capistrano 3}
  spec.summary = %q{Puma integration for Capistrano}
  spec.homepage = 'https://github.com/seuros/capistrano-puma'
  spec.license = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new(">= 2.4")

  spec.files = Dir.glob('lib/**/*') + %w(README.md CHANGELOG.md LICENSE.txt)
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.7'
  spec.add_dependency 'capistrano-bundler'
  spec.add_dependency 'puma', '>= 6.1', '< 8.0'
end
