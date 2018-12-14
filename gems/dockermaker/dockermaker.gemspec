lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dockermaker/version'

Gem::Specification.new do |spec|
  spec.name          = 'dockermaker'
  spec.version       = Dockermaker::VERSION
  spec.authors       = ['Bryan Alves']
  spec.email         = ['bryanalves@gmail.com']

  spec.summary       = 'Rake tasks for building directories of docker images'
  spec.homepage      = 'https://bryanalves.github.io'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host' to allow pushing to a
  # single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'docker-api', '~> 1.34', '>= 1.34.2'
  spec.add_dependency 'docker_registry2', '~> 1.4.1'
  spec.add_dependency 'rake', '~> 12.3', '>= 12.3.1'
  spec.add_dependency 'serverspec', '~> 2.41', '>= 2.41.3'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
