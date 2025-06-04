// ✅ TexPreviewRenderer.swift（兼容 iOS/macOS，修复转义并适配平台）

import SwiftUI
import PDFKit

#if os(macOS)
import AppKit
#endif

struct TexPreviewRenderer: View {
    let tikzCode: String

    var body: some View {
        VStack {
            if let pdfURL = generatePDFfromTikZ(tikzCode: tikzCode),
               let document = PDFDocument(url: pdfURL) {
                PDFKitView(document: document)
            } else {
                Text("Failed to render preview")
            }
        }
    }

    func generatePDFfromTikZ(tikzCode: String) -> URL? {
        #if os(macOS)
        let texTemplate = #"""
        \documentclass{standalone}
        \usepackage{tikz}
        \begin{document}
        \(tikzCode)
        \end{document}
        """#

        let tempDir = FileManager.default.temporaryDirectory
        let texURL = tempDir.appendingPathComponent("preview.tex")

        do {
            try texTemplate.write(to: texURL, atomically: true, encoding: .utf8)

            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/Library/TeX/texbin/pdflatex")
            task.currentDirectoryURL = tempDir
            task.arguments = ["preview.tex"]
            try task.run()
            task.waitUntilExit()

            let pdfURL = tempDir.appendingPathComponent("preview.pdf")
            return FileManager.default.fileExists(atPath: pdfURL.path) ? pdfURL : nil

        } catch {
            print("LaTeX error: \(error)")
            return nil
        }
        #else
        return nil // iOS 不支持本地渲染
        #endif
    }
}

struct PDFKitView: UIViewRepresentable {
    let document: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

