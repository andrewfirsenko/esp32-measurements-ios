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
    }
    
    // MARK: - Public Properties
    @ObservedObject var viewModel: SensorValueViewModel
    
    // MARK: - UI
    var body: some View {
        contentView
            .padding()
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(
                RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                    .fill(Color(.secondarySystemBackground))
            )
    }
    
    // MARK: - Private UI
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            self.loadingView
        } else {
            self.loadedView
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: Constants.cardSpacing) {
            ProgressView()
                .controlSize(.large)
            Text("Загрузка...")
                .font(.title3)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
    
    private var loadedView: some View {
        VStack(spacing: Constants.cardSpacing) {
            Image(systemName: viewModel.systemImageName)
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
    }
}

// MARK: - Preview
#Preview {
    let mock = SensorValueViewModel(
        title: "Температура",
        systemImageName: "thermometer"
    )
    SensorValueView(viewModel: mock)
}
