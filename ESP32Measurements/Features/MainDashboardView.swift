//
//  MainDashboardView.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI

struct MainDashboardView: View {
    // MARK: - Private Properties
    @StateObject var viewModel: MainDashboardViewModel
    
    // MARK: - UI
    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text("Ошибка: \(errorMessage)")
                    .foregroundStyle(.red)
            }
            Section {
                Text("Последние полученные показания для \"\(MainDashboardViewModel.PublicConstants.deviceId)\":")
                Text("date: \(viewModel.dateText)")
                Text("temperature: \(viewModel.temperatureText)")
                Text("humidity: \(viewModel.humidityText)")
                Text("pressure: \(viewModel.pressureText)")
            }
            .foregroundStyle(viewModel.errorMessage == nil ? .black : .gray)
            Spacer()
        }
        .background(.white)
        .onAppear {
            viewModel.startPolling()
        }
    }
}

// MARK: - Preview
#Preview {
    MainDashboardView(
        viewModel: MainDashboardViewModel(
            esp32MeasurementsService: ESP32MeasurementsService()
        )
    )
}
