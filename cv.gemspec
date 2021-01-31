# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cv/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paulo Mouat"]
  gem.email         = ["paulo.mouat@gmail.com"]
  gem.description   = %q{Cv is a library to generate a resume/curriculum vitae file in PDF, HTML or TXT based on an XML input file.}
  gem.summary       = %q{Generate a resume in PDF, HTML or TXT based on an XML file}
  gem.homepage      = "https://github.com/paulomouat/cv/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cv"
  gem.require_paths = ["lib"]
  gem.version       = Cv::VERSION

  gem.add_dependency 'prawn'
  gem.add_dependency 'builder'
  gem.add_dependency 'ionfish-stylish'
end
