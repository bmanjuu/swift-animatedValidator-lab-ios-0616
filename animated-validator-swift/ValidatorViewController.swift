//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var viewWithAllTextFields: UIStackView!
    
    var validChecks : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        //AUTOLAYOUT
        self.view.removeConstraints(self.view.constraints)
        self.viewWithAllTextFields.removeConstraints(self.viewWithAllTextFields.constraints)
        
        
        self.submitButton.enabled = false
        //self.submitButton.hidden = true
        
        self.emailTextField.widthAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.widthAnchor, multiplier: 0.75).active = true
        self.emailTextField.centerXAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.centerXAnchor).active = true
        self.emailTextField.topAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.topAnchor).active = true
        
        self.emailConfirmationTextField.widthAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.widthAnchor, multiplier: 0.75).active = true
    self.emailConfirmationTextField.centerXAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.centerXAnchor).active = true
        self.emailConfirmationTextField.topAnchor.constraintEqualToAnchor(self.emailTextField.bottomAnchor, constant: 10)
        
        self.phoneTextField.widthAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.widthAnchor, multiplier: 0.75).active = true
        self.phoneTextField.centerXAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.centerXAnchor).active = true
        self.phoneTextField.topAnchor.constraintEqualToAnchor(self.emailConfirmationTextField.bottomAnchor, constant: 10)
        
        self.passwordTextField.widthAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.widthAnchor, multiplier: 0.75).active = true
        self.passwordTextField.centerXAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.centerXAnchor).active = true
        self.passwordTextField.topAnchor.constraintEqualToAnchor(self.phoneTextField.bottomAnchor, constant: 10)
        
        
        self.passwordConfirmTextField.widthAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.widthAnchor, multiplier: 0.75).active = true
        self.passwordConfirmTextField.centerXAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.centerXAnchor).active = true
    self.passwordConfirmTextField.topAnchor.constraintEqualToAnchor(self.passwordTextField.bottomAnchor, constant: 10)
        
        
        self.submitButton.centerXAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.centerXAnchor).active = true
        self.submitButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
        
    self.viewWithAllTextFields.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    self.viewWithAllTextFields.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.viewWithAllTextFields.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        self.viewWithAllTextFields.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        
    }
    
    @IBAction func signupFields(sender: UITextField) {
        
        
        //switch statement, one case per field
        //in each case, call a function that checks whether contents are valid or not
        //the the field is a confirmation field, compare it to the original field, but only if the original one is valid
        //if a field is invalid, make textfield background red/pulse
        //if all fields are valid, submit
        
        switch sender {
        case emailTextField:
            if let email = emailTextField.text {
                if checkEmail(email) {
                    validChecks+=1
                    emailTextField.backgroundColor = UIColor.clearColor()
                } else {
                    shakeItOff(emailTextField)
                }
            }
        case emailConfirmationTextField:
            if let confirmEmail = emailConfirmationTextField.text {
                if emailTextField.text == confirmEmail{
                    validChecks+=1
                    emailConfirmationTextField.backgroundColor = UIColor.clearColor()
                } else {
                    shakeItOff(emailConfirmationTextField)
                }
            }
        case phoneTextField:
            if let phone = phoneTextField.text {
                if phone.characters.count >= 7 && Int(phone) != nil {
                    validChecks+=1
                    phoneTextField.backgroundColor = UIColor.clearColor()
                } else {
                    shakeItOff(phoneTextField)
                }
            }
        case passwordTextField:
            if let password = passwordTextField.text {
                if password.characters.count >= 6 {
                    validChecks+=1
                    passwordTextField.backgroundColor = UIColor.clearColor()
                } else {
                    shakeItOff(passwordTextField)
                }
            }
        case passwordConfirmTextField:
            if let passwordConfirm = passwordConfirmTextField.text {
                if passwordConfirmTextField.text == passwordConfirm {
                    validChecks+=1
                    passwordConfirmTextField.backgroundColor = UIColor.clearColor()
                } else {
                    shakeItOff(passwordConfirmTextField)
                }
            }
        default:
            print("went through all cases")
        } // end of switch statement
        
        if validChecks == 5 {
            submitButton.enabled = true
        }
    }//end of IBAction
    
    
    @IBAction func submitButtonTapped(sender: UIButton){
        //enable the button
        //animate it to show underneath the textfields
    }
    
    func checkEmail(emailText: String) -> Bool {
        if emailText.containsString("@") && emailText.containsString("."){
            return true
        }
        return false
    }
    
    
    func shakeItOff(sender: UITextField) {
        UITextField.animateWithDuration(0.2, delay: 0.0, options: [.Autoreverse], animations: {
            sender.backgroundColor = UIColor.redColor()
            sender.alpha = 0.50
            sender.removeConstraints(self.viewWithAllTextFields.constraints)
            sender.widthAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.widthAnchor, multiplier: 0.85).active = true
            self.view.layoutIfNeeded()
        }) { (completed) in
            //final looks
            sender.backgroundColor = UIColor.redColor()
            sender.removeConstraints(self.viewWithAllTextFields.constraints)
            sender.widthAnchor.constraintEqualToAnchor(self.viewWithAllTextFields.widthAnchor, multiplier: 0.75).active = true
            sender.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }
}

