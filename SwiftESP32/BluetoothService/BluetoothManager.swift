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
    
    func SetBleValue(value: String, peripheralID: String){
        
        let peripheral = devicePeripherals.first(where: { $0.identifier.uuidString == peripheralID})
        
        if (peripheral == nil){
            print("SetBleValue peripheral is nil")
            return
        }
        
        let service = peripheral?.services?.first(where: {$0.uuid.uuidString == SERVICE_UUID.uuidString})
        
        if let charactericsArr = service?.characteristics
        {
            for charactericsx in charactericsArr
            {
                peripheral?.setNotifyValue(true, for: charactericsx)
                
                if charactericsx.uuid.uuidString == CHARACTERISTIC_UUID.uuidString{
                    let data: NSData = value.data(using: String.Encoding.utf8)! as NSData
                    peripheral?.writeValue(data as Data, for: charactericsx, type: CBCharacteristicWriteType.withResponse)
                }
            }
        }
    }
    
    
    // MARK: - Central Manager
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if centralManager?.state == .poweredOn{
            centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let periphName = peripheral.name ?? peripheral.identifier.uuidString
        
        if !deviceList.contains(periphName){
            if !deviceList.contains(periphName){
                devicePeripherals.append(peripheral)
                peripheral.delegate = self
                centralManager?.connect(peripheral)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral.state == .connected{
            peripheral.discoverServices(nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print("willRestoreState")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        let periphName = peripheral.name ?? peripheral.identifier.uuidString
        
        if error == nil{
            for service in peripheral.services!{
                if service.uuid.uuidString.lowercased() == SERVICE_UUID.uuidString.lowercased() && !deviceList.contains(periphName){
                    deviceList.append(periphName)
                    peripheral.discoverCharacteristics([CBUUID(nsuuid: CHARACTERISTIC_UUID)], for: service)
                    BluetoothManagerDelegate?.DeviceDidDiscoverd(deviceName: periphName, deviceIdentifier: peripheral.identifier.uuidString)
                }
            }
        }
        
//        if peripheral.state == .connected{
//            centralManager?.cancelPeripheralConnection(peripheral)
//        }
    }
}
