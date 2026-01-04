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
    func lastMeasurement(deviceId: String) -> AnyPublisher<LastMeasurementResponse, any Error>
}

final class ESP32MeasurementsService: ESP32MeasurementsServiceLogic {
    // MARK: - Nested Types
    private enum Constants {
        static let lastMeasurementUrl: String = "http://5.129.225.167:8080/last-measurement/"
    }
    
    // MARK: - Public Methods
    func lastMeasurement(deviceId: String) -> AnyPublisher<LastMeasurementResponse, any Error> {
        guard let url = URL(string: Constants.lastMeasurementUrl + deviceId) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(
                type: LastMeasurementResponse.self,
                decoder: JSONDecoder()
            )
            .eraseToAnyPublisher()
    }
}
