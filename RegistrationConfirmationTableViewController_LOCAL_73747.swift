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
    
    @IBOutlet weak var editCancel: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelEdit: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addProfilePhoto: UIButton!
    @IBOutlet weak var editPhoto: UIButton!
    
    
    
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
    
    
    
    
    
    // MARK: - BUTTONS
    
    @IBAction func editTapped(sender: AnyObject) {
        updateViewForMode(ViewMode.editView)
        
    }
    
    
    @IBAction func editCancelTapped(sender: AnyObject) {
        updateViewForMode(ViewMode.defaultView)
    }
    
    
    @IBAction func addProfileImageButtonTapped(sender: AnyObject) {
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
    
    
    
    // MARK: UI Helpers
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

extension RegistrationConfirmationTableViewController: UITextFieldDelegate {
    // Dismiss TextField
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegistrationConfirmationTableViewController {
    
}
