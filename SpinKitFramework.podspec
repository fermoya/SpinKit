Pod::Spec.new do |s|

  s.name         = "SpinKitFramework"
  s.version      = "1.0.1"
  s.summary      = "Beautiful spinners to let your user know your App have some heavy task to do."

  s.description  = <<-DESC
  This framework provides several spinners based on tobiasahlin CSS version. It lets you customize them to adjust it to your App needs.
                   DESC

  s.homepage     = "https://github.com/fermoya"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fermoya" => "fmdr.ct@gmail.com" }

  s.platform     = :ios
  s.ios.deployment_target  = '9.0'
  s.swift_version = '4.2'

  s.source       = { :git => "https://github.com/fermoya/SpinKit.git", :tag => "#{s.version}" }
  s.source_files  = "SpinKit/*.swift"

  s.xcconfig = { "SWIFT_VERSION" => "4.2" }
  s.documentation_url = "https://github.com/fermoya/SpinKit/blob/master/README.md"

end