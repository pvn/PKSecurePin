#
#  Be sure to run `pod spec lint PKSecurePin.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "PKSecurePin"
  s.version      = "1.0.8"
  s.summary      = "Elegant Secure PIN with dynamic 'n' inputs using Swift"
  s.description  = 'Elegant dynamic secure PINs, which may have 'n' inputs based on confguration with or without confirmation PIN using swift code'
  s.homepage     = "https://github.com/pvn/PKSecurePin"
  s.screenshots  = "https://www.dropbox.com/s/noohfrqjgg0o54h/iphone_demo.gif?dl=0", "https://www.dropbox.com/s/fpyspsl4xva5wye/demo.gif?dl=0"
  s.author       = { "Praveen Kumar Shrivastav" => "composetopraveen@gmail.com" }
  s.social_media_url = 'https://twitter.com/praveen_tech'
  s.platform     = :ios, '10.0'
  s.source       = { :git => "https://github.com/pvn/PKSecurePin.git", :tag => s.version.to_s }
  s.source_files  = 'PKSecurePin/*'
  s.swift_version = "4.0"
end
