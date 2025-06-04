//
//  EditorPanelView.swift
//  Math2TikZ
//
//  Created by Elliott on 1/6/2025.
//


import SwiftUI

struct EditorPanelView: View {
    @ObservedObject var viewModel: TikzEditorViewModel

    var body: some View {
        Section(header: Text("Edit TikZ Code")) {
            TextEditor(text: $viewModel.tikzCode)
                .font(.system(.body, design: .monospaced))
                .frame(minHeight: 150)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray.opacity(0.3)))

            HStack {
                Spacer()
                Text("Length: \(viewModel.tikzCode.count) chars")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
