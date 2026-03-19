//
//  SensorValueView.swift
//  ESP32Measurements
//
//  Created by Andrew on 21.02.2026.
//

import SwiftUI

struct SensorValueView: View {
    // MARK: - Constants
    private enum Constants {
        static let cardSpacing: CGFloat = 8
        static let cardCornerRadius: CGFloat = 16
        static let imageHeight: CGFloat = 36
        static let minHeight: CGFloat = 120
    }
    
    // MARK: - Public Properties
    @ObservedObject var viewModel: SensorValueViewModel
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: Constants.cardSpacing) {
            Image(viewModel.imageResource)
                .resizable()
                .scaledToFit()
                .frame(height: Constants.imageHeight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            Text(viewModel.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Text(viewModel.value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: Constants.minHeight)
        .background(
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

// MARK: - Preview
#Preview {
    let mock = SensorValueViewModel(
        title: Strings.Localizable.MainDashboard.temperature,
        imageResource: .tempratureIcon,
        value: "120 C"
    )
    SensorValueView(viewModel: mock)
}
