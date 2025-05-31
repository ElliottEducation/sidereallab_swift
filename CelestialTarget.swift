import Foundation

struct CelestialTarget: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let ra: Double   // RA in hours
    let dec: Double  // Dec in degrees
}

let celestialTargets: [CelestialTarget] = [
    CelestialTarget(name: "Sirius (α CMa)", ra: 6.752, dec: -16.72),
    CelestialTarget(name: "Vega (α Lyr)", ra: 18.615, dec: 38.78),
    CelestialTarget(name: "Betelgeuse (α Ori)", ra: 5.919, dec: 7.407),
    CelestialTarget(name: "Rigel (β Ori)", ra: 5.242, dec: -8.201),
    CelestialTarget(name: "Altair (α Aql)", ra: 19.846, dec: 8.868),
    CelestialTarget(name: "M42 (Orion Nebula)", ra: 5.591, dec: -5.45),
    CelestialTarget(name: "M13 (Hercules Cluster)", ra: 16.42, dec: 36.46),
    CelestialTarget(name: "NGC 7000 (North America)", ra: 20.85, dec: 44.0)
]

