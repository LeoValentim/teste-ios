//
//  SimulationStoreMOK.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 11/02/21.
//

import Foundation

class SimulationStoreMOK: SimulationStore {
    private let jsonString: String = """
        {
            "investmentParameter": {
                "investedAmount": 32323.0,
                "yearlyInterestRate": 9.5512,
                "maturityTotalDays": 1981,
                "maturityBusinessDays": 1409,
                "maturityDate": "2023-03-03T00:00:00",
                "rate": 123.0,
                "isTaxFree": false
            },
            "grossAmount": 60528.20,
            "taxesAmount": 4230.78,
            "netAmount": 56297.42,
            "grossAmountProfit": 28205.20,
            "netAmountProfit": 23974.42,
            "annualGrossRateProfit": 87.26,
            "monthlyGrossRateProfit": 0.76,
            "dailyGrossRateProfit": 0.000445330025305748,
            "taxesRate": 15.0,
            "rateProfit": 9.5512,
            "annualNetRateProfit": 74.17
        }
    """
    func generateInvestmentSimulation(params: [String: String],
                                      completion: @escaping (Result<Investment, Error>) -> Void) {
        guard let jsonData = jsonString.data(using: .utf8) else {
            let error = NSError(domain: "Error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        do {
            let decodedModel = try JSONDecoder().decode(Investment.self, from: jsonData)
            completion(.success(decodedModel))
        } catch {
            print("error: \(error)")
            completion(.failure(error))
        }
    }
}
