//
//  Color+Extension.swift
//  WatchFocus
//
//  Created by 방유빈 on 2024/02/13.
//

import SwiftUI
import UIKit
import DYColor

// MARK: - Color System
extension Color {
    static let wfMainPurple = Color(hex: "#E901FD")
    static let wfMainBlue = Color(hex: "#007AFF")
    static let wfCategoryGreen = Color(hex: "#00E55C")
    static let wfCategoryYellow = Color(hex: "#FFB800")
    static let wfCategoryRed = Color(hex: "#FF2752")
    static let wfAlphaPurple = Color(hex: "#E901FD", opacity: 0.5)
    static let wfAlphaBlue = Color(hex: "#007AFF", opacity: 0.5)
    static let wfBackgroundGray = Color(hex: "#FAFBFF")
    static let wfLightGray = Color(hex: "#D9D9D9")
    static let wfGray = Color(hex: "#ADADAD")
    static let wfBlueGray = Color(hex: "#AAB6D4")
    
    // MARK: - Gray Scale
    /// 밝기 90%
    static let wfGray1 = Color(hex: "#E6E6E6")
    /// 밝기 80%
    static let wfGray2 = Color(hex: "#cccccc")
    /// 밝기 60%
    static let wfGray3 = Color(hex: "#999999")
    /// 밝기 50%
    static let wfGray4 = Color(hex: "#808080")
    /// 밝기 30%
    static let wfGray5 = Color(hex: "#4D4D4D")
}
