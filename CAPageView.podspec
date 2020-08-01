Pod::Spec.new do |spec|

  spec.name         = "CAPageView"
  spec.version      = "1.1.0"
  spec.summary      = "This package contains a PageView purely written in SwiftUI."
  spec.homepage     = "https://github.com/Connapptivity/SwiftUI-PageView"
  
  spec.license      = { :type => "Restricted", :file => "LICENSE" }
  
  spec.author       = { "Marlo Kessler" => "marlo.kessler@connapptivity.de" }
  
  spec.ios.deployment_target     = "13.0"
  spec.osx.deployment_target     = "10.15"
  spec.watchos.deployment_target = "6.0"
  spec.tvos.deployment_target    = "13.0"

  spec.source       = { :git => "https://github.com/Connapptivity/SwiftUI-PageView.git", :tag => "#{spec.version}" }
  
  spec.source_files  = "Sources", "Sources/**/*.{swift}"
  spec.exclude_files = "Sources/Exclude"

  spec.framework  = "Foundation"
  
  spec.swift_version = "5.2"

end
