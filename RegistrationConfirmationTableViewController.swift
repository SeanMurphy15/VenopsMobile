//
//  RegistrationConfirmationTableViewController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/27/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit
import Firebase

class RegistrationConfirmationTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - BUTTONS

    @IBAction func addProfileImageButtonTapped(sender: AnyObject) {

        uploadImageFromCameraSource()
    }

    @IBAction func confirmButtonTapped(sender: AnyObject) {

        if usernameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" && addressTextField.text != "" && cityTextField.text != "" && stateTextField.text != "" && zipcodeTextField.text != "" {

            let firstName = UserController.publishUserDataFromNSUserDefaults("firstName")
            let lastName = UserController.publishUserDataFromNSUserDefaults("lastName")
            let middleName = UserController.publishUserDataFromNSUserDefaults("middleName")
            let dateOfBirth = UserController.publishUserDataFromNSUserDefaults("dateOfBirth")
            let licenseNumber = UserController.publishUserDataFromNSUserDefaults("licenseNumber")

            UserController.createUser(emailTextField.text!, password: passwordTextField.text!, firstName: firstName, middleName: middleName, lastName: lastName, username: usernameTextField.text!, dateOfBirth: dateOfBirth, city: cityTextField.text!, state: stateTextField.text!, zipcode: zipcodeTextField.text, licenseNumber: licenseNumber, completion: { (success, user, error) -> Void in

                if success {

                    if let profileImage = self.profileImageView.image {

                        if let identifier = UserController.sharedController.currentUser.identifier {

                        ImageController.saveProfileImage(identifier: identifier, image: profileImage, completion: { (success) -> Void in

                            if success {
                                print("Profile image saved successfully")

                            } else {

                                print("Unable to save image")
                            }
                        })

                        } else {

                            print("user identifier was nil")
                        }
                    } else {

                        print("no profile image")
                    }
                } else {

                    self.generalAlert(title: "Error", message: "\(error?.localizedDescription)", actionTitle: "OK")
                }
            })

        } else {

            generalAlert(title: "Incomplete Submission", message: "All fields must be filled in to continue!", actionTitle: "Ok")
        }

       
    }

    //MARK: - IMAGE PICKER FUNCTIONS AND PERSISTANCE

    func uploadImageFromCameraSource(){

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)

    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {

        profileImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
