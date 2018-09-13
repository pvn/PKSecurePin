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

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}

protocol PKSecurePinControllerDelegate {
    
    func didFinishSecurePin() -> Void
}

class PKSecurePinViewController : UIViewController
{
    let limitLength = 1
    let digitLength = 6
    
    //textfield frame config
    let spaceBwTextField = 5
    var topPos = 0
    let xPosTextField = 25
    let yPosForErrLbl = 0
    let heightTextField = 45
    var textFieldSize = CGSize.init(width: 0, height: 0) // (width, height) calculating by sizeFrame() method
    var numberOfPins = 0
    
    var currentTFIndex = 0
    var pinFields = [PKSecureTextField]()
    var originalPinTFs = [PKSecureTextField]()
    var confirmationPinTFs = [PKSecureTextField]()
    

    var firstPinTextField: PKSecureTextField!
    var secondPinTextField: PKSecureTextField!
    var thirdPinTextField: PKSecureTextField!
    var forthPinTextField: PKSecureTextField!
    
    var centerCons: NSLayoutConstraint!
    var errLblHeightCons: NSLayoutConstraint!
    var BtmCon: NSLayoutConstraint!
    var continueButtonCenterCons: NSLayoutConstraint!
    var confirmPinContainerViewCons: NSLayoutConstraint!
    var enterPasscodeContainerTopCons: NSLayoutConstraint!
    
    var errorLbl: UILabel?
    var confirmPin1: PKSecureTextField!
    var confirmPin2: PKSecureTextField!
    var confirmPin3: PKSecureTextField!
    var confirmPin4: PKSecureTextField!
    
    var itemsOfFirstSets = [String]()
    var itemsOfSecondSets = [String]()
    
    var passcode      : Array<Int>?
    
    var delegate: PKSecurePinControllerDelegate?
    
    var withConfirmationPIN = false
    
    init(numberOfPins: Int, withconfirmation: Bool, topPos: Int) {
        super.init(nibName: nil, bundle: nil)
        self.numberOfPins = numberOfPins
        self.withConfirmationPIN = withconfirmation
        self.topPos = topPos
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Setup secure textfields
    
    fileprivate func initOriginalSetupPin() {
        
        textFieldSize = self.sizeFrame()
        
        if !withConfirmationPIN {
            self.topPos = (self.topPos <= 0) ? Int((self.view.frame.size.height - textFieldSize.height) / 2) : self.topPos
        }
        
        firstPinTextField = PKSecureTextField.init(frame: CGRect.init(origin: CGPoint.init(x: xPosTextField, y: self.topPos), size: textFieldSize))
        secondPinTextField = self.getSecureTextField(textField: firstPinTextField, topPos: self.topPos, size: textFieldSize)
        thirdPinTextField = self.getSecureTextField(textField: secondPinTextField, topPos: self.topPos, size: textFieldSize)
        forthPinTextField = self.getSecureTextField(textField: thirdPinTextField, topPos: self.topPos, size: textFieldSize)
    }
    
    fileprivate func initConfirmationSetOfPins() {
        
        self.topPos = Int(firstPinTextField.frame.origin.y + firstPinTextField.frame.size.height + 10)
        
        confirmPin1 = PKSecureTextField.init(frame: CGRect.init(origin: CGPoint.init(x: xPosTextField, y: self.topPos), size: textFieldSize))
        confirmPin2 = self.getSecureTextField(textField: confirmPin1, topPos: self.topPos, size: textFieldSize)
        confirmPin3 = self.getSecureTextField(textField: confirmPin2, topPos: self.topPos, size: textFieldSize)
        confirmPin4 = self.getSecureTextField(textField: confirmPin3, topPos: self.topPos, size: textFieldSize)
    }
    
    func initPins() {
        
        initOriginalSetupPin()
        if withConfirmationPIN {
            initConfirmationSetOfPins()
        }
    }
    
    func getSecureTextField(textField: PKSecureTextField, topPos: Int, size: CGSize) -> PKSecureTextField {
        return PKSecureTextField.init(frame: CGRect.init(origin: self.pointFrame(textField: textField, topPos: topPos),
                                                         size: size))
    }
    
    func pointFrame(textField: PKSecureTextField, topPos: Int) -> CGPoint {
        
        return CGPoint.init(x: Int(textField.frame.maxX) + spaceBwTextField, y: topPos)
    }
    
    func sizeFrame() -> CGSize {
        
        let leftRightMargin = xPosTextField * 2
        let width = ((Int(self.view.frame.size.width) - leftRightMargin) - (spaceBwTextField*(numberOfPins-1))) / 4
    
        return CGSize.init(width: width, height: heightTextField)
    }
    
    // MARK: - Private Methods
    
    private func addOriginalSetOfPinsToView() {
        
        let pinTextFields = [firstPinTextField, secondPinTextField, thirdPinTextField, forthPinTextField] as? [PKSecureTextField]
        self.setupPinTextFields(pinTextFields: pinTextFields!, confirmPinTextFields: [])
        self.view.layoutIfNeeded()
    }
    
    private func addConfirmationSetOfPinsToView() {
        
        let pinTextFields = [firstPinTextField, secondPinTextField, thirdPinTextField, forthPinTextField] as? [PKSecureTextField]
        let confirmPinTextFields = [confirmPin1, confirmPin2, confirmPin3, confirmPin4] as? [PKSecureTextField]
        
        if pinTextFields?.count == confirmPinTextFields?.count {
            self.setupPinTextFields(pinTextFields: pinTextFields!, confirmPinTextFields: confirmPinTextFields!)
        }
        self.view.layoutIfNeeded()
    }
    
    func addErrorLabel() {
        
        self.errorLbl = UILabel.init(frame: CGRect(x:Int(firstPinTextField.frame.maxX), y: topPos + 75, width: 225, height: 20))
        self.errorLbl?.isHidden = true
        self.errorLbl?.textColor = UIColor.red
        self.view.addSubview(self.errorLbl!)
    }
    
    fileprivate func enableTextFields(_ isEnable:Bool) {
        firstPinTextField.isEnabled  = isEnable
        secondPinTextField.isEnabled = isEnable
        thirdPinTextField.isEnabled  = isEnable
        forthPinTextField.isEnabled  = isEnable
    }
    
    // MARK: - Self Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Enter PIN"
        self.view.backgroundColor = UIColor.white
        
        // initialize the pins
        self.initPins()
        // init and add error label
        self.addErrorLabel()
        
        // add first set of pins we call as original
        self.addOriginalSetOfPinsToView()
        
        // add second set of pins we call as confirmation if var 'withConfirmationPIN' is true
        if self.withConfirmationPIN {
            self.addConfirmationSetOfPinsToView()
        }
        
        //set currentTFIndex to 0 nothing but first textfield
        currentTFIndex = 0
        //logic to handle input fields by making all fields inactive when writing on active field with one digit
        self.handleInputFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupPinTextFields(pinTextFields: [PKSecureTextField], confirmPinTextFields: [PKSecureTextField])  {
        pinFields.removeAll()
        
        for pinTextField in pinTextFields {
            self.addTargetForTextDidChange(textfield: pinTextField)
        }
        
        for confirmPinTextField in confirmPinTextFields {
            self.addTargetForTextDidChange(textfield: confirmPinTextField)
        }
    }
    
    fileprivate func addTargetForTextDidChange(textfield: PKSecureTextField)  {
        textfield.isSecureTextEntry = true
        textfield.textAlignment = .center
        textfield.deleteDelegate = self
        textfield.keyboardType = .numberPad
        self.view.addSubview(textfield)
        pinFields.append(textfield)
    }
    
    func resetPins()
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
            
            if (!withConfirmationPIN) {
                self.delegate?.didFinishSecurePin()
                self.updateError(PKSecurePinError(errorString:"Success", errorCode: 200, errorIsHidden: false))
            }
            else if (withConfirmationPIN && self.validateConfirmPins()) {
                self.delegate?.didFinishSecurePin()
            }
            else {
                    self.updateError(PKSecurePinError(errorString:"Confirm PIN does not match", errorCode: 103, errorIsHidden: false))
            }
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
    
    func validateConfirmPins() -> Bool {
        itemsOfFirstSets.removeAll()
        itemsOfSecondSets.removeAll()
        var i = 0
        for textField in pinFields {
            
            //for first set
            if (i<numberOfPins) {
                itemsOfFirstSets.append(textField.text!)
            }
            else {
            //for second set
                itemsOfSecondSets.append(textField.text!)
            }
            i = i+1
        }
        
        return itemsOfFirstSets.containsSameElements(as: itemsOfSecondSets)
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
        self.errorLbl!.isHidden           = error.errorIsHidden
        self.errorLbl!.text               = error.errorString
        self.errorLbl?.textColor          = error.errorCode == 200 ? UIColor.green : UIColor.red
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
        else {            
            updateError(PKSecurePinError(errorString:"", errorCode: 103, errorIsHidden: true))
        }
    }
    
    func secureTextFieldDidChange(_ textField: UITextField) {
        
        // disable all the others input field except the active input field
        if validString(inputString: textField.text) {
            
            // set the text field index for active input field on text change
            self.setTextFieldIndexForActiveInputField()
            
            // call logic to handle input fields after text field did change
            handleInputFields()
        }
        
        //enable or disable submit button on input
//        tangibleSubmitButtonOnValidInput()
    }
    
    func writeToTextFieldOnDidEndEditing(_ textField: UITextField, withDigit: Character) {
        textField.text = String(withDigit)
    }
    
    func updateError(_ error: PKSecurePinError) {
        self.updateErrorLabel(error)
    }
}

