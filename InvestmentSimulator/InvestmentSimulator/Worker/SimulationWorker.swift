//
//  SimulationWorker.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 14/02/21.
//

import Foundation

// Worker
class SimulationWorker {
    var simulationStore: SimulationStore
    init(simulationStore: SimulationStore) {
        self.simulationStore = simulationStore
    }
    func generateInvestmentSimulation(params: [String: String],
                                      completion: @escaping (Result<Investment, Error>) -> Void) {
        simulationStore.generateInvestmentSimulation(params: params, completion: completion)
    }
}
