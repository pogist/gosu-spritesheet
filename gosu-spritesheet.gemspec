require File.expand_path("../lib/gosu/spritesheet/version.rb", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "gosu-spritesheet"
  spec.version       = Gosu::Spritesheet::VERSION
  spec.authors       = ["pogist"]
  spec.email         = ["murilo.paixao.2@gmail.com"]

  spec.summary       = "Useful spritesheet extension for Gosu."
  spec.description   = "A useful and yet simple spritesheet extension for Gosu."
  spec.homepage      = "https://github.com/pogist/gosu-spritesheet"
  spec.license       = "MIT"
  spec.files         = Dir['lib/**/*.rb'] + [
    "README.md",
    "LICENSE.md",
    "Rakefile",
    "gosu-spritesheet.gemspec"
  ]
  spec.test_files = Dir['test/**/*.rb', 'test/*.rb']

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata = {
      "homepage_uri" => spec.homepage,
      "source_code_uri" => spec.homepage
    }
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.add_dependency "gosu", "~> 0.14"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.3"
end
