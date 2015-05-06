Pod::Spec.new do |s|
  s.name         = "Velociraptor"
  s.version      = "0.0.1"
  s.summary      = "A network stubbing framework written in pure Swift for iOS and OS X."

  s.description  = "Velociraptor is a network stubbing framework written in pure Swift for iOS and OS X."

  s.homepage     = "https://github.com/mrahmiao/velociraptor"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = "mrahmiao"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"

  s.source       = { :git => "https://github.com/mrahmiao/Velociraptor.git", :tag => "v#{s.version}" }
  s.source_files  = "Velociraptor", "Velociraptor/**/*.swift"

  s.requires_arc = true
end
