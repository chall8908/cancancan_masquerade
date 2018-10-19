lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cancancan/masquerade/version'

Gem::Specification.new do |spec|
  spec.name          = 'cancancan_masquerade'
  spec.version       = CanCanCan::Masquerade::VERSION
  spec.authors       = ['Chris Hall']
  spec.email         = ['chall8908@gmail.com']

  spec.summary       = 'Allow your objects to masquerade as other objects when checking permissions'
  spec.description   = <<-DESC
  Put on a mask and pretend!  CanCanCan::Masquerade allows
  your objects to pretend to be other objects when checking
  permissions.
  DESC
  spec.homepage      = 'https://github.com/chall8908/cancancan_masquerade'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'cancancan', '~> 2.1'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.59'
end
