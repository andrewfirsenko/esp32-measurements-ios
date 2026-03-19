//
//  MainDashboardViewModel.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI
import Combine

final class MainDashboardViewModel: ObservableObject {
    // MARK: - State
    enum ScreenState {
        case loading
        case error
        case content
    }
    
    // MARK: - Public Properties
    @Published var state: ScreenState
    // Current Values
    @Published var temperatureValue: SensorValueViewModel
    @Published var humidityValue: SensorValueViewModel
    @Published var pressureValue: SensorValueViewModel
    // Charts
    @Published var temperatureChart: SensorChartViewModel
    @Published var humidityChart: SensorChartViewModel
    @Published var pressureChart: SensorChartViewModel
    
    // MARK: - Dependencies
    private let esp32MeasurementsService: any ESP32MeasurementsServiceLogic
    private let deviceIdState: DeviceIdState
    
    // MARK: - Combine
    private var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable?
    
    // MARK: - Init
    init(
        esp32MeasurementsService: any ESP32MeasurementsServiceLogic,
        deviceIdState: DeviceIdState
    ) {
        self.esp32MeasurementsService = esp32MeasurementsService
        self.deviceIdState = deviceIdState
        
        self.state = .loading
        self.temperatureValue = SensorValueViewModel(
            title: Strings.Localizable.MainDashboard.temperature,
            imageResource: .tempratureIcon
        )
        self.humidityValue = SensorValueViewModel(
            title: Strings.Localizable.MainDashboard.humidity,
            imageResource: .humidityIcon
        )
        self.pressureValue = SensorValueViewModel(
            title: Strings.Localizable.MainDashboard.pressure,
            imageResource: .pressureIcon
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
    
    deinit {
        timerCancellable?.cancel()
    }
    
    // MARK: - Public Methods
    func onAppear() {
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 5.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchLastMeasurement()
            }
        fetchLastMeasurement()
    }
    
    func onDisappear() {
        timerCancellable?.cancel()
        state = .loading
    }
}

// MARK: - Private Methods
private extension MainDashboardViewModel {
    func fetchLastMeasurement() {
        guard let deviceId = deviceIdState.deviceId else { return }
        
        esp32MeasurementsService.lastMeasurement(deviceId: deviceId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .finished:
                        state = .content
                    case .failure:
                        state = .error
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    self.displayData(measurement: response)
                }
            )
            .store(in: &cancellables)
    }
    
    func displayData(measurement: Measurement) {
        if let temperature = measurement.temperature {
            temperatureValue.value = "\(temperature) °C"
        } else {
            temperatureValue.value = ""
        }
        
        if let humidity = measurement.humidity {
            humidityValue.value = "\(humidity) %"
        } else {
            humidityValue.value = ""
        }
        
        if let pressure = measurement.pressure {
            pressureValue.value = "\(pressure) hPa"
        } else {
            pressureValue.value = ""
        }
    }
    
    func clearView() {
        temperatureValue.value = ""
        humidityValue.value = ""
        pressureValue.value = ""
    }
}
