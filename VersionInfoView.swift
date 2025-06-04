//
//  VersionInfoView.swift
//  Math2TikZ
//
//  Created by Elliott on 4/6/2025.
//


// ✅ 4. VersionInfoView.swift
import SwiftUI

struct VersionInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Math2TikZ Pro")
                .font(.largeTitle)
                .bold()

            Text("Version 1.0.0")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Divider()

            Text("Features:")
                .font(.headline)
            Text("- Convert math formulas to TikZ code")
            Text("- Support LaTeX preview rendering")
            Text("- Voice-to-TikZ via speech recognition")
            Text("- Natural language formula input")
            Text("- Category-based formula templates")

            Divider()

            Text("Developed by Elliott")
            Spacer()
        }
        .padding()
        .navigationTitle("About")
    }
}
