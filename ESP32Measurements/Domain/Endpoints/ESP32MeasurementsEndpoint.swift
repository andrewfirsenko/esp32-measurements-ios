//
//  ESP32MeasurementsEndpoint.swift
//  ESP32Measurements
//
//  Created by Andrew on 27.03.2026.
//

import Foundation
import Network

enum ESP32MeasurementsEndpoint: Endpoint {
    // MARK: - Constants
    private enum Constants {
        static let deviceId = "deviceId"
        static let dateFrom = "date_from"
        static let dateTo = "date_to"
    }
    
    // MARK: - Cases
    /// Получить последнее показание `/get_last_measurement`
    case getLastMeasurement(deviceId: String)
    /// Получить показания `/get_measurements`
    case getMeasurements(
        deviceId: String,
        dateFrom: Date,
        dateTo: Date
    )
    
    // MARK: - Public Properties
    var path: String {
        switch self {
        case .getLastMeasurement:
            return "/get_last_measurement"
        case .getMeasurements:
            return "/get_measurements"
        }
    }
    
    var httpMethod: Network.HttpMethod {
        return .get
    }
    
    var payload: Network.EndpointPayload {
        switch self {
        case let .getLastMeasurement(deviceId):
            return .queryParameters([
                Constants.deviceId: deviceId
            ])
        case let .getMeasurements(deviceId, dateFrom, dateTo):
            return .queryParameters([
                Constants.deviceId: deviceId,
                Constants.dateFrom: dateFrom.timeIntervalSince1970,
                Constants.dateTo: dateTo.timeIntervalSince1970,
            ])
        }
    }
}
