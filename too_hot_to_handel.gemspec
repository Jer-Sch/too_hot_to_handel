
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "too_hot_to_handel/version"

Gem::Specification.new do |spec|
  spec.name          = "too_hot_to_handel"
  spec.version       = TooHotToHandel::VERSION
  spec.authors       = ["Jeremy Schuurmans"]
  spec.email         = ["schuurm@ns.codes"]

  spec.summary       = %q{TooHotToHandel is a gem that scrapes Gramophone.co.uk for the latest classical music news and reviews. It allows you to read articles directly on the command line. TooHotToHandel is essential for any tech-savvy classical music lover!}
  spec.homepage      = "https://github.com/palledorous/too_hot_to_handel"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://www.rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "colorize"
  spec.add_development_dependency "nokogiri", ">= 1.8.2"
end
