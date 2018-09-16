//
//  ViewController.swift
//  PKSecurePinExample
//
//  Created by Praveen on 07/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit
import PKSecurePin

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, PKSecurePinControllerDelegate {
    
    // create an instance of PKSecurePinViewController, with how many PIN, OTP or confirmation, position from top
    //NOTE: Please specify the correct value for topPos for the PIN text field w.r.t. to iPad & iPhone
    var pinViewC = PKSecurePinViewController.init(numberOfPins: 6, withconfirmation: true, topPos: 66)
    
    func didFinishSecurePin(pinValue: String) {
        
        //show the message if you want to display on success, else comment the below line
        pinViewC.showMessage(PKSecurePinError(errorString:"Pin Value \(pinValue)", errorCode: 200, errorIsHidden: false))
        //Go ahead with the business logic which you want to achieve with the PIN
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // set the background color for PIN controller
        pinViewC.view.backgroundColor = UIColor.white
        
        //set the delegate
        pinViewC.delegate = self
        
        // create the pin navigation controller
        let pinNav = UINavigationController(rootViewController: pinViewC)
        
        // set the presentation style
        pinNav.modalPresentationStyle = .popover
        
        //pinview controller position
        pinViewC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width * 0.5, height: 200)
        
        // create an instance for popover
        let popover = pinNav.popoverPresentationController
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popover?.sourceView = self.view
        
        //popover position
        popover?.sourceRect = CGRect(x: UIScreen.main.bounds.width * 0.5 - UIScreen.main.bounds.width * 0.25, y: UIScreen.main.bounds.height * 0.5 - 100, width: UIScreen.main.bounds.width * 0.5, height: 200)
        
        //present the pin navigation controller
        self.present(pinNav, animated: true, completion: nil)
    }
}

