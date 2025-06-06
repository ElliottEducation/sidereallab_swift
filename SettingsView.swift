import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("App Info")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Elliott")
                            .foregroundColor(.gray)
                    }
                }

                Section(header: Text("Help & Support")) {
                    NavigationLink(destination: UserManualView()) {
                        Label("User Manual", systemImage: "book")
                    }

                    Label {
                        Link("Contact Developer", destination: URL(string: "mailto:elliotteducation956@gmail.com")!)
                    } icon: {
                        Image(systemName: "envelope")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

