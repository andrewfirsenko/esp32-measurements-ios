//
//  LastMeasurementResponse.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import Foundation

/// Ответ на `/get_last_measurement`
struct LastMeasurementResponse: Decodable {
    let date: Double
    let temperature: Double?
    let humidity: Double?
    let pressure: Int?
}
