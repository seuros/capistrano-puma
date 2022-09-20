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

  spec.required_ruby_version = '>= 2.5'

  spec.files = Dir.glob('lib/**/*') + %w(README.md CHANGELOG.md LICENSE.txt)
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.7'
  spec.add_dependency 'capistrano-bundler'
  spec.add_dependency 'puma', '>= 5.1', '< 6.0'
  spec.post_install_message = %q{
    Version 6.0.0 is a major release. Please see README.md, breaking changes are listed in CHANGELOG.md
  }
end
