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
<<<<<<< HEAD
    
    
=======


>>>>>>> feature/CodeOrganization
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
<<<<<<< HEAD
    
    @IBOutlet weak var editCancel: UIButton!
=======

>>>>>>> feature/CodeOrganization
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelEdit: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addProfilePhoto: UIButton!
    @IBOutlet weak var editPhoto: UIButton!
<<<<<<< HEAD
    
    
    
    var mode:ViewMode = .defaultView
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView ()
    
    
    // MARK: ViewMode Case Declarations
    enum ViewMode {
        case defaultView
        case editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        firstnameField.delegate = self
        lastnameField.delegate = self
        dobField.delegate = self
        licenseNumberField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        addressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipcodeTextField.delegate = self
        
        updateViewForMode(ViewMode.defaultView)
    }
    
    
    // MARK: ViewMode Switch Function
    func updateViewForMode(mode:ViewMode) {
        
        switch mode {
        case .defaultView:
            
            let defaultTextGrey = colorWithHexString("3c3c3c")
            
            confirmButton.enabled = false
            editButton.enabled = true
            editButton.userInteractionEnabled = true
            addProfilePhoto.userInteractionEnabled = false
            usernameTextField.userInteractionEnabled = false
            firstnameField.userInteractionEnabled = false
            lastnameField.userInteractionEnabled = false
            dobField.userInteractionEnabled = false
            licenseNumberField.userInteractionEnabled = false
            emailField.userInteractionEnabled = false
            passwordField.userInteractionEnabled = false
            addressTextField.userInteractionEnabled = false
            cityTextField.userInteractionEnabled = false
            stateTextField.userInteractionEnabled = false
            zipcodeTextField.userInteractionEnabled = false
            
            usernameTextField.textColor = defaultTextGrey
            firstnameField.textColor = defaultTextGrey
            lastnameField.textColor = defaultTextGrey
            dobField.textColor = defaultTextGrey
            licenseNumberField.textColor = defaultTextGrey
            emailField.textColor = defaultTextGrey
            passwordField.textColor = defaultTextGrey
            addressTextField.textColor = defaultTextGrey
            cityTextField.textColor = defaultTextGrey
            stateTextField.textColor = defaultTextGrey
            zipcodeTextField.textColor = defaultTextGrey
            
            profileImageView.alpha = 1.0
            addProfilePhoto.alpha = 1.0
            editButton.alpha = 1.0
            
            editPhoto.userInteractionEnabled = false
            editPhoto.setTitle("", forState: .Normal)
            editPhoto.alpha = 0.0
            
        case .editView:
            confirmButton.enabled = true
            editCancel.enabled = true
            editCancel.userInteractionEnabled = true
            editButton.enabled = false
            editButton.userInteractionEnabled = false
            addProfilePhoto.userInteractionEnabled = true
            usernameTextField.userInteractionEnabled = true
            firstnameField.userInteractionEnabled = true
            lastnameField.userInteractionEnabled = true
            dobField.userInteractionEnabled = true
            licenseNumberField.userInteractionEnabled = true
            emailField.userInteractionEnabled = true
            passwordField.userInteractionEnabled = true
            addressTextField.userInteractionEnabled = true
            cityTextField.userInteractionEnabled = true
            stateTextField.userInteractionEnabled = true
            zipcodeTextField.userInteractionEnabled = true
            
            usernameTextField.textColor = UIColor.blackColor()
            firstnameField.textColor = UIColor.blackColor()
            lastnameField.textColor = UIColor.blackColor()
            dobField.textColor = UIColor.blackColor()
            licenseNumberField.textColor = UIColor.blackColor()
            emailField.textColor = UIColor.blackColor()
            passwordField.textColor = UIColor.blackColor()
            addressTextField.textColor = UIColor.blackColor()
            cityTextField.textColor = UIColor.blackColor()
            stateTextField.textColor = UIColor.blackColor()
            zipcodeTextField.textColor = UIColor.blackColor()
            
            profileImageView.alpha = 0.0
            addProfilePhoto.alpha = 0.0
            editButton.alpha = 0.0
            
            editPhoto.userInteractionEnabled = true
            editPhoto.setTitle("EDIT", forState: .Normal)
            editPhoto.alpha = 1.0
        }
    }
    
    
    
    
    
=======


    override func viewDidLoad() {
        super.viewDidLoad()

        UserController.deleteUserDataFromNSUserDefaults()
    }

>>>>>>> feature/CodeOrganization
    // MARK: - BUTTONS

    @IBAction func editTapped(sender: AnyObject) {
<<<<<<< HEAD
        updateViewForMode(ViewMode.editView)
        
    }
    
    
    @IBAction func editCancelTapped(sender: AnyObject) {
        updateViewForMode(ViewMode.defaultView)
=======
        // updateViewForMode(ViewMode.editView)

    }


    @IBAction func cancelEdit(sender: AnyObject) {
        // updateViewForMode(ViewMode.defaultView)

>>>>>>> feature/CodeOrganization
    }
    
    
    @IBAction func addProfileImageButtonTapped(sender: AnyObject) {
<<<<<<< HEAD
        uploadImageFromCameraSource()
    }
    
    
    @IBAction func confirmButtonTapped(sender: AnyObject) {
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100))
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        self.view.endEditing(true)
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.usernameTextField.resignFirstResponder()
        self.firstnameField.resignFirstResponder()
        self.lastnameField.resignFirstResponder()
        self.dobField.resignFirstResponder()
        self.licenseNumberField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.addressTextField.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
        self.stateTextField.resignFirstResponder()
        self.zipcodeTextField.resignFirstResponder()
        
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    
    
    
=======

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

>>>>>>> feature/CodeOrganization
    //MARK: - IMAGE PICKER FUNCTIONALITY
    
    func uploadImageFromCameraSource(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        ImageController.saveSelectedProfileImage(image)
        
        
        let profileResize = ImageController.resizeImage(image, newWidth: 50.0)
        
        updateViewForMode(ViewMode.defaultView)
        
        profileImageView.image = profileResize
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}

extension RegistrationConfirmationTableViewController: UITextFieldDelegate {
<<<<<<< HEAD
=======

>>>>>>> feature/CodeOrganization
    // Dismiss TextField
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
<<<<<<< HEAD
}

extension RegistrationConfirmationTableViewController {
=======

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


>>>>>>> feature/CodeOrganization
    
}

