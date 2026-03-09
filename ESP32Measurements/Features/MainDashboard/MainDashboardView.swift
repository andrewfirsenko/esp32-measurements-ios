//
//  MainDashboardView.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI

struct MainDashboardView: View {
    // MARK: - Constants
    private enum Constants {
        static let deviceIdInputText = "deviceId:"
        static let deviceIdLineLimit: Int = 1
        static let currentValuesSpacing: CGFloat = 12
        static let mainSpacing: CGFloat = 16
    }
    
    // MARK: - Dependencies
    @StateObject var viewModel: MainDashboardViewModel
    @StateObject var deviceIdState: DeviceIdState
    
    // MARK: - UI
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.mainSpacing) {
                HStack {
                    Text(Constants.deviceIdInputText)
                        .foregroundStyle(.secondary)
                    Text(deviceIdState.deviceId ?? "")
                        .foregroundStyle(.secondary)
                        .lineLimit(Constants.deviceIdLineLimit)
                    Spacer()
                    NavigationLink(Strings.Localizable.MainDashboard.change) {
                        InputDeviceIdView(deviceIdState: deviceIdState)
                    }
                }
                
                // Current Values
                HStack(spacing: Constants.currentValuesSpacing) {
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
            .navigationTitle(Strings.InfoPlist.cfBundleDisplayName)
        }
        .scrollIndicators(.never)
        .onAppear() {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}

// MARK: - Preview
#Preview {
    let mockDeviceIdState = DeviceIdState()
    let mockViewModel = MainDashboardViewModel(
        esp32MeasurementsService: ESP32MeasurementsService(),
        deviceIdState: mockDeviceIdState
    )
    MainDashboardView(
        viewModel: mockViewModel,
        deviceIdState: mockDeviceIdState
    )
}
