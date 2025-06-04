import SwiftUI

struct TikzChartGalleryView: View {
    let imageNames = ["tikz_example_integral", "tikz_example_derivative"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(imageNames, id: \.self) { name in
                    if let uiImage = UIImage(named: name) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .padding()
                    } else {
                        Text("Image '\(name)' not found.")
                    }
                }
            }
        }
        .navigationTitle("Chart Gallery")
    }
}

