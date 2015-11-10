Pod::Spec.new do |s|
  s.name         = "KittyKit"
  s.version      = "0.0.1"
  s.summary      = "A Swift framework for interacting with small.cat"
  s.description  = s.summary
  s.homepage     = "https://github.com/DanielTomlinson/KittyKit"
  s.license      = "MIT"
  s.author             = { "Daniel Tomlinson" => "Dan@Tomlinson.io" }
  s.social_media_url   = "http://twitter.com/DanToml"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/DanielTomlinson/KittyKit.git", :tag => s.version }
  s.source_files  = "KittyKit", "KittyKit/**/*.swift"
end
