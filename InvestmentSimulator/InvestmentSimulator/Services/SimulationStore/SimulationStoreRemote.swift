//
//  SimulationStoreRemote.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 14/02/21.
//

import Foundation

class SimulationStoreRemote: SimulationStore {
    var networkLayer: NetworkLayer
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    func generateInvestmentSimulation(params: [String: String],
                                      completion: @escaping (Result<Investment, Error>) -> Void) {
        let composedURL = URLBuilder(baseURL: SimulationStoreConstants.Endpoints.simulate)
            .compose(parameters: params)
            .build()
        guard let url = composedURL else {
            completion(.failure(NetworkError.badURL))
            return
        }
        networkLayer.get(url,
                         model: Investment.self,
                         headers: nil,
                         completion: completion)
    }
}
