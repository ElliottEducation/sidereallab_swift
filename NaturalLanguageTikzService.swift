//
//  NaturalLanguageTikzService.swift
//  Math2TikZ
//
//  Created by Elliott on 4/6/2025.
//


import Foundation

struct NaturalLanguageTikzService {
    static func generate(from prompt: String) -> String {
        // This is a placeholder. Replace with actual GPT API call in future Pro version.
        if prompt.lowercased().contains("integral") {
            return """
            \\begin{tikzpicture}
              \\draw[->] (-0.5, 0) -- (3.5, 0) node[right] {$x$};
              \\draw[->] (0, -0.5) -- (0, 5.5) node[above] {$y$};
              \\draw[domain=0:3, smooth, variable=\\x, blue, thick] plot ({\\x}, {\\x*\\x});
              \\fill[blue!20, opacity=0.5] (0,0) -- plot[domain=0:3] ({\\x},{\\x*\\x}) -- (3,0) -- cycle;
              \\node at (1.5,4.5) {$\\int_0^3 x^2 dx$};
            \\end{tikzpicture}
            """
        } else {
            return "% No matching template for the given prompt. Please try again."
        }
    }
}
