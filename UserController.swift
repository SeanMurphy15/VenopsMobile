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

    static func saveUserDataToNSUserDefaults(userData: String?, key: String){

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(userData, forKey: key)
    }

    static func publishUserDataFromNSUserDefaults(key: String) -> String?{

        let defaults = NSUserDefaults.standardUserDefaults()
        if let userData = defaults.valueForKey(key)
        {
            return userData as? String
        }

        return nil
    }

    static func deleteUserDataFromNSUserDefaults(){

        for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
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


    static func verifiedDataForUserCreation(completion:(success: Bool, error: NSError?, verifiedData: [String:String]?) -> Void){

        let error = NSError?()

        var userDataDictionary = [String:String]()

        switch (1 > 0) {
        case UserController.publishUserDataFromNSUserDefaults("username") != nil:
            if let username = UserController.publishUserDataFromNSUserDefaults("username"){
                userDataDictionary["username"] = username
                fallthrough
            } else {
                print("unable to fetch username")
            }
        case UserController.publishUserDataFromNSUserDefaults("licenseNumber") != nil:
            if let licenseNumber = UserController.publishUserDataFromNSUserDefaults("licenseNumber"){
                userDataDictionary["licenseNumber"] = licenseNumber
                fallthrough
            } else {
                print("unable to fetch licenseNumber")
            }
        case UserController.publishUserDataFromNSUserDefaults("dateOfBirth") != nil:
            if let dateOfBirth = UserController.publishUserDataFromNSUserDefaults("dateOfBirth"){
                userDataDictionary["dateOfBirth"] = dateOfBirth
                fallthrough
            } else {
                print("unable to fetch dateOfBirth")
            }
        case UserController.publishUserDataFromNSUserDefaults("email") != nil:
            if let email = UserController.publishUserDataFromNSUserDefaults("email"){
                userDataDictionary["email"] = email
                fallthrough
            } else {
                print("unable to fetch email")
            }
        case UserController.publishUserDataFromNSUserDefaults("password") != nil:
            if let password = UserController.publishUserDataFromNSUserDefaults("password"){
                userDataDictionary["password"] = password
                fallthrough
            } else {
                print("unable to fetch password")
            }
        case UserController.publishUserDataFromNSUserDefaults("firstName") != nil:
            if let firstName = UserController.publishUserDataFromNSUserDefaults("firstName"){
                userDataDictionary["firstName"] = firstName
                fallthrough
            } else {
                print("unable to fetch firstName")
            }
        case UserController.publishUserDataFromNSUserDefaults("lastName") != nil:
            if let lastName = UserController.publishUserDataFromNSUserDefaults("lastName"){
                userDataDictionary["lastName"] = lastName
                fallthrough
            } else {
                print("unable to fetch lastName")
            }
        case UserController.publishUserDataFromNSUserDefaults("address") != nil:
            if let address = UserController.publishUserDataFromNSUserDefaults("address"){
                userDataDictionary["address"] = address
                fallthrough
            } else {
                print("unable to fetch address")
            }
        case UserController.publishUserDataFromNSUserDefaults("city") != nil:
            if let city = UserController.publishUserDataFromNSUserDefaults("city"){
                userDataDictionary["city"] = city
                fallthrough
            } else {
                print("unable to fetch city")
            }
        case UserController.publishUserDataFromNSUserDefaults("state") != nil:
            if let state = UserController.publishUserDataFromNSUserDefaults("state"){
                userDataDictionary["state"] = state
                fallthrough
            } else {
                print("unable to fetch state")
            }
        case UserController.publishUserDataFromNSUserDefaults("zipcode") != nil:
            if let zipcode = UserController.publishUserDataFromNSUserDefaults("zipcode"){
                userDataDictionary["zipcode"] = zipcode
                fallthrough
            } else {
                print("unable to fetch zipcode")
            }

        default:

            completion(success: false, error: error, verifiedData: [:])

            break;
        }

        completion(success: true, error: error, verifiedData: userDataDictionary)
    }
    
    
    
    
    
}


