import SwiftUI
import Charts

struct RotationChartDataPoint: Identifiable {
    var id = UUID()
    var latitude: Double
    var speedMS: Double
}

struct ChartView: View {
    @ObservedObject var viewModel: RotationViewModel

    private var data: [RotationChartDataPoint] {
        // 使用更细的步进以便贴合用户输入的纬度（如33.80）
        stride(from: -90.0, through: 90.0, by: 0.1).map { lat in
            let speed = EarthRotationCalculator.siderealSpeed(latitude: lat, deltaT: viewModel.activeDeltaT)
            return RotationChartDataPoint(latitude: lat, speedMS: speed)
        }
    }

    private var highlightedPoint: RotationChartDataPoint? {
        data.min(by: { abs($0.latitude - viewModel.latitude) < abs($1.latitude - viewModel.latitude) })
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Latitude vs Speed (m/s)")
                    .font(.headline)
                    .padding(.leading)

                Chart {
                    // 主曲线
                    ForEach(data) { point in
                        LineMark(
                            x: .value("Latitude", point.latitude),
                            y: .value("Speed (m/s)", point.speedMS)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(.blue)
                    }

                    // 高亮红点与注解
                    if let highlight = highlightedPoint {
                        PointMark(
                            x: .value("Latitude", highlight.latitude),
                            y: .value("Speed", highlight.speedMS)
                        )
                        .symbolSize(80)
                        .foregroundStyle(.red)
                        .annotation(position: .top) {
                            Text(String(format: "%.2f m/s", highlight.speedMS))
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        .annotation(position: .bottom) {
                            // ✅ 使用用户原始输入纬度以保证小数精度同步
                            Text("\(viewModel.latitude.formattedWithExactDecimals(from: viewModel.latitude))°")
                                .font(.caption2)
                                .foregroundColor(.red)
                        }

                        // 红色十字虚线
                        RuleMark(x: .value("Latitude", highlight.latitude))
                            .foregroundStyle(.red)
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))

                        RuleMark(y: .value("Speed", highlight.speedMS))
                            .foregroundStyle(.red)
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    }
                }
                .frame(height: 300)
                .padding()
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartXScale(domain: -90.0...90.0)
                .chartYScale(domain: 0.0...500.0)
            }
        }
        .navigationTitle("Rotation Charts")
    }
}

