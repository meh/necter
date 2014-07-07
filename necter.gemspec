Gem::Specification.new do |spec|
  spec.name          = "necter"
  spec.version       = "0.1.0"
  spec.authors       = ["meh."]
  spec.email         = ["meh@schizofreni.co"]
  spec.summary       = %q{ConnMan controller}
  spec.homepage      = "http://github.com/meh/necter"
  spec.license       = "WTFPL"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"

	spec.add_dependency 'ruby-dbus'
	spec.add_dependency 'hwaddr'
	spec.add_dependency 'colorb'
end
