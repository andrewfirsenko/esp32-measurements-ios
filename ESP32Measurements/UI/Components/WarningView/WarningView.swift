//
//  WarningView.swift
//  ESP32Measurements
//
//  Created by Andrew on 17.03.2026.
//

import SwiftUI

struct WarningView: View {
    // MARK: - Constants
    private enum Constants {
        static let largeSpacing: CGFloat = 16
        static let smallSpacing: CGFloat = 8
        static let buttonCornerRadius: CGFloat = 12
    }
    
    // MARK: - Dependencies
    var onTryAgain: () -> Void
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: Constants.largeSpacing) {
            Image(.warning)
                .resizable()
                .scaledToFit()
                .scaleEffect(1.6)
                .frame(height: 60)
            
            VStack(spacing: Constants.smallSpacing) {
                Text(Strings.Localizable.Warning.connectionErrorTitle)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(Strings.Localizable.Warning.connectionErrorDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
            
            Button {
                onTryAgain()
            } label: {
                Text(Strings.Localizable.Warning.tryAgain)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(Constants.buttonCornerRadius)
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview
#Preview {
    WarningView() {}
}
