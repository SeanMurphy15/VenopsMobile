//
//  Image.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/27/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import Firebase


class ImageController{

    static func saveProfileImage(identifier identifier: String, image: UIImage, completion:(success: Bool) -> Void){

        var base64String: NSString!

        if let ref = Firebase(url: "https://venopsmobile.firebaseio.com/"){

            let uploadImage = resizeImage(image, newWidth: 200)

            if let imageData = UIImagePNGRepresentation(uploadImage) {

                base64String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)

                if let imageRef = ref.childByAppendingPath("images") {

                    let imageString = ["profileImage": base64String]

                    let userImage = [identifier : imageString]

                    imageRef.setValue(userImage)

                    print("successful image upload")

                    completion(success: true)

                }
            }

        } else {

            print("unable to upload image")
            completion(success: false)
        }
    }


    static func downloadProfileImage(identifier identifier: String, completion:(profileImage: UIImage?, success: Bool) -> Void){

        let ref = Firebase(url: "https://venopsmobile.firebaseio.com/images/\(identifier)")

        ref.observeEventType(.Value, withBlock: { snapshot in

            if let imageDictionary = snapshot.value as? [String: String]{

                if let encodedImage = imageDictionary["profileImage"]{

                    if let decodedImage = NSData(base64EncodedString: encodedImage, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters){

                        if let profileImage = UIImage(data: decodedImage){

                            print("successful image download")

                            completion(profileImage: profileImage, success: true)

                        }
                    }
                    
                }
                
            }
            
            }) { (error) -> Void in

                print("unable to download image")
                completion(profileImage: nil, success: false)
        }
        
    }
    
    
    //nsuserDefaults image upload func
    

    static func saveSelectedProfileImage(image: UIImage){

        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(image, forKey: "profileImage")
        
        let imageData : NSData = UIImageJPEGRepresentation(image, (0.7))!
        defaults.setObject(imageData, forKey: "profileImage")

    }

    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

      
            
}