#
#  Be sure to run `pod spec lint PKSecurePin.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "PKSecurePin"
  s.version      = "1.0.3"
  s.summary      = "Elegant Secure PIN with 4 digits in Swift"
  s.description  = 'Elegant Secure PIN with 4 digits in Swift'
  s.homepage     = "https://github.com/pvn/PKSecurePin"
  s.screenshots  = "https://github.com/pvn/PKSecurePin/blob/master/demo.gif", "https://github.com/pvn/PKSecurePin/blob/master/iphone_demo.gif"
  s.author             = { "Praveen Kumar Shrivastav" => "praveen.sunsetpoint@gmail.com" }
  s.platform     = :ios, '10.0'
  s.source       = { :git => "https://github.com/pvn/PKSecurePin.git", :tag => "#{s.version}" }
  s.source_files  = 'PKSecurePin/*.swift'
end
