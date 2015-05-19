Gem::Specification.new do |specification|
  specification.name        = 'gherkin_format'
  specification.version     = '0.0.1'
  specification.date        = '2015-05-19'
  specification.summary     = 'Gherkin Format'
  specification.description = 'Format Gherkin Files'
  specification.authors     = ['Stefan Rohe']
  specification.homepage    = 'http://github.com/funkwerk/gherkin_format/'
  specification.files       = `git ls-files`.split("\n")
  specification.executables = specification.files.grep(%r{^bin/}) { |file| File.basename(file) }
  specification.add_runtime_dependency 'gherkin', ['>= 2.12.2']
end
