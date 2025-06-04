//
//  TikzEditorViewModel.swift
//  Math2TikZ
//
//  Created by Elliott on 1/6/2025.
//


import Foundation
import SwiftUI

class TikzEditorViewModel: ObservableObject {
    @Published var tikzCode: String = ""

    func loadTemplate(for main: String, sub: String) {
        tikzCode = TikzTemplateStore.getTemplate(for: main, sub: sub)
    }
}
