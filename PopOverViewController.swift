//
//  PopOverViewController.swift
//  VenopsMobileApp
//
//  Created by Sean Murphy on 2/1/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    @IBOutlet weak var scanAnimiationView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        animateScan()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateScan(){

        scanAnimiationView.animationImages = [
            UIImage(named: "scan1")!,
            UIImage(named: "scan2")!,
            UIImage(named: "scan3")!,
            UIImage(named: "scan4")!,
            UIImage(named: "scan5")!,
            UIImage(named: "scan6")!,
            UIImage(named: "scan7")!,
            UIImage(named: "scan8")!,
            UIImage(named: "scan9")!,
            UIImage(named: "scan10")!,
            UIImage(named: "scan11")!,
            UIImage(named: "scan12")!,
            UIImage(named: "scan13")!,
            UIImage(named: "scan14")!,
            UIImage(named: "scan15")!,
            UIImage(named: "scan16")!,
            UIImage(named: "scan17")!,
            UIImage(named: "scan18")!,
            UIImage(named: "scan19")!,
            UIImage(named: "scan20")!,
            UIImage(named: "scan21")!,
            UIImage(named: "scan22")!,
            UIImage(named: "scan23")!,
            UIImage(named: "scan24")!,
            UIImage(named: "scan25")!,
            UIImage(named: "scan26")!,
            UIImage(named: "scan27")!,
            UIImage(named: "scan28")!,
            UIImage(named: "scan29")!,
            UIImage(named: "scan30")!,
            UIImage(named: "scan31")!,
            UIImage(named: "scan32")!,
            UIImage(named: "scan33")!,
            UIImage(named: "scan34")!,
            UIImage(named: "scan35")!,
            UIImage(named: "scan36")!,
            UIImage(named: "scan37")!,
            UIImage(named: "scan38")!,
            UIImage(named: "scan39")!,
            UIImage(named: "scan40")!,
            UIImage(named: "scan41")!,
            UIImage(named: "scan42")!,
            UIImage(named: "scan43")!,
            UIImage(named: "scan44")!,
            UIImage(named: "scan45")!,
            UIImage(named: "scan46")!,
            UIImage(named: "scan47")!,
            UIImage(named: "scan48")!,
            UIImage(named: "scan49")!,
            UIImage(named: "scan50")!,
            UIImage(named: "scan51")!,
            UIImage(named: "scan52")!,
            UIImage(named: "scan53")!,
            UIImage(named: "scan54")!,
            UIImage(named: "scan55")!

        ]

        scanAnimiationView.animationDuration = 1.25
        scanAnimiationView.animationRepeatCount = 0
        scanAnimiationView.startAnimating()
    }

    

}
