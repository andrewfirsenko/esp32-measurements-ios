//
//  InputDeviceIdView.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.03.2026.
//

import SwiftUI

struct InputDeviceIdView: View {
    // MARK: - Constants
    private enum Constants {
        static let largeSpacing: CGFloat = 24
        static let smallSpacing: CGFloat = 8
    }
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: Constants.largeSpacing) {
            VStack(spacing: Constants.smallSpacing) {
                Text("")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Он будет использован для идентификации устройства")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    InputDeviceIdView()
}
