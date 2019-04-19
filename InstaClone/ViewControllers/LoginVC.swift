//
//  LoginSignupViewController.swift
//  InstaClone
//
//  Created by Athena on 2/28/19.
//  Copyright © 2019 Sheena Elveus. All rights reserved.
//

import UIKit
import iOSDropDown
import Parse

class LoginVC: UIViewController {

    @IBOutlet var languageDropDown: DropDown!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var getHelpLabel: UILabel!
    @IBOutlet var switchPerspectiveButton: UIButton!
    @IBOutlet var fbSignupButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginScreen()
        
        //check for existing user credentials
        
    }
    

    // MARK: - Structural
    func setupLoginScreen() {
        createLangDropDown()
        CustomizationService.customizeTextField(textField: usernameTextField)
        CustomizationService.customizePlaceholderText(textField: usernameTextField, placeholderText: "Username")
        CustomizationService.customizeTextField(textField: passwordTextField)
        CustomizationService.customizePlaceholderText(textField: passwordTextField, placeholderText: "Password")
        CustomizationService.customizeButtons(button: loginButton)
       

    }
    
    
    func createLangDropDown(){
        languageDropDown.optionArray = ["English", "Spanish", "French"]
        
        // The Closure returns Selected Index and String
        languageDropDown.didSelect{(selectedText , index ,id) in
            print( "Selected String: \(selectedText) \n index: \(index)")
        }
        languageDropDown.backgroundColor = UIColor.clear
        languageDropDown.rowBackgroundColor = UIColor.clear
        languageDropDown.textColor = UIColor.white
        languageDropDown.borderColor = UIColor.clear
        languageDropDown.selectedRowColor = UIColor.white
        languageDropDown.rowHeight = 20
        
        var dropDownTitle = NSMutableAttributedString()
        let dropDownStr = "Language"
        dropDownTitle = NSMutableAttributedString(string: dropDownStr, attributes: nil)
        dropDownTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: dropDownStr.count))
        languageDropDown.attributedPlaceholder = dropDownTitle
        languageDropDown.layer.borderColor = UIColor.clear.cgColor

    }
 
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            AlertService.showAlertWithOkay(alertTitle: "Incomplete Fields", alertMsg: "Please make sure all fields are entered!")
        } else {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block:{ (user, error) in
                
                //logged in
                if user != nil {
                    print("Log in successful")
                    //self.performSegue(withIdentifier: "showUserTable", sender: self)
                } else{
                    var errorText = "Unknown error. Please try again."
                    if let error = error {
                        errorText = error.localizedDescription
                    }
                    AlertService.showAlertWithOkay(alertTitle: "Could Not Log You In", alertMsg: errorText)
                }
            })
        }
    }
    
}