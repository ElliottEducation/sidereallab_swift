import Foundation

struct ChartDataPoint: Identifiable {
    var id = UUID()
    var latitude: Double
    var speedMS: Double
}
