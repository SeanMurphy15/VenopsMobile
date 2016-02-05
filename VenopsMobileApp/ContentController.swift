//
//  ContentController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 2/4/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class ContentController{

    static  func collectDataFromTextFields(usernameTextField usernameTextField: String?, licenseNumberField: String?, dobField: String?, emailField: String?, passwordField: String? , firstnameField: String?, lastnameField: String?, addressTextField: String?, stateTextField: String?, zipcodeTextField: String? ,completion:(success: Bool, error: NSError?) -> Void ){

        let error = NSError?()

        if usernameTextField != "" && licenseNumberField != "" && dobField != "" && emailField != "" && passwordField != "" && firstnameField != "" && lastnameField != "" && addressTextField != "" && stateTextField != "" && zipcodeTextField != "" {

            UserController.saveUserDataToNSUserDefaults(usernameTextField, key: "username")
            UserController.saveUserDataToNSUserDefaults(licenseNumberField, key: "licenseNumber")
            UserController.saveUserDataToNSUserDefaults(dobField, key: "dateOfBirth")
            UserController.saveUserDataToNSUserDefaults(emailField, key: "email")
            UserController.saveUserDataToNSUserDefaults(passwordField, key: "password")
            UserController.saveUserDataToNSUserDefaults(firstnameField, key: "firstName")
            UserController.saveUserDataToNSUserDefaults(lastnameField, key: "lastName")
            UserController.saveUserDataToNSUserDefaults(addressTextField, key: "address")
            UserController.saveUserDataToNSUserDefaults(stateTextField, key: "city")
            UserController.saveUserDataToNSUserDefaults(zipcodeTextField, key: "zipcode")

            completion(success: true, error: nil)

        }
        else{
            
            completion(success: false, error: error)
        }
        
        
        
    }

}