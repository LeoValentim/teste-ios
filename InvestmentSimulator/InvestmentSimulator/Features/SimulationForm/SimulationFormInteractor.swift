//
//  SimulationFormInteractor.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

// MARK: - Data Store
protocol SimulationFormDataStore: class {
    var simulation: Investment? { get }
}

// MARK: - Interactor
class SimulationFormInteractor: SimulationFormDataStore {
    // MARK: Properties
    var router: SimulationFormNavigation
    var presenter: SimulationFormPresentationLogic
    var worker: SimulationWorker
    // Data
    var simulation: Investment?
    var investedAmount: Decimal = 0
    var maturityDate: String = ""
    var rate: Int = 0
    // MARK: Initializer
    init(router: SimulationFormNavigation,
         presenter: SimulationFormPresentationLogic) {
        self.router = router
        self.presenter = presenter
        #if DEBUG
            worker = SimulationWorker(simulationStore: SimulationStoreMOK())
        #else
            let store = SimulationStoreRemote(networkLayer: NetworkURLSession())
            worker = SimulationWorker(simulationStore: store)
        #endif
    }
    // MARK: Private methods
    private func validateFields() {
        guard investedAmount > 0 else {
            presenter.didValidateFields(isValid: false)
            return
        }
        guard !maturityDate.isEmpty else {
            presenter.didValidateFields(isValid: false)
            return
        }
        guard rate > 0 else {
            presenter.didValidateFields(isValid: false)
            return
        }
        presenter.didValidateFields(isValid: true)
    }
}

// MARK: - Business Logic
protocol SimulationFormBusinessLogic: class {
    func didChange(investedAmount: String?)
    func didChange(maturityDate: String?)
    func didChange(rate: String?)
    func submitForm()
}
extension SimulationFormInteractor: SimulationFormBusinessLogic {
    func didChange(investedAmount: String?) {
        guard let investedAmountDecimal = investedAmount?.decimalFromFormattedString() else {
            presenter.didValidateFields(isValid: false)
            return
        }
        self.investedAmount = investedAmountDecimal
        validateFields()
    }
    func didChange(maturityDate: String?) {
        guard let maturityDate = maturityDate?.date(format: "dd/MM/yyyy") else {
            presenter.didValidateFields(isValid: false)
            return
        }
        self.maturityDate = maturityDate.string(format: "yyyy-MM-dd")
        validateFields()
    }
    func didChange(rate: String?) {
        guard let rate = rate,
              let rateInt = Int(rate) else {
            presenter.didValidateFields(isValid: false)
            return
        }
        self.rate = rateInt
        validateFields()
    }
    func submitForm() {
        do {
            let simulationForm = SimulationForm.InvestmentForm.Request(
                investedAmount: "\(investedAmount)",
                index: .cdi,
                rate: "\(rate)",
                isTaxFree: "false",
                maturityDate: maturityDate
            )
            let data = try JSONEncoder().encode(simulationForm)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let params = (jsonObject as? [String: String]) ?? [:]
            worker.generateInvestmentSimulation(params: params) { result in
                switch result {
                case .success(let simulation):
                    self.simulation = simulation
                    self.router.goToDetails()
                case .failure(let error):
                    self.presenter.didFailure(error)
                }
            }
        } catch {
            presenter.didFailure(error)
        }
    }
}
