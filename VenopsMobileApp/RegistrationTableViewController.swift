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

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var addressTextField: UITextField!

    @IBOutlet weak var cityTextField: UITextField!

    @IBOutlet weak var stateTextField: UITextField!

    @IBOutlet weak var zipcodeTextField: UITextField!




    override func viewDidLoad() {


    }

    override func viewDidAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func scanIDButtonTapped(sender: AnyObject) {

        performSegueWithIdentifier("toScanner", sender: nil)
    }

    @IBAction func registerButtonTapped(sender: AnyObject) {

        performSegueWithIdentifier("toRegisterConfirmationViewController", sender: nil)
    }
   
}










