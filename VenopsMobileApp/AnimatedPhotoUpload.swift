//
//  UploadPhotoViewController.swift
//  VenopsMobileApp
//
//  Created by Jay Maloney on 2/4/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class AnimatedPhotoUpload: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet var pinchView: UIPinchGestureRecognizer!
    
    let pinchRec = UIPinchGestureRecognizer()
    
    var circleBounds:[CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPhotoBoundsCircleWithAnimation()
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    
    func pinchedView(sender:UIPinchGestureRecognizer){
        self.view.bringSubviewToFront(currentImage)
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1.0
    }

    
    
    @IBAction func chooseTapped(sender: AnyObject) {
        print("choose photo tapped")
    }
    
    @IBAction func userTappedView(sender: AnyObject) {
        //MARK: - IMAGE PICKER FUNCTIONALITY
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // Selection Alert
        let avatarAlert = UIAlertController(title: "Select photo location", message: nil, preferredStyle: .ActionSheet)
        
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
    
    // MARK: UIImagePickerController Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        if let myImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let circleImage = circle(myImage)
            self.currentImage.image = circleImage
        }
    }
    

    
    func createPhotoBoundsCircleWithAnimation() {
        let radius = 75.0
        
        // Create the circle layer
        let circle = CAShapeLayer()
        
        // Set the center of the circle to be the center of the view
        let center = CGPointMake(CGRectGetMidX(self.view.frame) - (CGFloat(radius) - 75), CGRectGetMidY(self.view.frame) - CGFloat(radius))
        
        let label = UILabel(frame: CGRectMake(0, 0, 120, 20))
        label.center = CGPointMake(CGRectGetMidX(self.view.frame) - (CGFloat(radius) - 75), CGRectGetMidY(self.view.frame) - CGFloat(radius))
        
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(16.0)
        label.text = "Upload Photo!"
        label.alpha = 0.5
        
        
        let fractionOfCircle = 3.0 / 4.0
        
        let twoPi = 2.0 * Double(M_PI)
        // The starting angle is given by the fraction of the circle that the point is at, divided by 2 * Pi and less
        // We subtract M_PI_2 to rotate the circle 90 degrees to make it more intuitive (i.e. like a clock face with zero at the top, 1/4 at RHS, 1/2 at bottom, etc.)
        let startAngle = Double(fractionOfCircle) / Double(twoPi) - Double(M_PI_2)
        let endAngle = 0.0 - (Double(M_PI_2))
        let clockwise: Bool = true
        
        // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
        circle.path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).CGPath
        
        // Configure the circle
        let fill = colorWithHexString("2A969F")
        circle.fillColor = fill.CGColor
        circle.strokeColor = UIColor.blueColor().CGColor
        circle.lineWidth = 10
        
        // When it gets to the end of its animation, leave it at 0% stroke filled
        circle.strokeEnd = 1.0
        // Add the circle to the parent layer
        self.view.layer.addSublayer(circle)
        
        // Configure the animation
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.repeatCount = 1.0
        
        // Animate from the full stroke being drawn to none of the stroke being drawn
        drawAnimation.fromValue = NSNumber(double: fractionOfCircle)
        drawAnimation.toValue = NSNumber(float: 0.0)
        
        drawAnimation.duration = 0.4
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Add the animation to the circle
        circle.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        
        let tapRecogniser = UITapGestureRecognizer(target: self, action: "userTappedView:")
        self.view.addGestureRecognizer(tapRecogniser)
        
        let pinchRec = UIPinchGestureRecognizer(target: self, action: "pinchedView:")
        self.currentImage.addGestureRecognizer(pinchRec)
        currentImage.userInteractionEnabled = true
        currentImage.multipleTouchEnabled = true
        
        circleBounds = [CGFloat((radius*2.0)),CGFloat((radius*2.0))]
        
        self.view.addSubview(label)
    }
    
    
    
    func circle(image:UIImage) -> UIImage {
        
        let square = CGSize(width: circleBounds[0], height: circleBounds[1])

        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .ScaleAspectFill
        imageView.image = image
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        imageView.layer.renderInContext(context!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result

        
    }
    
    // MARK: UI Helpers
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }


}


    



