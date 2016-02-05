//
//  RegistrationTableViewController.swift
//  VenopsMobileApp
//
//  Created by Jay Maloney on 1/27/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit
import Firebase


class RegistrationTableViewController: UITableViewController{


    @IBOutlet weak var highlightView: UIView!

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var addressTextField: UITextField!

    @IBOutlet weak var cityTextField: UITextField!

    @IBOutlet weak var stateTextField: UITextField!

    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    @IBOutlet weak var zipcodeTextField: UITextField!

    @IBOutlet weak var licenseIDTextField: UITextField!
    
    override func viewDidLoad() {


    }

    override func viewDidAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func scanIDButtonTapped(sender: AnyObject) {

        UserController.saveUserDataToNSUserDefaults(usernameTextField.text, key: "username")
        UserController.saveUserDataToNSUserDefaults(emailTextField.text, key: "email")
        UserController.saveUserDataToNSUserDefaults(passwordTextField.text, key: "password")
        
        performSegueWithIdentifier("toScanner", sender: nil)
    }

    @IBAction func registerButtonTapped(sender: AnyObject) {

        performSegueWithIdentifier("toRegisterConfirmationViewController", sender: nil)

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "toRegisterConfirmationViewController" {
            if let registrationConfirmationTableViewController = segue.destinationViewController as?
                RegistrationConfirmationTableViewController {

                _ = registrationConfirmationTableViewController.view
                registrationConfirmationTableViewController.usernameTextField.text = usernameTextField.text
                registrationConfirmationTableViewController.emailField.text = emailTextField.text
                registrationConfirmationTableViewController.passwordField.text = passwordTextField.text
                registrationConfirmationTableViewController.zipcodeTextField.text = zipcodeTextField.text
                registrationConfirmationTableViewController.cityTextField.text = cityTextField.text
                registrationConfirmationTableViewController.stateTextField.text = stateTextField.text
                registrationConfirmationTableViewController.addressTextField.text = addressTextField.text
            }
        }
        
    }
   
}










