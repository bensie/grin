Gem::Specification.new do |s|
  s.name = "grin"
  s.version = "1.0.0"
  s.authors = ["James Miller"]
  s.summary = %q{Ruby wrapper for the Fotogger API}
  s.description = %q{Grin is a simple Ruby wrapper for the Fotogger API v1 specification. It currently supports finding and creating albums, photos, and categories.}
  s.homepage = "http://github.com/bensie/grin"
  s.email = "james@jk-tech.com"
  s.files  = %w( README.rdoc Rakefile LICENSE ) + Dir.glob("lib/**/*") + Dir.glob("test/**/*")
  s.has_rdoc = false
  s.add_dependency("rest-client", "~> 1.6.0")
  s.add_dependency("json", "~> 1.4.3")
  s.add_development_dependency('shoulda')
end
