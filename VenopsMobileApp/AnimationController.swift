//
//  AnimationController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 2/4/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import UIKit

class AnimationController {

    static func updateTextFieldViewForMode(textField: UITextField, enabled: Bool, alpha: CGFloat, delegate:  UITextFieldDelegate, textColor: UIColor) {

        textField.userInteractionEnabled = enabled

        textField.delegate = delegate

        textField.textColor = textColor
    }
    
    
}



