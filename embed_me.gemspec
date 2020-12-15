$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "embed_me/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "embed_me"
  spec.version     = EmbedMe::VERSION
  spec.authors     = ["Tobias Bohn"]
  spec.email       = ["info@tobiasbohn.com"]
  spec.homepage    = "https://github.com/tobiasbhn/embed-me"
  spec.summary     = "EmbedMe allows you and your users to easily embed your rails application or parts of it on other websites."
  spec.description = "EmbedMe allows you and your users to easily embed your rails application or parts of it on other websites."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
end
