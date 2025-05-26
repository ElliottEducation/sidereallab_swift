import SwiftUI

struct ExportView: View {
    @StateObject private var viewModel = RotationViewModel()
    @State private var showShareSheet = false
    @State private var exportURL: URL? = nil
    @State private var exportFormat: ExportFormat = .csv
    
    var body: some View {
        Form {
            Section(header: Text("Export Summary")) {
                HStack { Text("Latitude"); Spacer(); Text(String(format: "%.2f°", viewModel.latitude)) }
                HStack { Text("ΔT"); Spacer(); Text(viewModel.deltaTString) }
                HStack { Text("Speed"); Spacer(); Text(viewModel.speedString) }
            }
            
            Picker("Format", selection: $exportFormat) {
                Text("CSV").tag(ExportFormat.csv)
                Text("Markdown").tag(ExportFormat.markdown)
                Text("PDF").tag(ExportFormat.pdf)
            }.pickerStyle(.segmented)
            
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

