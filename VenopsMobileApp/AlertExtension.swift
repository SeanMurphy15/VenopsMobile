//
//  AlertExtension.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 2/1/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import UIKit

extension ScannerViewController{

    func generalAlert(title title: String, message: String, actionTitle: String){

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
        alertViewController.addAction(alertAction)
        presentViewController(alertViewController, animated: true, completion: nil)
    }

   
}

extension RegistrationConfirmationTableViewController{

    func generalAlert(title title: String, message: String, actionTitle: String){

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
        alertViewController.addAction(alertAction)
        presentViewController(alertViewController, animated: true, completion: nil)
    }
}