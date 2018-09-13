# PKSecurePin
Elegant Secure PIN with 4 digits in Swift

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

**Feature:**
* Ease to use
* 4 digit pin input with confirm pin input
* Accept only numeric digit as input
* 1 numeric digit length for each input
* Auto jump to immediate next input on every insertion
* Auto jump to immediate previous input on every deletion
* Disallow to chose any input manually

<img src="./demo.gif" width="200" alt="Screenshot" />
<img src="./iphone_demo.gif" width="200" alt="Screenshot" />

# Installation
### CocoaPods
In your `Podfile`:
```
pod "PKSecurePin"
```

# Usage
```swift
       class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, PKSecurePinControllerDelegate
        // create an instance of PKSecurePinViewController, with how many PIN, OTP or confirmation, position from top
        let pinViewC  = PKSecurePinViewController.init(numberOfPins: 4, withconfirmation: false, topPos: 230)
        //set the delegate
        pinViewC.delegate = self
        
       // create the navigation controller
        let pinNav = UINavigationController(rootViewController: pinViewC)        
        pinNav.modalPresentationStyle = .popover

        //pinview controller position
        pinViewC.preferredContentSize = CGSize(width: 500, height: 200)
        
        // create an instance for popover
        let popover = pinNav.popoverPresentationController
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popover?.sourceView = self.view

        //popover position
        popover?.sourceRect = CGRect(x: UIScreen.main.bounds.width * 0.5 - UIScreen.main.bounds.width * 0.25, y: UIScreen.main.bounds.height * 0.5 - 100, width: UIScreen.main.bounds.width * 0.5, height: 200)
        
        //present the navigation controller
        self.present(pinNav, animated: true, completion: nil)



