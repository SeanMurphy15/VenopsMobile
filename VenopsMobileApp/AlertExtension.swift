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

    func scanningInstructionAlert(title title: String, message: String, actionTitle: String){

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)


        let image = UIImage(named: "drivers-license-sample")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 0, 100, 100)

        let imageAction = UIAlertAction(title: "", style:.Default, handler: nil)
        imageAction.setValue(imageView, forKey: "image")
        alertViewController.addAction(imageAction)
        presentViewController(alertViewController, animated: true, completion: nil)

    }
}