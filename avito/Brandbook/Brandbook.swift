//
//  Brandbook.swift
//  avito
//
//  Created by Melanie Kofman on 18.10.2022.
//

import Foundation
import UIKit
enum Brandbook {
    enum Colors {
        static let brown: UIColor = .systemBrown
        static let yellow: UIColor = .systemYellow
        static let white: UIColor = .white
        static let teal: UIColor = .systemTeal
        static let green: UIColor = .systemGreen
        static let pink: UIColor = .systemPink
        static let indigo: UIColor = .systemIndigo
        static let orange: UIColor = .systemOrange
        static let gray2: UIColor = .systemGray2
    }
    enum TextSize {
        static let small: CGFloat = 13
    }
    enum Padding {
        static let small: CGFloat = 3
        static let normal: CGFloat = 10
        static let light: CGFloat = 15
        static let big: CGFloat = 20
    }
    enum CornerRadius {
        static let normal: CGFloat = 10
    }
    enum Height {
        static let section: CGFloat = 20.0
        static let row: CGFloat = 120.0
    }
}