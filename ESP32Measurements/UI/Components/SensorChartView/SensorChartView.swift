//
//  SensorChartView.swift
//  ESP32Measurements
//
//  Created by Andrew on 21.02.2026.
//

import SwiftUI
import Charts

struct SensorChartView: View {
    // MARK: - Constants
    private enum Constants {
        static let chartHeight: CGFloat = 140
    }
    // MARK: - Public Properties
    @ObservedObject var viewModel: SensorChartViewModel
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.title)
                .font(.headline)
            
            Chart(viewModel.points) { point in
                // Gradient below charts
                AreaMark(
                    x: .value("Time", point.date),
                    y: .value("Value", point.value)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            viewModel.color.opacity(0.3),
                            viewModel.color.opacity(0.05)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // Main line
                LineMark(
                    x: .value("Time", point.date),
                    y: .value("Value", point.value)
                )
                .foregroundStyle(viewModel.color)
                .lineStyle(StrokeStyle(lineWidth: 3))
                .interpolationMethod(.catmullRom)
                
                // Last point
                if point.id == viewModel.points.last?.id {
                    PointMark(
                        x: .value("Time", point.date),
                        y: .value("Value", point.value)
                    )
                    .symbolSize(120)
                    .foregroundStyle(viewModel.color)
                }
                    
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisValueLabel {
                        if let intValue = value.as(Int.self) {
                            Text("\(intValue) \(viewModel.unit)")
                        }
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .hour, count: 6)) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.hour().minute())
                }
            }
            .frame(height: Constants.chartHeight)
            .padding([.top, .trailing])
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

// MARK: - Preview
#Preview {
    let mock = SensorChartViewModel(
        title: "Температура за 24 часа",
        unit: "C+",
        color: .red,
        points: [
            SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771641189), value: 15),
            SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771651189), value: 20),
            SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771661189), value: 30),
            SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771671189), value: 15),
            SensorChartViewModel.ChartPoint(date: Date(timeIntervalSince1970: 1771681189), value: 20),
        ]
    )
    SensorChartView(viewModel: mock)
}
