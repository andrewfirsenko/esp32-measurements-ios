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
    
    // MARK: - Scene
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let deviceId = deviceIdState.deviceId, !deviceId.isEmpty {
                    let viewModel = MainDashboardViewModel(
                        esp32MeasurementsService: ESP32MeasurementsService(),
                        deviceIdState: deviceIdState
                    )
                    MainDashboardView(
                        viewModel: viewModel,
                        deviceIdState: deviceIdState
                    )
                } else {
                    InputDeviceIdView(deviceIdState: deviceIdState)
                }
            }
        }
    }
}
