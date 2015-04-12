Gem::Specification.new do |spec|
  spec.name          = "lita-cwb"
  spec.version       = "0.1.0"
  spec.authors       = ["Huei-Horng Yo"]
  spec.email         = ["hiroshi@ghostsinthelab.org"]
  spec.description   = "Lita handler with Open Data from Central Weather Bureau"
  spec.summary       = "Lita handler with Open Data from Central Weather Bureau, get forecasts information from CWB."
  spec.homepage      = ""
  spec.license       = "MPL-2.0"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.3"
  spec.add_runtime_dependency "nokogiri", "~> 1.6.6.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
