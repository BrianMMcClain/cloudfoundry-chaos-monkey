# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cfcm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian McClain"]
  gem.email         = ["brianmmcclain@gmail.com"]
  gem.description   = %q{Cloud Foundry Chaos Monkey}
  gem.summary       = gem.summary
  gem.homepage      = "https://github.com/BrianMMcClain/cloudfoundry-chaos-monkey"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cfcm"
  gem.require_paths = ["lib"]
  gem.version       = CFCM::VERSION
  
  gem.add_dependency "thor"
  gem.add_dependency "vmc"
end