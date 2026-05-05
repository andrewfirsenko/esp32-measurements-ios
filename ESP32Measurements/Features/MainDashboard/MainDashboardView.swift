//
//  MainDashboardView.swift
//  ESP32Measurements
//
//  Created by Andrew on 04.01.2026.
//

import SwiftUI
import Network

struct MainDashboardView: View {
    // MARK: - Constants
    private enum Constants {
        static let deviceIdInputText = "deviceId:"
        static let deviceIdLineLimit: Int = 1
        static let currentValuesSpacing: CGFloat = 12
        static let mainSpacing: CGFloat = 16
    }
    
    // MARK: - Dependencies
    @ObservedObject var viewModel: MainDashboardViewModel
    @EnvironmentObject var deviceIdState: DeviceIdState
    
    // MARK: - Init
    init(viewModel: MainDashboardViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    HStack {
                        Text(Constants.deviceIdInputText)
                            .foregroundStyle(.secondary)
                        Text(deviceIdState.deviceId ?? "")
                            .foregroundStyle(.secondary)
                            .lineLimit(Constants.deviceIdLineLimit)
                        Spacer()
                        NavigationLink(Strings.Localizable.MainDashboard.change) {
                            InputDeviceIdView()
                        }
                    }
                    currentStateView
                }
                .frame(minHeight: geo.size.height)
                .padding(.horizontal)
            }
            .scrollIndicators(.never)
        }
        .navigationTitle(Strings.InfoPlist.cfBundleDisplayName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.startTask()
        }
    }
    
    // MARK: - Private UI
    @ViewBuilder
    private var currentStateView: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .error:
            errorView
        case .content:
            contentView
        }
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .controlSize(.large)
            Spacer()
        }
    }
    
    private var errorView: some View {
        VStack {
            Spacer()
            WarningView() {
                debugPrint("log: did tap TryAgain")
            }
            Spacer()
        }
    }
    
    private var contentView: some View {
        VStack(spacing: Constants.mainSpacing) {
            HStack(spacing: Constants.currentValuesSpacing) {
                SensorValueView(viewModel: viewModel.temperatureValue)
                SensorValueView(viewModel: viewModel.pressureValue)
                SensorValueView(viewModel: viewModel.humidityValue)
            }

            SensorChartView(viewModel: viewModel.temperatureChart)
            SensorChartView(viewModel: viewModel.humidityChart)
            SensorChartView(viewModel: viewModel.pressureChart)
        }
    }
}

// MARK: - Preview
#Preview {
    let esp32MeasurementsService = ESP32MeasurementsService(apiService: APIService())
    let viewModel = MainDashboardViewModel(esp32MeasurementsService: esp32MeasurementsService)
    MainDashboardView(viewModel: viewModel).environmentObject(DeviceIdState.shared)
}
