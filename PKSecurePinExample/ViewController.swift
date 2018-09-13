//
//  ViewController.swift
//  PKSecurePinExample
//
//  Created by Praveen on 07/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, PKSecurePinControllerDelegate {
    
    func didFinishSecurePin() {
        print("success")
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
        
        let pinViewC  = PKSecurePinViewController.init(numberOfPins: 4, withconfirmation: false, topPos: 230)
        pinViewC.delegate = self
        
        let pinNav = UINavigationController(rootViewController: pinViewC)
        
        pinNav.modalPresentationStyle = .popover
        //pinview controller position
        pinViewC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width * 0.5, height: 200)
        
        let popover = pinNav.popoverPresentationController
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popover?.sourceView = self.view
        //popover position
        popover?.sourceRect = CGRect(x: UIScreen.main.bounds.width * 0.5 - UIScreen.main.bounds.width * 0.25, y: UIScreen.main.bounds.height * 0.5 - 100, width: UIScreen.main.bounds.width * 0.5, height: 200)
        
        self.present(pinNav, animated: true, completion: nil)
    }
}

