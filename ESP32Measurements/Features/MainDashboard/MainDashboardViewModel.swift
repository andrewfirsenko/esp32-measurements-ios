//
//  MainDashboardViewModel.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI
import Combine

final class MainDashboardViewModel: ObservableObject {
    // MARK: - Nested Types
    enum ScreenState {
        case loading
        case error
        case content
    }
    
    // MARK: - Constants
    private enum Constants {
        static let pollingTimeout: TimeInterval = 5.0
        static let chartBreakTime: TimeInterval = 60 * 60
        static let tempratureUnit = "°C"
        static let pressureUnit = "hPa"
        static let humidityUnit = "%"
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
    init(esp32MeasurementsService: any ESP32MeasurementsServiceLogic) {
        self.esp32MeasurementsService = esp32MeasurementsService
        self.deviceIdState = DeviceIdState.shared
        
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
            title: Strings.Localizable.MainDashboard.temperature24Hours,
            unit: Constants.tempratureUnit,
            color: .red
        )
        self.pressureChart = SensorChartViewModel(
            title: Strings.Localizable.MainDashboard.pressure24Hours,
            unit: Constants.pressureUnit,
            color: .green
        )
        self.humidityChart = SensorChartViewModel(
            title: Strings.Localizable.MainDashboard.humidity24Hours,
            unit: Constants.humidityUnit,
            color: .blue
        )
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        timerCancellable?.cancel()
    }
    
    // MARK: - Public Methods
    func startTask() async {
        debugPrint("log: startTask")
        await fetchLast24HoursMeasurements()
    }
}

// MARK: - Private Methods
private extension MainDashboardViewModel {
    func fetchLast24HoursMeasurements() async {
        guard let deviceId = deviceIdState.deviceId else {
            state = .error
            return
        }
        
        let toDate = Date()
        let fromDate = Date(timeInterval: -1 * 60 * 60 * 24, since: toDate)
        
        do {
            let measurements = try await esp32MeasurementsService.measurements(
                deviceId: deviceId,
                fromDate: fromDate,
                toDate: toDate
            )
            debugPrint("log: 🟢 \(measurements.count)")
        } catch {
            debugPrint("log: 🔴 \(error)")
        }
    }
}
