//
//  CentralView.swift
//  DemoBluetooth
//
//  Created by exe-macm1 on 15/06/2023.
//

import SwiftUI
import L2Cap

struct CentralView: View {
    @ObservedObject var central = CentralViewController()
    
    @State private var scan = false
    @State private var inputText = ""
    
    var body: some View {
        VStack {
            Toggle("Scan", isOn: $scan)
                .onChange(of: scan) { newValue in
                    central.switchScan(isOn: newValue)
                }
            
            HStack {
                TextField(text: $inputText) {
                    Text("Input your text")
                }
                Button {
                    central.sendMessage(message: inputText)
                } label: {
                    Text("Send")
                }
            }
            
            HStack {
                Text("Label")
                Text("Byte send: \(central.bytesSent)")
            }
            
        }
    }
}

struct CentralView_Previews: PreviewProvider {
    static var previews: some View {
        CentralView()
    }
}
