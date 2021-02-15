//
//  SimulationStore.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 11/02/21.
//

import Foundation

// MARK: - Protocol
protocol SimulationStore {
    func generateInvestmentSimulation(params: [String: String],
                                      completion: @escaping (Result<Investment, Error>) -> Void)
}

// MARK: - Constants
enum SimulationStoreConstants {
    enum Endpoints {
        // LocalHost
        static let simulate = "http://localhost/calculator/simulate"
    }
}
