//
//  UIColor+extensions.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 13/02/21.
//

import UIKit

extension UIColor {
    static let defaultColor: UIColor =  #colorLiteral(red: 0, green: 0.7843222022, blue: 0.7007431388, alpha: 1)
    static let defaultDisabledColor: UIColor = #colorLiteral(red: 0.7631228566, green: 0.7931808829, blue: 0.7882085443, alpha: 1)
    enum Compatible {
        static var secondaryLabel: UIColor {
            if #available(iOS 13.0, *) {
                return .secondaryLabel
            } else {
                return #colorLiteral(red: 60, green: 60, blue: 67, alpha: 0.6)
            }
        }
    }
}
