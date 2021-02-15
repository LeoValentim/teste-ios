//
//  SimulationFormRouter.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

// MARK: - Router
class SimulationFormRouter: InvestmentDetailsDataPassing {
    weak var viewController: SimulationFormViewController?
    weak var dataStore: SimulationFormDataStore?
    // MARK: Initializer
    static func instantiateFeature() -> SimulationFormViewController {
        let router = SimulationFormRouter()
        let viewControler = SimulationFormViewController()
        let presenter = SimulationFormPresenter()
        let interactor = SimulationFormInteractor(router: router,
                                                  presenter: presenter)
        router.dataStore = interactor
        router.viewController = viewControler
        presenter.view = viewControler
        viewControler.interactor = interactor
        return viewControler
    }
}

// MARK: - Navigation
protocol SimulationFormNavigation: class {
    func goToDetails()
}
extension SimulationFormRouter: SimulationFormNavigation {
    func goToDetails() {
        guard let destination = InvestmentDetailsRouter.instantiateFeature(passingData: self) else { return }
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
