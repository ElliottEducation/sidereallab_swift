import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RotationViewModel()

    var body: some View {
        TabView {
            CalculatorView(viewModel: viewModel)
                .tabItem {
                    Label("Calculator", systemImage: "function")
                }

            ChartView(viewModel: viewModel)
                .tabItem {
                    Label("Charts", systemImage: "chart.xyaxis.line")
                }

            ExportView(viewModel: viewModel)
                .tabItem {
                    Label("Export", systemImage: "square.and.arrow.up")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

