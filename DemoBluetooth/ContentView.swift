//
//  ContentView.swift
//  DemoBluetooth
//
//  Created by exe-macm1 on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PeripheralView()
                .tabItem {
                    Image(systemName: "devices.fill")
                    Text("Peripheral")
                }
            CentralView()
                .tabItem {
                    Image(systemName: "important_devices.fill")
                    Text("Central")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
