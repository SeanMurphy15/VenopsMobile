//
//  UserController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/26/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class UserController: UIViewController{


    static let sharedController = UserController()



    private let kUser = "userKey"

    var currentUser: User! {
        get {

            guard let uid = FirebaseController.base.authData?.uid else {return nil}

            guard let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String: AnyObject] else {

                return nil
            }

            return User(json: userDictionary, identifier: uid)
        }

        set {

            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }


    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {

        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in

            if let json = data as? [String: AnyObject] {
                let user = User(json: json, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }

    static func fetchAllUsers(completion: (users: [User]) -> Void) {

        FirebaseController.dataAtEndpoint("users") { (data) -> Void in

            if let json = data as? [String: AnyObject] {

                let users = json.flatMap({User(json: $0.1 as! [String : AnyObject], identifier: $0.0)})

                completion(users: users)

            } else {
                completion(users: [])
            }
        }
    }

    static func checkEmail(email: String, completion: (success: Bool) -> Void){

        let ref = Firebase(url: "https://venopsmobile.firebaseio.com/users")

        ref.queryOrderedByChild("email").queryEqualToValue(email).observeEventType(.ChildAdded, withBlock: { snapshot in


            if let userDictionary = snapshot.value as? [String:String] {

                let user = User(json: userDictionary, identifier: snapshot.key)

                if user?.email == email {

                    completion(success: true)

                } else {

                    completion(success: false)
                }
            }
        })
    }

    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {

        FirebaseController.base.authUser(email, password: password) { (error, response) -> Void in

            if error != nil {
                print("Unsuccessful login attempt.")
                completion(success: false, user: nil)
            } else {
                print("User ID: \(response.uid) authenticated successfully.")
                UserController.userForIdentifier(response.uid, completion: { (user) -> Void in

                    if let user = user {
                        sharedController.currentUser = user
                    }

                    completion(success: true, user: user)
                })
            }
        }
    }

    static func createUser(email: String, password: String, firstName: String?, lastName: String?, username: String?, dateOfBirth: String?, city: String?, state: String?, zipcode: String?, licenseNumber: String?, completion: (success: Bool, user: User?, error: NSError?) -> Void) {

        FirebaseController.base.createUser(email, password: password) { (error, response) -> Void in


            if !(error == nil) {
                print(error.localizedDescription)
                completion(success: false, user: nil, error: error)
            } else {
                if let uid = response["uid"] as? String {
                    var user = User(email: email, uid: uid, firstName: firstName, lastName: lastName, username: username, dateOfBirth: dateOfBirth, city: city, state: state, zipcode: zipcode, licenseNumber: licenseNumber)
                    user.save()

                    authenticateUser(email, password: password, completion: { (success, user) -> Void in
                        completion(success: success, user: user, error: nil)
                    })
                } else {
                    completion(success: false, user: nil, error: nil)
                }
            }
        }
    }

    static func changeUserEmail(currentEmail: String, newEmail: String, password: String){

        let ref = Firebase(url: "https://venopsmobile.firebaseio.com")
        ref.changeEmailForUser(currentEmail, password: password,
            toNewEmail: newEmail, withCompletionBlock: { error in
                if error != nil {
                    print("There was an error processing the request")
                } else {
                    print("Email changed successfully")
                }
        })

    }

    static func changeUserPassword(email: String, currentPassword: String, newPassword: String){

        let ref = Firebase(url: "https://venopsmobile.firebaseio.com")
        ref.changePasswordForUser(email, fromOld: currentPassword,
            toNew: newPassword, withCompletionBlock: { error in
                if error != nil {
                    print("There was an error processing the request")
                } else {
                    print("Password changed successfully")
                }
        })

    }

    static func sendPasswordResetEmail(email: String, completion:(success: Bool, error: NSError?) -> Void){

        let ref = Firebase(url: "https://venopsmobile.firebaseio.com")
        ref.resetPasswordForUser(email, withCompletionBlock: { error in
            if error != nil {
                print("There was an error processing the request")
                completion(success: false, error: error)
            } else {
                print("Password reset sent successfully")
                completion(success: true, error: nil)
            }
        })
    }
    
    
    static func logoutCurrentUser() {
        FirebaseController.base.unauth()
        UserController.sharedController.currentUser = nil
        
        
    }
    
    
    
    
    
}


