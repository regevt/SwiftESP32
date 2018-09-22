//
//  SetColorViewController.swift
//  SwiftESP32
//
//  Created by yuval tal on 22/09/2018.
//  Copyright © 2018 yuval tal. All rights reserved.
//

import Foundation
import UIKit

class SetColorViewController: UIViewController {
    @IBOutlet weak var RedSlider: UISlider!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var BlueSlider: UISlider!
    @IBOutlet var SetColorView: UIView!
    
    var DeviceModel: DeviceModel?
    
    override func viewDidLoad() {
      
    }
    
    @IBAction func SetColorAction(_ sender: Any) {
        
        print(256 * RedSlider!.value)
        print(256 * GreenSlider!.value)
        print(256 * BlueSlider!.value)
    }
    
    @IBAction func SliderValueChanged(_ sender: Any) {
        SetColorView.backgroundColor = UIColor(red: CGFloat(RedSlider!.value),
                                             green: CGFloat(GreenSlider!.value),
                                             blue: CGFloat(BlueSlider!.value),
                                             alpha: 1)
    }
}
