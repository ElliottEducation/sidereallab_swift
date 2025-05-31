//
//  Extensions.swift
//  SiderealLab
//
//  Created by Elliott on 29/5/2025.
//

import Foundation

/// 扩展 Double 类型，使其支持根据用户原始输入的小数位数进行动态格式化
extension Double {
    /// 根据传入的原始值 `original` 保留相同的小数位数
    ///
    /// - Parameter original: 用户最初输入的数值，用于参考小数位数
    /// - Returns: 保留相同小数位数后的字符串
    func formattedWithExactDecimals(from original: Double) -> String {
        let originalString = String(original)
        let decimals = originalString.split(separator: ".").last?.count ?? 2
        return String(format: "%.\(decimals)f", self)
    }
}

