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
        static let deviceIdPlaceholder = "0A:1B:2C:3D:4E:5F"
    }
    
    // MARK: - Private Properties
    @State private var deviceId: String = ""
    private let onNext: () -> Void
    
    // MARK: - Init
    init(
        deviceId: String,
        onNext: @escaping () -> Void
    ) {
        self.deviceId = deviceId
        self.onNext = onNext
    }
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: Constants.largeSpacing) {
            Spacer()
            
            VStack(spacing: Constants.smallSpacing) {
                Text(Strings.Localizable.InputDeviceId.title)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(Strings.Localizable.InputDeviceId.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
            
            TextField(Constants.deviceIdPlaceholder, text: $deviceId)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2))
                )
                .padding(.horizontal)
            
            Button(action: onNext) {
                Text(Strings.Localizable.InputDeviceId.button)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(deviceId.isEmpty ? Color.gray.opacity(0.4) : Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(deviceId.isEmpty)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    InputDeviceIdView(deviceId: "") {}
}
