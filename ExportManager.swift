import Foundation
import PDFKit
import UIKit

enum ExportFormat {
    case csv, markdown, pdf
}

struct ExportResult {
    let latitude: Double
    let deltaT: Double
    let omega: Double
    let speedMS: Double
    let speedKMH: Double
    let timestamp: Date
}

class ExportManager {
    static func export(result: ExportResult, format: ExportFormat) -> URL? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmm"
        let fileName = "Sidereal_\(formatter.string(from: result.timestamp))"

        switch format {
        case .csv:
            let csv = "Latitude,ΔT,ω,Speed (m/s),Speed (km/h),Time\n\(result.latitude),\(result.deltaT),\(result.omega),\(result.speedMS),\(result.speedKMH),\(result.timestamp)"
            return saveToTemp(content: csv, fileName: "\(fileName).csv")

        case .markdown:
            let md = """
            # SiderealLab Report
            - Latitude: \(result.latitude)°
            - ΔT: \(Int(result.deltaT)) s
            - ω: \(String(format: "%.8f", result.omega)) rad/s
            - Speed: \(String(format: "%.2f", result.speedMS)) m/s / \(String(format: "%.2f", result.speedKMH)) km/h
            - Timestamp: \(formatter.string(from: result.timestamp))
            """
            return saveToTemp(content: md, fileName: "\(fileName).md")

        case .pdf:
            return generatePDF(content: """
            SiderealLab Pro Report

            Latitude: \(result.latitude)°
            ΔT: \(Int(result.deltaT)) s
            ω: \(String(format: "%.8f", result.omega)) rad/s
            Speed: \(String(format: "%.2f", result.speedMS)) m/s
            Speed: \(String(format: "%.2f", result.speedKMH)) km/h

            Generated: \(formatter.string(from: result.timestamp))
            """, fileName: "\(fileName).pdf")
        }
    }

    static private func saveToTemp(content: String, fileName: String) -> URL? {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        try? content.write(to: url, atomically: true, encoding: .utf8)
        return url
    }

    static private func generatePDF(content: String, fileName: String) -> URL? {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792))
        do {
            try renderer.writePDF(to: url) { ctx in
                ctx.beginPage()
                let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
                content.draw(at: CGPoint(x: 40, y: 40), withAttributes: attributes)
            }
            return url
        } catch {
            return nil
        }
    }
}

