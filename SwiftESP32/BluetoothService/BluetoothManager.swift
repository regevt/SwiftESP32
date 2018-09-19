//
//  BluetoothManager.swift
//  SwiftESP32
//
//  Created by yuval tal on 18/09/2018.
//  Copyright © 2018 yuval tal. All rights reserved.
//

import Foundation
import CoreBluetooth

class  BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // MARK: - Properties
    var deviceList: [String] = []
    var devicePeripherals: [CBPeripheral] = []
    var centralManager: CBCentralManager?
    var selectedPeripheral: CBPeripheral?
    var BluetoothManagerDelegate: BluetoothManagerDelegate?
    
    
    // MARK: - Init
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // MARK: - Central Manager
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            central.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let periphName = peripheral.name ?? peripheral.identifier.uuidString
        
        if !deviceList.contains(periphName){
            deviceList.append(periphName)
            devicePeripherals.append(peripheral)
            BluetoothManagerDelegate?.DeviceDidDiscoverd(deviceName: periphName, deviceIdentifier: peripheral.identifier.uuidString)
        }
    }
}
