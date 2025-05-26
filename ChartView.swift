import SwiftUI
import Charts

struct ChartDataPoint: Identifiable {
    var id = UUID()
    var latitude: Double
    var radius: Double
    var speedMS: Double
    var speedKMH: Double
}

struct ChartView: View {
    @ObservedObject private var viewModel = RotationViewModel()
    
    private var data: [ChartDataPoint] {
        stride(from: 0.0, through: 90.0, by: 1.0).map { lat in
            let radius = EarthRotationCalculator.effectiveRadius(latitude: lat)
            let omega = EarthRotationCalculator.angularVelocity(deltaT: 86164.0905)
            let speed = omega * radius
            return ChartDataPoint(
                latitude: lat,
                radius: radius,
                speedMS: speed,
                speedKMH: speed * 3.6
            )
        }
    }
    
    private var highlightedPoint: ChartDataPoint? {
        let matched = data.min(by: { abs($0.latitude - viewModel.latitude) < abs($1.latitude - viewModel.latitude) })
        return matched
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Latitude vs Speed (m/s)").font(.headline)
                Chart {
                    ForEach(data) { point in
                        LineMark(
                            x: .value("Latitude", point.latitude),
                            y: .value("Speed (m/s)", point.speedMS)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(.blue)
                    }
                    
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
                    }
                }
                .frame(height: 280)
                
                Text("Latitude vs Radius (m)").font(.headline)
                Chart {
                    ForEach(data) { point in
                        LineMark(
                            x: .value("Latitude", point.latitude),
                            y: .value("Radius", point.radius)
                        )
                        .foregroundStyle(.purple)
                    }
                }
                .frame(height: 280)
                
                Text("Latitude vs Speed (km/h)").font(.headline)
                Chart {
                    ForEach(data) { point in
                        LineMark(
                            x: .value("Latitude", point.latitude),
                            y: .value("Speed (km/h)", point.speedKMH)
                        )
                        .foregroundStyle(.green)
                    }
                }
                .frame(height: 280)
            }
            .padding()
        }
        .navigationTitle("Rotation Charts")
    }
}

