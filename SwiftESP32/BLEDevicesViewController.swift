//
//  ViewController.swift
//  SwiftESP32
//
//  Created by yuval tal on 18/09/2018.
//  Copyright © 2018 yuval tal. All rights reserved.
//

import UIKit

class BLEDevicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BluetoothManagerDelegate {

    @IBOutlet weak var DeviceListTableView: UITableView!
    
    var Devices: [Int: DeviceModel] = [:]
    var bluetoothManager: BluetoothManager?
    
    var SelectedDevice:DeviceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeviceListTableView.delegate = self
        DeviceListTableView.dataSource = self
        bluetoothManager = BluetoothManager()
        bluetoothManager?.BluetoothManagerDelegate = self
    }
    
    // MARK: - TableVIew
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = Devices[indexPath.row]?.DeviceName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (Devices.keys.contains(indexPath.row)){
            SelectedDevice = Devices[indexPath.row]!
            
            bluetoothManager?.SetBleValue(value: "dgdsfg", peripheralID: (SelectedDevice?.DeviceIdentifier)!)
            performSegue(withIdentifier: "GoToSetColorSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _setColorViewController:SetColorViewController = segue.destination as! SetColorViewController
        _setColorViewController.DeviceModel = SelectedDevice
        _setColorViewController.bluetoothManager = bluetoothManager
    }
    
    // MARK: - BluetoothManager
    func DeviceDidDiscoverd(deviceName: String, deviceIdentifier: String) {
        let lastIndex: Int = Devices.count-1;
        let deviceModel: DeviceModel = DeviceModel(DeviceName: deviceName, DeviceIdentifier: deviceIdentifier)
        
        if lastIndex < 0{
            Devices[0] = deviceModel
        }
        else{
            Devices[lastIndex+1] = deviceModel
        }
        
        DeviceListTableView.reloadData()
    }
}

