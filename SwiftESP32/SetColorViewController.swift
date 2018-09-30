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
    var bluetoothManager: BluetoothManager?
    
    override func viewDidLoad() {
    }
    
    @IBAction func SliderValueChanged(_ sender: Any) {
        SetColorView.backgroundColor = UIColor(red: CGFloat(RedSlider!.value),
                                               green: CGFloat(GreenSlider!.value),
                                               blue: CGFloat(BlueSlider!.value),
                                               alpha: 1)
    }

    @IBAction func SliderValueChangeEnded(_ sender: Any) {
        let data: String = "\( Int(256 * RedSlider!.value)),\( Int(256 * GreenSlider!.value)),\( Int(256 * BlueSlider!.value))"
        bluetoothManager?.SetBleValue(value: data, peripheralID: (DeviceModel?.DeviceIdentifier)!)
    }
}
