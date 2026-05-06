//
//  ESP32MeasurementsService.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import Foundation
import Network

protocol ESP32MeasurementsServiceLogic: AnyObject {
    /// Получение последнее измерение от контроллера
    func lastMeasurement(deviceId: String) async throws -> LastMeasurementResponse
    /// Получение измерений от контроллера
    func measurements(
        deviceId: String,
        fromDate: Date,
        toDate: Date
    ) async throws -> [LastMeasurementResponse]
}

final class ESP32MeasurementsService: ESP32MeasurementsServiceLogic {
    
    // Dependencies
    private let apiService: APIServiceLogic
    
    // MARK: - Init
    init(apiService: any APIServiceLogic) {
        self.apiService = apiService
    }
    
    // MARK: - Public Methods
    func lastMeasurement(deviceId: String) async throws -> LastMeasurementResponse {
        let response: LastMeasurementResponse = try await apiService.perform(
            endpoint: ESP32MeasurementsEndpoint.getLastMeasurement(deviceId: deviceId)
        )
        return response
    }
    
    func measurements(deviceId: String, fromDate: Date, toDate: Date) async throws -> [LastMeasurementResponse] {
        let response: [LastMeasurementResponse] = try await apiService.perform(
            endpoint: ESP32MeasurementsEndpoint.getMeasurements(
                deviceId: deviceId,
                dateFrom: fromDate,
                dateTo: toDate
            )
        )
        return response
    }
}
