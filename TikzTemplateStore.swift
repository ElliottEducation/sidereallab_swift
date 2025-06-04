//
//  TikzTemplateStore.swift
//  Math2TikZ
//
//  Created by Elliott on 1/6/2025.
//


import Foundation

struct TikzTemplateStore {
    static func getTemplate(for main: String, sub: String) -> String {
        switch (main, sub) {
        case ("Mathematics", "functions"):
            return #"""
\begin{tikzpicture}
  \draw[->] (-2,0) -- (2,0) node[right] {$x$};
  \draw[->] (0,-1) -- (0,4) node[above] {$y$};
  \draw[domain=-2:2, smooth, variable=\x, blue] plot ({\x},{\x^2});
\end{tikzpicture}
"""#
        default:
            return "% No TikZ template defined for this category yet."
        }
    }
}
