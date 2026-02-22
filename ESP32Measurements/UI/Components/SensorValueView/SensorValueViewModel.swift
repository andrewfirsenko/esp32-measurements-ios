//
//  SensorValueViewModel.swift
//  ESP32Measurements
//
//  Created by Andrew on 21.02.2026.
//

import SwiftUI
import Combine

final class SensorValueViewModel: ObservableObject {
    // MARK: - Public Properties
    let title: String
    let systemImageName: String
    @Published var value: String
    @Published var isLoading: Bool
    
    // MARK: - Init
    init(
        title: String,
        systemImageName: String
    ) {
        self.title = title
        self.systemImageName = systemImageName
        self.value = ""
        self.isLoading = true
    }
}
