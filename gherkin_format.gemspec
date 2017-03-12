Gem::Specification.new do |s|
  s.name        = 'gherkin_format'
  s.version     = '0.1.0'
  s.date        = '2017-03-12'
  s.summary     = 'Gherkin Format'
  s.description = 'Format Gherkin Files'
  s.authors     = ['Stefan Rohe']
  s.homepage    = 'http://github.com/funkwerk/gherkin_format/'
  s.files       = `git ls-files`.split("\n")
  s.executables = s.files.grep(%r{^bin/}) { |file| File.basename(file) }
  s.add_runtime_dependency 'gherkin', ['>= 2.12.2']
  s.add_development_dependency 'aruba', ['>= 0.6.2']
end
