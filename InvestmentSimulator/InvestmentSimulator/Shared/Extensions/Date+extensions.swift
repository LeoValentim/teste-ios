//
//  Date+extensions.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
