//
//  PeripheralViewController.swift
//  DemoBluetooth
//
//  Created by exe-macm1 on 15/06/2023.
//

import CoreBluetooth
import L2Cap

class PeripheralViewController: ObservableObject {
    
    @Published var outputLabel = ""
    
    private var peripheral: L2CapPeripheral!
    private var connection: L2CapConnection?
    
    init(connection: L2CapConnection? = nil) {
        self.peripheral = L2CapPeripheral(connectionHandler: { (connection) in
            self.connection = connection
            self.connection?.receiveCallback = { (connection, data) in
                DispatchQueue.main.async {
                    self.bytesReceived += data.count
                    if let str = String(data: data, encoding: .utf8) {
                        self.outputLabel = str
                    }
                }
            }
        })
        self.bytesReceived = 0
    }
    
    private var bytesReceived = 0
    
    func subscribeSwitch(isOn: Bool) {
        print("publish \(isOn)")
        self.peripheral.publish = isOn
//        self.peripheral.publishChannel = isOn
    }
    
//    @IBAction func publishSwitched(_ sender: UISwitch) {
//        self.peripheral.publishChannel = sender.isOn
//    }
}
