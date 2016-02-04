//
//  LoginViewController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/31/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func loginButtonTapped(sender: AnyObject) {

        if emailTextField.text != "" && passwordTextField.text != "" {

            UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                if success == true {

                    self.performSegueWithIdentifier("toUserProfileFromSuccessfulLogin", sender: nil)

                } else {

                    self.generalAlert(title: "Error", message: "Unable to authenticate user.", actionTitle: "OK")
                }
            })

        } else {

            self.generalAlert(title: "Incomplete Submission", message: "Make sure all fields are filled in!", actionTitle: "OK")
        }
    }

    @IBAction func forgotPasswordButtonTapped(sender: AnyObject) {

        if emailTextField.text != "" {

            UserController.sendPasswordResetEmail(emailTextField.text!, completion: { (success, error) -> Void in

                if (error != nil) {

                    self.generalAlert(title: "Error", message: "\(error?.localizedDescription)", actionTitle: "OK")

                } else {
                    
                    self.emailSentAlert(self.emailTextField.text, actionTitle: "OK")
                }
            })
        }
    }
}


















