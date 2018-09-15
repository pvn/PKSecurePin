#
#  Be sure to run `pod spec lint PKSecurePin.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "PKSecurePin"
  s.version      = "1.0.4"
  s.summary      = "Elegant Secure PIN with dynamic inputs in Swift"
  s.description  = 'Elegant Secure PIN with dynamic inputs in Swift with confirmation PIN as well with configuration'
  s.homepage     = "https://github.com/pvn/PKSecurePin"
  s.screenshots  = "PKSecurePin/blob/master/demo.gif", "PKSecurePin/blob/master/iphone_demo.gif"
  s.author             = { "Praveen Kumar Shrivastav" => "praveen.sunsetpoint@gmail.com" }
  s.platform     = :ios, '10.0'
  s.source       = { :git => "https://github.com/pvn/PKSecurePin.git", :tag => s.version.to_s }
  s.source_files  = 'PKSecurePin/*'
end
