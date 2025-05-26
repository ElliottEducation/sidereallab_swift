import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section(header: Text("App Info")) {
                Text("Version 1.0")
                Text("Developed by Elliott")
            }
            
            Section(header: Text("Links")) {
                Link("Visit Website", destination: URL(string: "https://sidereallab.streamlit.app")!)
                Link("GitHub Repo", destination: URL(string: "https://github.com/elliottcao/sidereallab")!)
            }
        }
        .navigationTitle("Settings")
    }
}

