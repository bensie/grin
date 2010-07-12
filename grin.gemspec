Gem::Specification.new do |s|
  s.name = "grin"
  s.version = "0.9.0"
  s.authors = ["James Miller"]
  s.date = "2010-07-11"
  s.summary = %q{Ruby wrapper for the Fotogger API}
  s.description = %q{Grin is a simple Ruby wrapper for the Fotogger API v1 specification. It currently supports finding and creating albums and photos.}
  s.homepage = "http://github.com/bensie/grin"
  s.email = "james@jk-tech.com"
  s.files  = %w( README.rdoc Rakefile LICENSE )
  s.files += Dir.glob("lib/**/*")
  s.files += Dir.glob("test/**/*")
  s.has_rdoc = false
  s.add_dependency("rest-client", ">= 1.5.1")
  s.add_dependency("json", ">= 1.4.3")
end

