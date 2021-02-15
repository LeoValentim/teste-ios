//
//  InvestmentDetailsRouter.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

// MARK: - Data Passing
protocol InvestmentDetailsDataPassing {
  var dataStore: SimulationFormDataStore? { get }
}

// MARK: - Router
class InvestmentDetailsRouter {
    weak var viewController: InvestmentDetailsViewController?
    // MARK: Initializer
    static func instantiateFeature(passingData: InvestmentDetailsDataPassing) -> InvestmentDetailsViewController? {
        guard let simulation = passingData.dataStore?.simulation else { return nil }
        let router = InvestmentDetailsRouter()
        let viewControler = InvestmentDetailsViewController.instantiate()
        let presenter = InvestmentDetailsPresenter()
        let interactor = InvestmentDetailsInteractor(router: router,
                                                     presenter: presenter,
                                                     simulation: simulation)
        router.viewController = viewControler
        presenter.view = viewControler
        viewControler.interactor = interactor
        return viewControler
    }
}

// MARK: - Navigation
protocol InvestmentDetailsNavigation: class {
    func goBack()
}
extension InvestmentDetailsRouter: InvestmentDetailsNavigation {
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
