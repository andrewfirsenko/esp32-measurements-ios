//
//  ESP32MeasurementsApp.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI

@main
struct ESP32MeasurementsApp: App {
    var body: some Scene {
        WindowGroup {
            let esp32MeasurementsService = ESP32MeasurementsService()
            let viewModel = MainDashboardViewModel(esp32MeasurementsService: esp32MeasurementsService)
            MainDashboardView(viewModel: viewModel)
        }
    }
}
