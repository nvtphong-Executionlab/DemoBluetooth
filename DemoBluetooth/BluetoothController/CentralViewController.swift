//
//  CentralViewController.swift
//  DemoBluetooth
//
//  Created by exe-macm1 on 15/06/2023.
//

import CoreBluetooth
import L2Cap

class CentralViewController: ObservableObject {
    
    @Published var bytesSent = 0
    @Published var isSendable = false
    @Published var stateLabel = ""
    
    private var peripheral: CBPeripheral?
    private var connection: L2CapConnection?
    private var characteristic: CBCharacteristic?
    
    private var l2capCentral: L2CapCentral!
    
    init() {
        print("init")
        self.bytesSent = 0
        self.l2capCentral = L2CapCentral()
        self.l2capCentral.discoveredPeripheralCallback = { peripheral in
            self.peripheral = peripheral
            self.l2capCentral.connect(peripheral: peripheral) { connection in
                self.connection = connection
                self.connection?.receiveCallback = { (connection,data) in
                    print("Received data")
                }
                self.connection?.sentDataCallback = { (connection, count) in
                    self.bytesSent += count
                }
                DispatchQueue.main.async {
                    self.isSendable = true
                }
            }
        }
        self.l2capCentral.disconnectedPeripheralCallBack = { (connection, error) in
            print("Disconnected \(connection)")
            if let err = error {
                print("With error \(err)")
            }
        }
    }
    
    
    func switchScan(isOn: Bool) {
        print(isOn)
        self.l2capCentral.scan = isOn
    }
    
    func sendMessage(message: String) {
        guard let connection = self.connection else {
            return
        }
        if let text = message.data(using: .utf8) {
            connection.send(data: text)
        }
    }
    
}
    
