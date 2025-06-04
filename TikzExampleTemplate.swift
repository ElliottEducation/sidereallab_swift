// ✅ 修正后：TemplateModel.swift

import SwiftUI

struct TikzExampleTemplate: Identifiable {
    let id = UUID()
    let mainCategory: String
    let subCategory: String
    let defaultFormula: String
    let imageAssetName: String
}

struct TemplateLibrary {
    static let examples: [TikzExampleTemplate] = [
        TikzExampleTemplate(
            mainCategory: "Mathematics",
            subCategory: "Functions",
            defaultFormula: #"y = x^2"#,
            imageAssetName: "tikz_example_integral"
        ),
        TikzExampleTemplate(
            mainCategory: "Mathematics",
            subCategory: "Derivatives",
            defaultFormula: #"f'(x) = 2x"#,
            imageAssetName: "tikz_example_derivative"
        ),
        TikzExampleTemplate(
            mainCategory: "Mathematics",
            subCategory: "Integrals",
            defaultFormula: #"\int_0^3 x^2 dx"#,
            imageAssetName: "tikz_example_tangent"
        ),
        TikzExampleTemplate(
            mainCategory: "Physics",
            subCategory: "Quantum Mechanics",
            defaultFormula: #"\psi(x) = e^{-x^2}"#,
            imageAssetName: "tikz_example_wavefunction"
        ),
        TikzExampleTemplate(
            mainCategory: "Statistics",
            subCategory: "Probability",
            defaultFormula: #"P(x) = \frac{1}{\sqrt{2\pi}} e^{-\frac{x^2}{2}}"#,
            imageAssetName: "tikz_example_probability"
        )
    ]

    static func template(for main: String, sub: String) -> TikzExampleTemplate? {
        examples.first { $0.mainCategory == main && $0.subCategory == sub }
    }
}
