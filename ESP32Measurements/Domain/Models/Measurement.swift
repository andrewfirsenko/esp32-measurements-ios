//
//  Measurement.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import Foundation

struct Measurement: Codable {
    let date: Double
    let temperature: Double?
    let humidity: Double?
    let pressure: Int?
}
