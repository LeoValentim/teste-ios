//
//  String+extensions.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

extension String {
    func date(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    func decimalFromFormattedString() -> Decimal? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.number(from: self)?.decimalValue
    }
}
