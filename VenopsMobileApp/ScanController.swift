//
//  ScanController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/27/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import UIKit

class ScanController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{



    static func scanData(metadataObjects: [AnyObject], completion:(success: Bool, userData: [String: String])-> Void){

        let barCodeTypes = [AVMetadataObjectTypePDF417Code]

        for metadata in metadataObjects{

            if barCodeTypes.contains(metadata.type){


                let userData = formatScannedData(metadataObjects: metadataObjects)
                completion(success: true, userData: userData)


            }else {
                print("unable to recognize driver's license")
                completion(success: false, userData: [:])
                
            }
        }
        
    }


    static func formatScannedData(metadataObjects metadataObjects: [AnyObject]) -> [String: String]{

        var scanDataDictionary = [String:String]()

        for metadata in metadataObjects {
            if let dataString = (metadata as! AVMetadataMachineReadableCodeObject).stringValue {
                let dataArray = dataString.componentsSeparatedByString("\n")
                    switch (metadataObjects.count > 0) {
                    case dataArray[6] != "DACNONE":
                        let rawFirstName = dataArray.filter({$0.hasPrefix("DAC")}).joinWithSeparator("")
                        let firstName = rawFirstName.stringByReplacingOccurrencesOfString("DAC", withString: "")
                        scanDataDictionary["firstName"] = firstName
                        UserController.saveUserDataToNSUserDefaults(firstName, key: "firstName")
                        fallthrough
                    case dataArray[7] != "DADNONE":
                        let rawMiddleName = dataArray.filter({$0.hasPrefix("DAD")}).joinWithSeparator("")
                        let middleName = rawMiddleName.stringByReplacingOccurrencesOfString("DAD", withString: "")
                        scanDataDictionary["middleName"] = middleName
                        UserController.saveUserDataToNSUserDefaults(middleName, key: "middleName")
                        fallthrough
                    case dataArray[5] != "DCSNONE":
                        let rawLastName = dataArray.filter({$0.hasPrefix("DCS")}).joinWithSeparator("")
                        let lastName = rawLastName.stringByReplacingOccurrencesOfString("DCS", withString: "")
                        scanDataDictionary["lastName"] = lastName
                        UserController.saveUserDataToNSUserDefaults(lastName, key: "lastName")
                        fallthrough
                    case dataArray[9] != "DBBNONE":
                        let rawDateOfBirth = dataArray.filter({$0.hasPrefix("DBB")}).joinWithSeparator("")
                        let dateOfBirth = rawDateOfBirth.stringByReplacingOccurrencesOfString("DBB", withString: "")
                        scanDataDictionary["dateOfBirth"] = dateOfBirth
                        UserController.saveUserDataToNSUserDefaults(dateOfBirth, key: "dateOfBirth")
                        fallthrough
                    case dataArray[17] != "DAQNONE":
                        let rawLicenseNumber = dataArray.filter({$0.hasPrefix("DAQ")}).joinWithSeparator("")
                        let licenseNumber = rawLicenseNumber.stringByReplacingOccurrencesOfString("DAQ", withString: "")
                        scanDataDictionary["licenseNumber"] = licenseNumber
                        UserController.saveUserDataToNSUserDefaults(licenseNumber, key: "licenseNumber")
                        fallthrough
                    case dataArray[13] != "DAGNONE":
                        let rawAddress = dataArray.filter({$0.hasPrefix("DAG")}).joinWithSeparator("")
                        let address = rawAddress.stringByReplacingOccurrencesOfString("DAG", withString: "")
                        scanDataDictionary["address"] = address
                        UserController.saveUserDataToNSUserDefaults(address, key: "address")
                        fallthrough
                    case dataArray[14] != "DAINONE":
                        let rawCity = dataArray.filter({$0.hasPrefix("DAI")}).joinWithSeparator("")
                        let city = rawCity.stringByReplacingOccurrencesOfString("DAI", withString: "")
                        scanDataDictionary["city"] = city
                        UserController.saveUserDataToNSUserDefaults(city, key: "city")
                        fallthrough
                    case dataArray[15] != "DAJNONE":
                        let rawState = dataArray.filter({$0.hasPrefix("DAJ")}).joinWithSeparator("")
                        let state = rawState.stringByReplacingOccurrencesOfString("DAJ", withString: "")
                        scanDataDictionary["state"] = state
                        UserController.saveUserDataToNSUserDefaults(state, key: "state")
                        fallthrough
                    case dataArray[16] != "DAKNONE":
                        let rawZipcode = dataArray.filter({$0.hasPrefix("DAK")}).joinWithSeparator("")
                        let zipcode = rawZipcode.stringByReplacingOccurrencesOfString("DAK", withString: "")
                        scanDataDictionary["zipcode"] = zipcode
                        UserController.saveUserDataToNSUserDefaults(zipcode, key: "zipcode")
                        fallthrough

                default:
                    break;
                }
            }
        }

        return scanDataDictionary
    }

}