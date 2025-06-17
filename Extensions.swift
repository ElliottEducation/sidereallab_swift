//
//  Extensions.swift
//  SiderealLab
//
//  Created by Elliott on 29/5/2025.
//

import Foundation

/// Extend the Double type to support dynamic formatting based on the number of decimal places originally entered by the user
extension Double {
    /// Keep the same number of decimal places as the original value `original` passed in
    ///
    /// - Parameter original: The value originally entered by the user, used to refer to the number of decimal places
    /// - Returns: string with the same number of decimal places
    func formattedWithExactDecimals(from original: Double) -> String {
        let originalString = String(original)
        let decimals = originalString.split(separator: ".").last?.count ?? 2
        return String(format: "%.\(decimals)f", self)
    }
}

