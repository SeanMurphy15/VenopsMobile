//
//  ScannerViewController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 1/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit
import Firebase
import AudioToolbox

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var popOutView: UIView!
    @IBOutlet weak var scanInstructionButton: UIBarButtonItem!
    

    let session         : AVCaptureSession = AVCaptureSession()
    var previewLayer    : AVCaptureVideoPreviewLayer!
    var userData: [String:String] = [:]



    override func viewDidAppear(animated: Bool) {

        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let error : NSError? = nil
        var input: AVCaptureDeviceInput = AVCaptureDeviceInput()
        do {
            input = try  AVCaptureDeviceInput(device: device) as AVCaptureDeviceInput
        } catch let myJSONError {
            print(myJSONError)
        }
        if input !=  AVCaptureDeviceInput() {
            session.addInput(input)
        }
        else {
            self.generalAlert(title: "Error", message: "\(error?.localizedDescription)", actionTitle: "Confirm")
        }

        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = scannerView.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        scannerView.layer.addSublayer(previewLayer)
        session.startRunning()
    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {

        ScanController.scanData(metadataObjects) { (success, userData) -> Void in

            if success {

                self.userData = userData
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.session.stopRunning()
                self.performSegueWithIdentifier("toRegistrationViewControllerFromScannerViewController", sender: nil)

            } else {

                self.generalAlert(title: "Error", message: "Unable to scan driver's license! Make sure the surface is clean and visible!", actionTitle: "Confirm")
            }
        }


    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {

        dismissViewControllerAnimated(true, completion: nil)
    }


    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRegistrationViewControllerFromScannerViewController" {
            if let registrationTableViewController = segue.destinationViewController as? RegistrationTableViewController {
                _ = registrationTableViewController.view
                registrationTableViewController.usernameTextField.text = UserController.publishUserDataFromNSUserDefaults("username")
                registrationTableViewController.emailTextField.text = UserController.publishUserDataFromNSUserDefaults("email")
                registrationTableViewController.passwordTextField.text = UserController.publishUserDataFromNSUserDefaults("password")
                registrationTableViewController.addressTextField.text = userData["address"]
                registrationTableViewController.zipcodeTextField.text = userData["zipcode"]
                registrationTableViewController.stateTextField.text = userData["state"]
                registrationTableViewController.cityTextField.text = userData["city"]
            }
        }

        //MARK: - POPOVER CONTROLLER

        if segue.identifier == "showPopOver" {
            let popOver = segue.destinationViewController
            let controller = popOver.popoverPresentationController
            popOver.preferredContentSize = CGSizeMake(self.view.frame.width - 75, self.view.frame.height - 300)

            controller?.sourceRect = CGRectMake(200, 100, 0, 0)

            session.stopRunning()
            if controller != nil {
                controller?.delegate = self
            }
        }

    }

    @IBAction func scanInstructionButtonTapped(sender: AnyObject) {

        self.performSegueWithIdentifier("showPopOver", sender: nil)
    }


    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }

    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        session.startRunning()
    }
    
    
}
