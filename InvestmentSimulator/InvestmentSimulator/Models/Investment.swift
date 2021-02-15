//
//  Investment.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 10/02/21.
//

import Foundation

struct Investment: Codable {
    let investmentParameter: InvestmentParameter?
    let grossAmount: Double?
    let taxesAmount: Double?
    let netAmount: Double?
    let grossAmountProfit: Double?
    let netAmountProfit: Double?
    let annualGrossRateProfit: Double?
    let monthlyGrossRateProfit: Double?
    let dailyGrossRateProfit: Double?
    let taxesRate: Double?
    let rateProfit: Double?
    let annualNetRateProfit: Double?
}

struct InvestmentParameter: Codable {
    let investedAmount: Double?
    let yearlyInterestRate: Double?
    let maturityTotalDays: Int?
    let maturityBusinessDays: Int?
    let maturityDate: String?
    let rate: Double?
    let isTaxFree: Bool?
}
