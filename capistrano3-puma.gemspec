# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/puma/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano3-puma'
  spec.version = Capistrano::PUMAVERSION
  spec.authors = ['Abdelkader Boudih']
  spec.email = ['Terminale@gmail.com']
  spec.description = %q{Puma integration for Capistrano 3}
  spec.summary = %q{Puma integration for Capistrano}
  spec.homepage = 'https://github.com/seuros/capistrano-puma'
  spec.license = 'MIT'

  spec.required_ruby_version     = '>= 1.9.3'

  spec.files = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.7'
  spec.add_dependency 'capistrano-bundler'
  spec.add_dependency 'puma' , '>= 4.0', '< 6.0'
  spec.post_install_message = %q{
    All plugins need to be explicitly installed with install_plugin.
    Please see README.md
  }
end
