//
//  User.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/30/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import Firebase

class User: Equatable, FirebaseType{

    private let emailKey = "email"
    private let firstNameKey = "firstName"
    private let middleNameKey = "middleName"
    private let lastNameKey = "lastName"
    private let usernameKey = "username"
    private let dateOfBirthKey = "dateOfBirth"
    private let cityKey = "city"
    private let stateKey = "state"
    private let zipcodeKey = "zipcode"
    private let licenseNumberKey = "licenseNumber"

    var email = ""
    var firstName: String?
//    var middleName: String?
    var lastName: String?
    var username: String?
    var dateOfBirth: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var licenseNumber: String?
    var identifier: String?
    var endpoint: String {
        return "users"
    }
    var jsonValue: [String: AnyObject] {

        var json: [String: AnyObject] = [emailKey: email]

        if let firstName = firstName {
            json.updateValue(firstName, forKey: firstNameKey)
        }
//        if let middleName = middleName {
//            json.updateValue(middleName, forKey: middleNameKey)
//        }
        if let lastName = lastName {
            json.updateValue(lastName, forKey: lastNameKey)
        }
        if let username = username {
            json.updateValue(username, forKey: usernameKey)
        }
        if let dateOfBirth = dateOfBirth {
            json.updateValue(dateOfBirth, forKey: dateOfBirthKey)
        }
        if let city = city {
            json.updateValue(city, forKey: cityKey)
        }
        if let state = state {
            json.updateValue(state, forKey: stateKey)
        }
        if let zipcode = zipcode {
            json.updateValue(zipcode, forKey: zipcodeKey)
        }
        if let licenseNumber = licenseNumber {
            json.updateValue(licenseNumber, forKey: licenseNumberKey)
        }

        return json
    }

    required init?(json: [String: AnyObject], identifier: String) {

        guard let email = json[emailKey] as? String else { return nil }

        self.email = email
        self.firstName = json[firstNameKey] as? String
//        self.middleName = json[middleNameKey] as? String
        self.lastName = json[lastNameKey] as? String
        self.username = json[usernameKey] as? String
        self.dateOfBirth = json[dateOfBirthKey] as? String
        self.city = json[cityKey] as? String
        self.state = json[stateKey] as? String
        self.zipcode = json[zipcodeKey] as? String
        self.licenseNumber = json[licenseNumberKey] as? String
        self.identifier = identifier
    }


    init(email: String, uid: String, firstName: String?, lastName: String?, username: String?, dateOfBirth: String?, city: String?, state: String?, zipcode: String?, licenseNumber: String?) {

        self.email = email
        self.firstName = firstName
//        self.middleName = middleName
        self.lastName = lastName
        self.username = username
        self.dateOfBirth = dateOfBirth
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.licenseNumber = licenseNumber
        self.identifier = uid
    }
}

func ==(lhs: User, rhs: User) -> Bool {

    return (lhs.email == rhs.email) && (lhs.identifier == rhs.identifier)
}