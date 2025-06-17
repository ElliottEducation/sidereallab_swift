import SwiftUI

struct ExportView: View {
    @ObservedObject var viewModel: RotationViewModel
    @State private var showShareSheet = false
    @State private var exportURL: URL? = nil
    @State private var exportFormat: ExportFormat = .csv

    var body: some View {
        Form {
            // Section with VStack (the latest stable)
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Latitude")
                        Spacer()
                        Text(String(format: "%.2f°", viewModel.latitude))
                    }

                    HStack {
                        Text("ΔT")
                        Spacer()
                        Text(viewModel.deltaTString)
                    }

                    HStack {
                        Text("Speed")
                        Spacer()
                        Text("\(viewModel.speedConverted) \(viewModel.selectedSpeedUnit.rawValue)")
                    }
                }
            } header: {
                Text("Export Summary")
            }

            // Format picker
            Picker("Format", selection: $exportFormat) {
                Text("CSV").tag(ExportFormat.csv)
                Text("Markdown").tag(ExportFormat.markdown)
                Text("PDF").tag(ExportFormat.pdf)
            }
            .pickerStyle(.segmented)

            // Export button
            Button("Export Now") {
                let result = ExportResult(
                    latitude: viewModel.latitude,
                    deltaT: viewModel.activeDeltaT,
                    omega: viewModel.omega,
                    speedMS: viewModel.speed,
                    speedKMH: viewModel.speed * 3.6,
                    timestamp: Date()
                )
                exportURL = ExportManager.export(result: result, format: exportFormat)
                showShareSheet = true
            }
        }
        .navigationTitle("Export")
        .sheet(isPresented: $showShareSheet) {
            if let exportURL = exportURL {
                ShareSheet(activityItems: [exportURL])
            }
        }
    }
}

