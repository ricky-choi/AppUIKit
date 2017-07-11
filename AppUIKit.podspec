Pod::Spec.new do |s|
  s.name                 = "AppUIKit"
  s.version              = "0.2.0"
  s.summary              = "iOS UI Design for macOS"
  s.homepage             = "https://github.com/Ricky-Choi/AppUIKit"
  s.license              = "MIT"
  s.author               = { "Jae Young Choi" => "hideyf@gmail.com" }
  s.osx.deployment_target= "10.12"
  s.source             = { :git => "https://github.com/Ricky-Choi/AppUIKit.git", :tag => "#{s.version}" }
  s.source_files         = "AppUIKit/*.swift"
  s.resources            = ["AppUIKit/Media.xcassets"]
  s.dependency 'IUExtensions'
end
