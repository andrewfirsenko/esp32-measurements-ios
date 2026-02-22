//
//  SensorChartViewModel.swift
//  ESP32Measurements
//
//  Created by Andrew on 21.02.2026.
//

import Combine
import SwiftUI

final class SensorChartViewModel: ObservableObject {
    // MARK: - Nested Types
    struct ChartPoint: Identifiable {
        let id: UUID = UUID()
        let date: Date
        let value: Double
    }
    
    // MARK: - Public Properties
    let title: String
    let unit: String
    let color: Color
    @Published var points: [ChartPoint]
    
    // MARK: - Init
    init(
        title: String,
        unit: String,
        color: Color,
        points: [ChartPoint]
    ) {
        self.title = title
        self.unit = unit
        self.color = color
        self.points = points
    }
}

