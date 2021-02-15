//
//  SimulationFormPresenter.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

// MARK: - Presenter
class SimulationFormPresenter {
    weak var view: SimulationFormOutput?
}

// MARK: - Presentation Logic
protocol SimulationFormPresentationLogic: class {
    func didValidateFields(isValid: Bool)
    func didFailure(_ error: Error)
}
extension SimulationFormPresenter: SimulationFormPresentationLogic {
    func didValidateFields(isValid: Bool) {
        view?.changeSubmitButtonState(isEnable: isValid)
    }
    func didFailure(_ error: Error) {
        view?.didFailure(error)
    }
}
