//
//  ViewController.swift
//  PKSecurePinExample
//
//  Created by Praveen on 07/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation
import UIKit

enum passcodeError : Error
{
    case validPin
    case errorPin
}

let titleForCancel  = "Dismiss"

class PKSecurePinViewController : UIViewController
{
    let limitLength = 1
    let digitLength = 6
    
    var currentTFIndex = 0
    var pinFields = [PKSecureTextField]()
    
    var confirmViewCons = CGFloat.init(0)

    weak var firstPinTextField: PKSecureTextField!
    weak var secondPinTextField: PKSecureTextField!
    weak var thirdPinTextField: PKSecureTextField!
    weak var forthPinTextField: PKSecureTextField!
    
    weak var centerCons: NSLayoutConstraint!
    weak var errLblHeightCons: NSLayoutConstraint!
    weak var BtmCon: NSLayoutConstraint!
    weak var continueButtonCenterCons: NSLayoutConstraint!
    weak var confirmPinContainerViewCons: NSLayoutConstraint!
    weak var enterPasscodeContainerTopCons: NSLayoutConstraint!
    
    weak var errorLbl: UILabel!
    weak var confirmPin1: PKSecureTextField!
    weak var confirmPin2: PKSecureTextField!
    weak var confirmPin3: PKSecureTextField!
    weak var confirmPin4: PKSecureTextField!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var passcode      : Array<Int>?
    
    func checkPinCount() throws
    {
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    func initTextFields() {
        
        let width = 100.0
        let space = 10.0
        
        firstPinTextField = PKSecureTextField.init(frame: CGRect.init(x: 5, y: 10, width: width, height: 44))
        
        secondPinTextField = PKSecureTextField.init(frame: CGRect.init(x: firstPinTextField.frame.origin.x + CGFloat(width) + CGFloat(space),
                                                                       y: 10, width: CGFloat(width), height: 44))
        
        thirdPinTextField = PKSecureTextField.init(frame: CGRect.init(x: secondPinTextField.frame.origin.x + CGFloat(width) + CGFloat(space),
                                                                      y: 10, width: CGFloat(width), height: 44))
        
        forthPinTextField = PKSecureTextField.init(frame: CGRect.init(x: thirdPinTextField.frame.origin.x + CGFloat(width) + CGFloat(space),
                                                                      y: 10, width: CGFloat(width), height: 44))
        
        let yConfirmPinFrame = firstPinTextField.frame.origin.y + firstPinTextField.frame.size.height + 10
        
        confirmPin1 = PKSecureTextField.init(frame: CGRect.init(x: 5, y: yConfirmPinFrame, width: CGFloat(width), height: 44))
        
        confirmPin2 = PKSecureTextField.init(frame: CGRect.init(x: confirmPin1.frame.origin.x + CGFloat(width) + CGFloat(space),
                                                                y: yConfirmPinFrame, width: CGFloat(width), height: 44))
        
        confirmPin3 = PKSecureTextField.init(frame: CGRect.init(x: confirmPin2.frame.origin.x + CGFloat(width) + CGFloat(space),
                                                                y: yConfirmPinFrame, width: CGFloat(width), height: 44))
        
        confirmPin4 = PKSecureTextField.init(frame: CGRect.init(x: confirmPin3.frame.origin.x + CGFloat(width) + CGFloat(space),
                                                                y: yConfirmPinFrame, width: CGFloat(width), height: 44))
    }
    
    // MARK: - Private Methods
    
    private func initialise()
    {
        let pinTextFields = [firstPinTextField, secondPinTextField, thirdPinTextField, forthPinTextField] as? [PKSecureTextField]
        let confirmPinTextFields = [confirmPin1, confirmPin2, confirmPin3, confirmPin4] as? [PKSecureTextField]
        
        if pinTextFields?.count == confirmPinTextFields?.count {
            
            self.setupPinTextFields(pinTextFields: pinTextFields!, confirmPinTextFields: confirmPinTextFields!)
            
//            resetButton.isHidden = true;
            
//            submitButton.layer.cornerRadius = 5.0
//            submitButton.layer.borderWidth  = 2.0
//            submitButton.layer.borderColor  = UIColor.clear.cgColor
//            submitButton.isEnabled          = false
        }
        self.view.layoutIfNeeded()
    }
    
    fileprivate func enableTextFields(_ isEnable:Bool)
    {
        firstPinTextField.isEnabled  = isEnable
        secondPinTextField.isEnabled  = isEnable
        thirdPinTextField.isEnabled  = isEnable
        forthPinTextField.isEnabled  = isEnable
    }
    
    // MARK: - Self Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Secure Pin"
        self.view.backgroundColor = UIColor.white
        self.initTextFields()
         initialise()
//        self.resetOktaPin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupPinTextFields(pinTextFields: [PKSecureTextField], confirmPinTextFields: [PKSecureTextField])
    {
        pinFields.removeAll()
        
        for pinTextField in pinTextFields {
            self.addTargetForTextDidChange(textfield: pinTextField)
        }
        
        for confirmPinTextField in confirmPinTextFields {
            self.addTargetForTextDidChange(textfield: confirmPinTextField)
        }
    }
    
    fileprivate func addTargetForTextDidChange(textfield: PKSecureTextField)
    {
        textfield.deleteDelegate = self
        textfield.keyboardType = .numberPad
        self.view.addSubview(textfield)
        pinFields.append(textfield)
    }
    
    func resetOktaPin()
    {
        self.emptiedTextField(textfields: [self.firstPinTextField, self.secondPinTextField, self.thirdPinTextField, self.forthPinTextField, self.confirmPin1, self.confirmPin2, self.confirmPin3, self.confirmPin4])

        currentTFIndex = 0
        
        //call logic to handle input fields after reseting all pin fields as emptied
//        handleInputFields()
    }
    
    func emptiedTextField(textfields: [PKSecureTextField])
    {
        for textfield in textfields {
            textfield.text = nil
        }
    }
    
    func validString(inputString: String?) -> Bool
    {
        guard let text = inputString,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                // this will be reached if the text is nil (unlikely)
                // or if the text only contains white spaces
                // or no text at all
                return false
        }
        
        return true
    }
    
    //enable or disable submit button on input
    func tangibleSubmitButtonOnValidInput()
    {
//        submitButton.isEnabled  = false
        
//        do {
//            try  checkPinCount()
//        }
//        catch passcodeError.validPin {
//            submitButton.isEnabled = true
//        }
//        catch {
//            submitButton.isEnabled = false
//        }
    }
    
    // logic to handle input fields by making all fields inactive when writing on active field with one digit
    func handleInputFields() {
        
        let activeTextField = pinFields[currentTFIndex]
        
        //Step1: enable active input field from disable state
        enableActiveTextField(activeTextField)
        
        //Step2: remove active input field from pin fields
        let inActivePinFields = removeActiveTFFromArray(element: activeTextField)
        
        //Step3: diable all in active input fields from pin fields
        disableInActiveTextField(inActivePinFields)
    }
    
    //Step1: enable active input field from disable state
    func enableActiveTextField(_ textField: UITextField)
    {
        textField.isEnabled = true
        //currentTextField.backgroundColor = UIColor.green
        textField.becomeFirstResponder()
    }
    
    //Step2: remove active input field from pin fields
    func removeActiveTFFromArray(element: PKSecureTextField) -> [PKSecureTextField] {
        return pinFields.filter() { $0 !== element }
    }
    
    //Step3: diable all in active input fields from pin fields
    func disableInActiveTextField(_ inActivePinFields: [PKSecureTextField])
    {
        for textField in inActivePinFields {
            textField.isEnabled = false
            // textField.backgroundColor = UIColor.red
            textField.resignFirstResponder()
        }
    }
    
    // set the text field index for active input field on text change
    func setTextFieldIndexForActiveInputField() {
        //first text field
        if (isFirstTextField()) {
            setTFIndex(currentTFIndex + 1)
        }
        else if (isLastTextField())
        {
            //last text field
            setTFIndex(currentTFIndex)
        }
        else
        {
            setTFIndex(currentTFIndex + 1)
        }
    }
    
    // set the current text field index with count
    func setTFIndex(_ count: Int) {
        currentTFIndex = count
    }
    
    // return if active input field is first text field
    func isFirstTextField() -> Bool {
        return (currentTFIndex == 0)
    }
    
    // return if active input field is last text field
    func isLastTextField() -> Bool {
        return (currentTFIndex == pinFields.count - 1)
    }
}

extension PKSecurePinViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    
    func updateErrorLabel(_ error:PKSecurePinError)
    {
        errorLbl.isHidden           = error.errorIsHidden
        errorLbl.text               = error.errorString
        errLblHeightCons.constant   = error.errorLblCos
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        updateErrorLabel(PKSecurePinError(errorString:"", errorCode: 103, errorLblCos: 0, errorIsHidden: true))
        return true
    }
}

extension PKSecurePinViewController  : PKSecureTextFieldDelegate
{
    func secureTextFieldDidSelectDeleteButton(_ textField: UITextField)
    {
        if (textField.text?.count == 0) {
            let index = pinFields.index(of: textField as! PKSecureTextField)
            if (index! - 1 >= 0) {
                pinFields[index! - 1].text = ""
                setTFIndex(index! - 1)
                
                // call logic to handle input fields deleting
                handleInputFields()
            }
        }
    }
    
    func secureTextFieldDidChange(_ textField: UITextField) {
        
        // set the text field index for active input field on text change
        self.setTextFieldIndexForActiveInputField()
        
        // disable all the others input field except the active input field
        if validString(inputString: textField.text) {
            
            // call logic to handle input fields after text field did change
            handleInputFields()
        }
        
        //enable or disable submit button on input
        tangibleSubmitButtonOnValidInput()
    }
    
    func writeToTextFieldOnDidEndEditing(_ textField: UITextField, withDigit: Character) {
        textField.text = String(withDigit)
    }
    
    func updateError(_ error: PKSecurePinError) {
        self.updateErrorLabel(error)
    }
}

