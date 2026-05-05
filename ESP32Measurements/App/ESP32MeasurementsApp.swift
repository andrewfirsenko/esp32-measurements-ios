//
//  ESP32MeasurementsApp.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI
import Network

@main
struct ESP32MeasurementsApp: App {
    // MARK: - State
    @StateObject private var deviceIdState = DeviceIdState.shared
    
    // MARK: - Scene
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let deviceId = deviceIdState.deviceId, !deviceId.isEmpty {
                    let apiService = APIService()
                    let esp32MeasurementsService = ESP32MeasurementsService(apiService: apiService)
                    let viewModel = MainDashboardViewModel(esp32MeasurementsService: esp32MeasurementsService)
                    MainDashboardView(viewModel: viewModel).environmentObject(deviceIdState)
                } else {
                    InputDeviceIdView().environmentObject(deviceIdState)
                }
            }
        }
    }
}
