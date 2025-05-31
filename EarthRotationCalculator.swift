import Foundation

struct EarthRotationCalculator {
    static let a: Double = 6378137.0
    static let eSquared: Double = 0.00669437999014

    static func effectiveRadius(latitude: Double) -> Double {
        let phi = latitude * .pi / 180
        let numerator = a * cos(phi)
        let denominator = sqrt(1 - eSquared * pow(sin(phi), 2))
        return numerator / denominator
    }

    static func angularVelocity(deltaT: Double) -> Double {
        return 2 * .pi / deltaT
    }

    static func siderealSpeed(latitude: Double, deltaT: Double) -> Double {
        let radius = effectiveRadius(latitude: latitude)
        let omega = angularVelocity(deltaT: deltaT)
        return omega * radius
    }
}

