import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "function")
                }
            
            ChartView()
                .tabItem {
                    Label("Charts", systemImage: "chart.xyaxis.line")
                }
            
            ExportView()
                .tabItem {
                    Label("Export", systemImage: "square.and.arrow.up")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

