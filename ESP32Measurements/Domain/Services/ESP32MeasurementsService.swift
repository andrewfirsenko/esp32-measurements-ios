//
//  ESP32MeasurementsService.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import Foundation
import Combine

protocol ESP32MeasurementsServiceLogic: AnyObject {
    /// Получение последних данных от контроллера для переданного `deviceId`
    func lastMeasurement(deviceId: String) -> AnyPublisher<Measurement, any Error>
}

final class ESP32MeasurementsService: ESP32MeasurementsServiceLogic {
    // MARK: - Nested Types
    private enum Constants {
        static let lastMeasurementUrl: String = "https://simoresite.ru/get_last_measurement"
    }
    
    // MARK: - Public Methods
    func lastMeasurement(deviceId: String) -> AnyPublisher<Measurement, any Error> {
        let deviceIdParam = "?deviceId=\(deviceId)"
        guard let url = URL(string: Constants.lastMeasurementUrl + deviceIdParam) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(
                type: Measurement.self,
                decoder: JSONDecoder()
            )
            .eraseToAnyPublisher()
    }
}
