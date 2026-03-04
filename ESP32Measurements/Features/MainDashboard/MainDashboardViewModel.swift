//
//  MainDashboardViewModel.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI
import Combine

final class MainDashboardViewModel: ObservableObject {
    // MARK: - Public Properties
    // Current Values
    @Published var temperatureValue: SensorValueViewModel
    @Published var humidityValue: SensorValueViewModel
    @Published var pressureValue: SensorValueViewModel
    // Charts
    @Published var temperatureChart: SensorChartViewModel
    @Published var humidityChart: SensorChartViewModel
    @Published var pressureChart: SensorChartViewModel
    
    // MARK: - Private Properties
//    private let esp32MeasurementsService: any ESP32MeasurementsServiceLogic
    
    // MARK: Combine
//    private var cancellables = Set<AnyCancellable>()
//    private var timerCancellable: AnyCancellable?
    
    // MARK: - Init
    init() {
        self.temperatureValue = SensorValueViewModel(
            title: "Температура",
            systemImageName: "thermometer"
        )
        self.humidityValue = SensorValueViewModel(
            title: "Влажность",
            systemImageName: "drop.fill"
        )
        self.pressureValue = SensorValueViewModel(
            title: "Давление",
            systemImageName: "gauge"
        )
        self.temperatureChart = SensorChartViewModel(
            title: "Температура за 24 часа",
            unit: "°C",
            color: .red,
            points: [
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771641189), value: 15),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771651189), value: 20),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771661189), value: 30),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771671189), value: 15),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771681189), value: 20),
            ]
        )
        self.humidityChart = SensorChartViewModel(
            title: "Влажность за 24 часа",
            unit: "%",
            color: .blue,
            points: [
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771641189), value: 15),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771651189), value: 20),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771661189), value: 30),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771671189), value: 15),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771681189), value: 20),
            ]
        )
        self.pressureChart = SensorChartViewModel(
            title: "Давление за 24 часа",
            unit: "hPa",
            color: .green,
            points: [
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771641189), value: 15),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771651189), value: 20),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771661189), value: 30),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771671189), value: 15),
                SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771681189), value: 20),
            ]
        )
    }
//    init(esp32MeasurementsService: any ESP32MeasurementsServiceLogic) {
//        self.esp32MeasurementsService = esp32MeasurementsService
//    }
//    
//    deinit {
//        timerCancellable?.cancel()
//    }
    
    // MARK: - Public Methods
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.temperatureValue.value = "20 °C"
            self.humidityValue.value = "30 %"
            self.pressureValue.value = "1000 hPa"
            
            self.temperatureValue.isLoading = false
            self.humidityValue.isLoading = false
            self.pressureValue.isLoading = false
        }
    }
//    func startPolling() {
//        timerCancellable?.cancel()
//        timerCancellable = Timer.publish(every: 2.0, on: .main, in: .common)
//            .autoconnect()
//            .sink { [weak self] _ in
//                self?.fetchLastMeasurement()
//            }
//    }
}

// MARK: - Private Methods
private extension MainDashboardViewModel {
//    func fetchLastMeasurement() {
//        esp32MeasurementsService.lastMeasurement(deviceId: PublicConstants.deviceId)
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveCompletion: { [weak self] completion in
//                    guard let self else { return }
//                    
//                    switch completion {
//                    case .finished:
//                        self.errorMessage = nil
//                    case let .failure(error):
//                        self.errorMessage = error.localizedDescription
//                    }
//                },
//                receiveValue: { [weak self] response in
//                    guard let self else { return }
//                    
//                    self.dateText = "\(response.measurement.date)"
//                    if let temperature = response.measurement.temperature {
//                        self.temperatureText = "\(temperature)"
//                    } else {
//                        self.temperatureText = "Нет данных"
//                    }
//                    if let humidity = response.measurement.humidity {
//                        self.humidityText = "\(humidity)"
//                    } else {
//                        self.humidityText = "Нет данных"
//                    }
//                    if let pressure = response.measurement.pressure {
//                        self.pressureText = "\(pressure)"
//                    } else {
//                        self.pressureText = "Нет данных"
//                    }
//                }
//            )
//            .store(in: &cancellables)
//    }
}
