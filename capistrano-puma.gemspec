# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'capistrano-puma'
  spec.version = '0.0.4'
  spec.authors = ['Abdelkader Boudih']
  spec.email = ['Terminale@gmail.com']
  spec.description = %q{Puma integration for Capistrano}
  spec.summary = %q{Puma integration for Capistrano}
  spec.homepage = 'https://github.com/seuros/capistrano-puma'

  spec.files = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '> 3.0.0'

end
