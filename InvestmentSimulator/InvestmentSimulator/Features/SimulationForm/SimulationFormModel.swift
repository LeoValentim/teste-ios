//
//  SimulationFormModel.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

// MARK: - Model
enum SimulationForm {
    // Use cases
    enum InvestmentForm {}
}

// MARK: - Use cases
extension SimulationForm.InvestmentForm {
    struct Request: Codable {
        var investedAmount: String
        var index: Index
        var rate: String
        var isTaxFree: String
        var maturityDate: String
        init(investedAmount: String,
             index: Index,
             rate: String,
             isTaxFree: String,
             maturityDate: String) {
            self.investedAmount = investedAmount
            self.index = index
            self.rate = rate
            self.isTaxFree = isTaxFree
            self.maturityDate = maturityDate
        }
    }
    enum Index: String, Codable {
        case cdi = "CDI"
    }
    enum Response {}
    enum ViewModel {}
}
