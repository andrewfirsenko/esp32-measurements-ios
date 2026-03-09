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
    
    // MARK: - Dependencies
    @StateObject var deviceIdState: DeviceIdState
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Private Properties
    @State private var deviceId: String = ""
    
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
            
            Button {
                deviceIdState.deviceId = deviceId
                dismiss()
            } label: {
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
        .onAppear {
            deviceId = deviceIdState.deviceId ?? ""
        }
    }
}

// MARK: - Preview
#Preview {
    let mockDeviceIdStack = DeviceIdState()
    InputDeviceIdView(deviceIdState: mockDeviceIdStack)
}
