//
//  Double+extensions.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 13/02/21.
//

import Foundation

extension Double {
    func formatString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)
    }
}
