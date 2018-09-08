//
//  ViewController.swift
//  PKSecurePinExample
//
//  Created by Praveen on 07/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let pinViewC  = PKSecurePinViewController.init()
        
        let pinNav = UINavigationController(rootViewController: pinViewC)
        
        pinNav.modalPresentationStyle = .popover
        //pinview controller position
        pinViewC.preferredContentSize = CGSize(width: 500, height: 200)
        
        let popover = pinNav.popoverPresentationController
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popover?.sourceView = self.view
        //popover position
        popover?.sourceRect = CGRect(x: UIScreen.main.bounds.width * 0.5 - 200, y: UIScreen.main.bounds.height * 0.5 - 100, width: 400, height: 200)
        
        self.present(pinNav, animated: true, completion: nil)
    }
}

