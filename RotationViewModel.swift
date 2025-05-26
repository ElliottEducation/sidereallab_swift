import Foundation
import SwiftUI

class RotationViewModel: ObservableObject {
    @Published var latitude: Double = 31.2304
    
    // 精确时间
    @Published var startTime: Date = Date()
    @Published var endTime: Date = Date().addingTimeInterval(86164.0)
    
    // RA/Dec 漂移修正
    @Published var useRAInput: Bool = false
    @Published var ra1: Double = 0.0
    @Published var ra2: Double = 1.0
    @Published var dec1: Double = 0.0
    @Published var dec2: Double = 0.0
    
    // 目标选择
    @Published var selectedTarget: CelestialTarget? = nil
    
    func applySelectedTarget() {
        guard let target = selectedTarget else { return }
        ra1 = target.ra
        ra2 = target.ra
        dec1 = target.dec
        dec2 = target.dec
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
    
    var omega: Double {
        EarthRotationCalculator.angularVelocity(deltaT: activeDeltaT)
    }
    
    var speed: Double {
        EarthRotationCalculator.siderealSpeed(latitude: latitude, deltaT: activeDeltaT)
    }
    
    var deltaTString: String {
        String(format: "%.0f seconds", activeDeltaT)
    }
    
    var omegaString: String {
        String(format: "%.8f rad/s", omega)
    }
    
    var speedString: String {
        String(format: "%.2f m/s", speed)
    }
}

