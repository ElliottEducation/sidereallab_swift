import Foundation

struct FormulaToTikzConverter {
    static func convert(input: String, category: String) -> String {
        let sanitizedInput = input.replacingOccurrences(of: "\\", with: "\\\\")
        switch category {
        case "Functions":
            return """
            \\begin{tikzpicture}
              \\draw[->] (-3,0) -- (3,0) node[right] {$x$};
              \\draw[->] (0,-3) -- (0,3) node[above] {$y$};
              \\draw[domain=-2:2, smooth, variable=\\x, blue]
                plot ({\\x},{\\x^2});
              \\node at (1,2.5) {\\texttt{\\( \(sanitizedInput) \\)}};
            \\end{tikzpicture}
            """

        case "Derivatives":
            return """
            \\begin{tikzpicture}
              \\draw[->] (-3,0) -- (3,0) node[right] {$x$};
              \\draw[->] (0,-3) -- (0,3) node[above] {$y$};
              \\draw[domain=-2:2, smooth, variable=\\x, blue] plot ({\\x},{\\x^2});
              \\draw[dashed, red] (1,0) -- (1,2) node[above] {tangent};
              \\node at (1.2,2.5) {\\texttt{\\( \(sanitizedInput) \\)}};
            \\end{tikzpicture}
            """

        case "Integrals":
            return """
            \\begin{tikzpicture}
              \\draw[->] (-1,0) -- (4,0) node[right] {$x$};
              \\draw[->] (0,-1) -- (0,5) node[above] {$y$};
              \\draw[domain=0:3, smooth, variable=\\x, blue, thick] plot ({\\x},{\\x^2});
              \\fill[blue!20, opacity=0.5] (0,0) -- plot[domain=0:3] ({\\x},{\\x^2}) -- (3,0) -- cycle;
              \\node at (1.5,4.5) {$\\int_0^3 x^2 dx$};
              \\node at (1.5,1.2) {\\texttt{\\( \(sanitizedInput) \\)}};
            \\end{tikzpicture}
            """

        case "Linear Algebra":
            return """
            \\begin{tikzpicture}
              \\matrix[matrix of math nodes,left delimiter={[},right delimiter={]}] at (0,0) {
                1 & 2 \\\\
                3 & 4 \\\\
              };
              \\node at (1,-1) {\\texttt{\\( \(sanitizedInput) \\)}};
            \\end{tikzpicture}
            """

        case "Quantum Mechanics":
            return """
            \\begin{tikzpicture}
              \\draw[->] (-2,0) -- (2,0) node[right] {$x$};
              \\draw[->] (0,-0.5) -- (0,2) node[above] {$\\psi(x)$};
              \\draw[domain=-1.5:1.5, smooth, variable=\\x, blue, thick]
                plot ({\\x},{exp(-\\x^2)});
              \\node at (0,1.6) {\\texttt{Wave function}};
              \\node at (0,-0.3) {\\texttt{\\( \(sanitizedInput) \\)}};
            \\end{tikzpicture}
            """

        case "Probability":
            return """
            \\begin{tikzpicture}
              \\draw[->] (-0.5,0) -- (5,0) node[right] {$x$};
              \\draw[->] (0,-0.1) -- (0,1) node[above] {$P(x)$};
              \\draw[domain=0:4, smooth, variable=\\x, blue]
                plot ({\\x},{(1/(sqrt(2*pi)))*exp(-0.5*\\x*\\x)});
              \\node at (2,0.9) {\\texttt{Normal PDF}};
              \\node at (2,0.3) {\\texttt{\\( \(sanitizedInput) \\)}};
            \\end{tikzpicture}
            """

        default:
            return "% No TikZ template defined for this category."
        }
    }
}

