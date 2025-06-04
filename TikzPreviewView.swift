//
//  TikzPreviewView.swift
//  Math2TikZ
//
//  Created by Elliott on 1/6/2025.
//


import SwiftUI
import WebKit

struct TikzPreviewView: UIViewRepresentable {
    let latexSource: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
        </head>
        <body>
        $$\(latexSource)$$
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
}
