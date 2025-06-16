import SwiftUI

struct UserManualView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("SiderealLab User Manual")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)

                Group {
                    Text("📌 Version 1.0 Features (Free)")
                        .font(.title2)
                        .bold()

                    Text("""
                    1. **Rotational Speed Calculator**
                       - Input latitude and time duration to compute Earth's rotation speed.

                    2. **Speed vs Latitude Graphs**
                       - View visual plots to understand how speed changes with latitude.

                    3. **Export Options**
                       - Export results as image or PDF.
                       - Generate LaTeX + TikZ code for academic use.

                    4. **Minimalist Interface**
                       - Tabs for Calculator, Charts, Export, and Settings.
                    """)
                }

                Divider().padding(.vertical, 10)

                Group {
                    Text("🚀 Coming in Pro Version")
                        .font(.title2)
                        .bold()

                    Text("""
                    1. **GPS Integration**
                       - Automatically detect your latitude.

                    2. **Custom Celestial Targets**
                       - Input RA/Dec and simulate sidereal tracking.

                    3. **Advanced Data Visualization**
                       - Multiple chart styles, animations, and overlays.

                    4. **User Accounts & Cloud Sync**
                       - Save and sync your calculations.

                    5. **Multi-language Support**
                       - English, 中文, Dansk, and more.

                    6. **PDF Lab Report Generator**
                       - Create a scientific report from input/output.
                    """)
                }

                Divider().padding(.vertical, 10)

                Group {
                    Text("📬 Support & Contact")
                        .font(.title2)
                        .bold()

                    Text("For bug reports or feedback, contact the developer:")
                    Link("elliotteducation956@gmail.com", destination: URL(string: "mailto:elliotteducation956@gmail.com")!)
                }
            }
            .padding()
        }
        .navigationTitle("User Manual")
    }
}

