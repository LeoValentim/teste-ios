//
//  InvestmentDetailsInteractor.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

// MARK: - Data Store
protocol InvestmentDetailsDataStore: class {
    var simulation: Investment { get }
}

// MARK: - Interactor
class InvestmentDetailsInteractor: InvestmentDetailsDataStore {
    var simulation: Investment
    var router: InvestmentDetailsNavigation
    var presenter: InvestmentDetailsPresentationLogic
    init(router: InvestmentDetailsNavigation,
         presenter: InvestmentDetailsPresentationLogic,
         simulation: Investment) {
        self.router = router
        self.presenter = presenter
        self.simulation = simulation
    }
}

// MARK: - Business Logic
protocol InvestmentDetailsBusinessLogic: class {
    func loadDetails()
    func simulateAgain()
}
extension InvestmentDetailsInteractor: InvestmentDetailsBusinessLogic {
    func loadDetails() {
        presenter.displayDetails(simulation: simulation)
    }
    func simulateAgain() {
        router.goBack()
    }
}
