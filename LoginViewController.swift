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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginButtonTapped(sender: AnyObject) {

        if emailTextField.text != "" && passwordTextField.text != "" {

            UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                if success == true {

                    self.performSegueWithIdentifier("toUserProfileFromSuccessfulLogin", sender: nil)

                } else {

                    print("error authentication user")
                }
            })

        } else {

            print("Create an Alert for incomplete fields")
        }
    }

    @IBAction func forgotPasswordButtonTapped(sender: AnyObject) {

        if emailTextField.text != "" {

            UserController.sendPasswordResetEmail(emailTextField.text!, completion: { (success, error) -> Void in

                if (error != nil) {

                    print("Create alert for error")

                } else {
                    
                    print("Create alert for succesfully sent email")
                }
            })
        }
    }
}


















