//
//  ProfilePhotoUploadViewController.swift
//  VenopsMobileApp
//
//  Created by Jay Maloney on 2/5/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class ProfilePhotoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: OUTLETS
    @IBOutlet weak var photoImage: UIImageView!
    
    
    // MARK: ACTIONS
    @IBAction func addPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // Selection Alert
        let avatarAlert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
        
        // Library Picker
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            avatarAlert.addAction(UIAlertAction(title: "Library", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        // Camera
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            avatarAlert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        avatarAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.presentViewController(avatarAlert, animated: true, completion: nil)
        })
    }
    
    @IBAction func skipTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("skipPhoto", sender: nil)
        
    }
    

    // MARK: UIImagePickerController Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        if let myImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.photoImage.image = myImage
            if let userID = UserController.sharedController.currentUser.identifier {
                ImageController.saveProfileImage(identifier: userID, image: myImage, completion: { (success) -> Void in
                    if success {
                        self.performSegueWithIdentifier("skipPhoto", sender: nil)
                    }
                })
            }
            ImageController.saveSelectedProfileImage(myImage)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
