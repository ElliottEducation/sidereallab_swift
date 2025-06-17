import Foundation
import SwiftUI

class RotationViewModel: ObservableObject {
    @Published var latitude: Double = 31.2304

    @Published var startDateString: String = "2025-05-28"
    @Published var endDateString: String = "2025-05-29"

    @Published var startHour: Int = 14
    @Published var startMinute: Int = 42
    @Published var startSecond: Int = 0

    @Published var endHour: Int = 14
    @Published var endMinute: Int = 44
    @Published var endSecond: Int = 0

    @Published var selectedTarget: CelestialTarget? = nil
    @Published var ra1: Double = 0.0
    @Published var ra2: Double = 1.0
    @Published var dec1: Double = 0.0
    @Published var dec2: Double = 0.0

    @Published var useRAInput: Bool = false

    // unit switching
    enum SpeedUnit: String, CaseIterable, Identifiable {
        case mps = "m/s"
        case kmh = "km/h"
        case mph = "mi/h"
        var id: String { self.rawValue }
    }

    @Published var selectedSpeedUnit: SpeedUnit = .mps

    var speedConverted: String {
        switch selectedSpeedUnit {
        case .mps:
            return String(format: "%.2f", speed)
        case .kmh:
            return String(format: "%.2f", speed * 3.6)
        case .mph:
            return String(format: "%.2f", speed * 2.23694)
        }
    }

    private func parseDate(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }

    var startTime: Date {
        guard let date = parseDate(from: startDateString) else { return Date() }
        return Calendar.current.date(bySettingHour: startHour, minute: startMinute, second: startSecond, of: date) ?? Date()
    }

    var endTime: Date {
        guard let date = parseDate(from: endDateString) else { return Date() }
        return Calendar.current.date(bySettingHour: endHour, minute: endMinute, second: endSecond, of: date) ?? Date()
    }

    var deltaT: Double {
        abs(endTime.timeIntervalSince(startTime))
    }

    var correctedDeltaT: Double {
        let deltaRA = abs(ra2 - ra1)
        return deltaRA > 0 ? (24.0 / deltaRA) * 86164.0905 : 86164.0905
    }

    var activeDeltaT: Double {
        useRAInput ? correctedDeltaT : deltaT
    }

    var effectiveRadius: Double {
        EarthRotationCalculator.effectiveRadius(latitude: latitude)
    }

    var omega: Double {
        EarthRotationCalculator.angularVelocity(deltaT: activeDeltaT)
    }

    var speed: Double {
        EarthRotationCalculator.siderealSpeed(latitude: latitude, deltaT: activeDeltaT)
    }

    var deltaTString: String {
        String(format: "%.0f seconds", activeDeltaT)
    }

    var omegaScientificString: String {
        let raw = String(format: "%.2e", omega)
        let components = raw.split(separator: "e")
        if components.count == 2 {
            return "\(components[0]) × 10^(\(components[1]))"
        }
        return raw
    }

    func applySelectedTarget() {
        guard let target = selectedTarget else { return }
        ra1 = target.ra
        ra2 = target.ra
        dec1 = target.dec
        dec2 = target.dec
    }
}

