//
//  BluetoothManagerProtocol.swift
//  SwiftESP32
//
//  Created by yuval tal on 19/09/2018.
//  Copyright © 2018 yuval tal. All rights reserved.
//

import Foundation

protocol BluetoothManagerDelegate{
    func DeviceDidDiscoverd(deviceName: String, deviceIdentifier: String)
}
