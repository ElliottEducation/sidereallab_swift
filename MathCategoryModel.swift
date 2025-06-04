//
//  MathCategoryModel.swift
//  Math2TikZ
//
//  Created by Elliott on 4/6/2025.
//


import Foundation

struct MathCategoryModel {
    static let categories: [String: [String]] = [
        "Mathematics": [
            "Functions",
            "Limits",
            "Derivatives",
            "Integrals",
            "Linear Algebra"
        ],
        "Physics": [
            "Mechanics",
            "Electromagnetism",
            "Quantum Mechanics",
            "Waves"
        ],
        "Statistics": [
            "Probability",
            "Distributions",
            "Regression",
            "Inference"
        ]
    ]
}