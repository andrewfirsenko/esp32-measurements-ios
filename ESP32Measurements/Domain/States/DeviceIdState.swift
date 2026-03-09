//
//  DeviceIdState.swift
//  ESP32Measurements
//
//  Created by Andrew on 09.03.2026.
//

import Foundation
import Combine

final class DeviceIdState: ObservableObject {
    // MARK: - Constants
    private enum Constants {
        static let deviceIdKey: String = "deviceIdKey"
    }
    
    // MARK: - Public Properties
    @Published var deviceId: String? {
        didSet {
            UserDefaults.standard.set(
                deviceId?.nilIfEmpty,
                forKey: Constants.deviceIdKey
            )
        }
    }
    
    // MARK: - Init
    init() {
        self.deviceId = UserDefaults.standard.string(forKey: Constants.deviceIdKey)
    }
}

// MARK: - String Extension
private extension String {
    var nilIfEmpty: String? {
        if self.isEmpty {
            return nil
        } else {
            return self
        }
    }
}
