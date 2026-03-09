//
//  ESP32MeasurementsApp.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI

@main
struct ESP32MeasurementsApp: App {
    // MARK: - State
    @StateObject private var deviceIdState = DeviceIdState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if deviceIdState.deviceId == nil {
                    InputDeviceIdView()
                        .environmentObject(deviceIdState)
                } else {
                    let viewModel = MainDashboardViewModel()
                    MainDashboardView(viewModel: viewModel)
                        .environmentObject(deviceIdState)
                }
            }
        }
    }
}
