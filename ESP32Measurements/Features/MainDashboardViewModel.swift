//
//  MainDashboardViewModel.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import Foundation
import Combine

final class MainDashboardViewModel: ObservableObject {
    // MARK: - Nested Types
    enum PublicConstants {
        static let deviceId = "test_id"
    }
    
    // MARK: - Public Properties
    @Published var dateText: String = "Скоро появится, идет загрузка"
    @Published var temperatureText: String = "..."
    @Published var humidityText: String = "..."
    @Published var pressureText: String = "..."
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let esp32MeasurementsService: any ESP32MeasurementsServiceLogic
    
    // MARK: Combine
    private var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable?
    
    // MARK: - Init
    init(esp32MeasurementsService: any ESP32MeasurementsServiceLogic) {
        self.esp32MeasurementsService = esp32MeasurementsService
    }
    
    deinit {
        timerCancellable?.cancel()
    }
    
    // MARK: - Public Methods
    func startPolling() {
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchLastMeasurement()
            }
    }
}

// MARK: - Private Methods
private extension MainDashboardViewModel {
    func fetchLastMeasurement() {
        esp32MeasurementsService.lastMeasurement(deviceId: PublicConstants.deviceId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    
                    switch completion {
                    case .finished:
                        self.errorMessage = nil
                    case let .failure(error):
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    
                    self.dateText = "\(response.measurement.date)"
                    if let temperature = response.measurement.temperature {
                        self.temperatureText = "\(temperature)"
                    } else {
                        self.temperatureText = "Нет данных"
                    }
                    if let humidity = response.measurement.humidity {
                        self.humidityText = "\(humidity)"
                    } else {
                        self.humidityText = "Нет данных"
                    }
                    if let pressure = response.measurement.pressure {
                        self.pressureText = "\(pressure)"
                    } else {
                        self.pressureText = "Нет данных"
                    }
                }
            )
            .store(in: &cancellables)
    }
}
