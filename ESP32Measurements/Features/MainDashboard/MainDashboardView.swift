//
//  MainDashboardView.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI

struct MainDashboardView: View {
    // MARK: - Public Properties
    @StateObject var viewModel: MainDashboardViewModel
    @State var deviceId: String = ""
    
    // MARK: - UI
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Current Values
                HStack(spacing: 12) {
                    SensorValueView(viewModel: viewModel.temperatureValue)
                    SensorValueView(viewModel: viewModel.pressureValue)
                    SensorValueView(viewModel: viewModel.humidityValue)
                }
                
                // Charts
                SensorChartView(viewModel: viewModel.temperatureChart)
                SensorChartView(viewModel: viewModel.humidityChart)
                SensorChartView(viewModel: viewModel.pressureChart)
            }
            .padding()
            .navigationTitle("ESP32 Readings")
        }
        .scrollIndicators(.never)
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

// MARK: - Preview
#Preview {
    let mock = MainDashboardViewModel()
    MainDashboardView(viewModel: mock)
}
