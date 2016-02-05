//
//  RegistrationConfirmationTableViewController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/27/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit
import Firebase

class RegistrationConfirmationTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var licenseNumberField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelEdit: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addProfilePhoto: UIButton!
    @IBOutlet weak var editPhoto: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        UserController.deleteUserDataFromNSUserDefaults()
    }

    // MARK: - BUTTONS

    @IBAction func editTapped(sender: AnyObject) {
        // updateViewForMode(ViewMode.editView)

    }


    @IBAction func cancelEdit(sender: AnyObject) {
        // updateViewForMode(ViewMode.defaultView)

    }


    @IBAction func addProfileImageButtonTapped(sender: AnyObject) {

        //  uploadImageFromCameraSource()

    }


    @IBAction func confirmButtonTapped(sender: AnyObject) {

        ContentController.collectDataFromTextFields(usernameTextField: usernameTextField.text, licenseNumberField: licenseNumberField.text, dobField: dobField.text, emailField: emailField.text, passwordField: passwordField.text, firstnameField: firstnameField.text, lastnameField: lastnameField.text, addressTextField: addressTextField.text, stateTextField: stateTextField.text, zipcodeTextField: zipcodeTextField.text) { (success, error) -> Void in

            if success {

                UserController.verifiedDataForUserCreation({ (success, error, verifiedData) -> Void in

                    if success {

                        
                        
                    }
                })


            } else {

                self.generalAlert(title: "Error", message: "\(error?.localizedDescription)", actionTitle: "OK")
            }
        }

    }

    //MARK: - IMAGE PICKER FUNCTIONALITY

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

extension RegistrationConfirmationTableViewController: UITextFieldDelegate {

    // Dismiss TextField
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: Shift View on Keyboard Appearance and Removal
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {

            let yCoordinate = self.view.frame.origin.y + keyboardSize.height
            let scrollDestination = CGPointMake(0.0, yCoordinate)
            //            scrollView.setContentOffset(scrollDestination, animated: true)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let yNewCoordinate = self.view.frame.origin.y
        let scrollNewDestination = CGPointMake(0.0, yNewCoordinate)
        //        scrollView.setContentOffset(scrollNewDestination, animated: true)


    }


    
}

