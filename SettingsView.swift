//
//  SettingsView.swift
//  Math2TikZ
//
//  Created by Elliott on 4/6/2025.
//


// ✅ 3. SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @AppStorage("language") var language = "English"
    @AppStorage("theme") var theme = "System"
    @AppStorage("exportFormat") var exportFormat = "PDF"

    var body: some View {
        Form {
            Section(header: Text("Language")) {
                Picker("Language", selection: $language) {
                    Text("English").tag("English")
                    Text("中文").tag("Chinese")
                }
            }

            Section(header: Text("Theme")) {
                Picker("Theme", selection: $theme) {
                    Text("System").tag("System")
                    Text("Light").tag("Light")
                    Text("Dark").tag("Dark")
                }
            }

            Section(header: Text("Export Format")) {
                Picker("Format", selection: $exportFormat) {
                    Text("PDF").tag("PDF")
                    Text("PNG").tag("PNG")
                    Text("LaTeX").tag("LaTeX")
                }
            }
        }
        .navigationTitle("Settings")
    }
}