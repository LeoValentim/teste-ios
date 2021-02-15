//
//  InvestmentDetailsPresenter.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

// MARK: - Presenter
class InvestmentDetailsPresenter {
    weak var view: InvestmentDetailsOutput?
    private func formatDoubleString(_ double: Double?) -> String {
        return double?.formatString() ?? ""
    }
    private func formatPercentualString(_ double: Double?) -> String {
        guard let double = double else { return "" }
        return "\(double)%".replacingOccurrences(of: ".", with: ",")
    }
}

// MARK: - Presentation Logic
protocol InvestmentDetailsPresentationLogic: class {
    func displayDetails(simulation: Investment)
    func didFailure(_ error: Error)
}
extension InvestmentDetailsPresenter: InvestmentDetailsPresentationLogic {
    func displayDetails(simulation: Investment) {
        let investedAmount = "\(formatDoubleString(simulation.investmentParameter?.investedAmount))"
        let taxesRate = "\(formatDoubleString(simulation.taxesAmount))(\(formatPercentualString(simulation.taxesRate)))"
        let maturityDate = simulation.investmentParameter?.maturityDate?
            .date(format: "yyyy-MM-dd'T'HH:mm:ss")?
            .string(format: "dd/MM/yyyy") ?? ""
        let firstDetailsList: [InvestmentDetailsItemViewModel] = [
            InvestmentDetailsItemViewModel(title: "Valor aplicado inicialmente",
                                           value: investedAmount),
            InvestmentDetailsItemViewModel(title: "Valor bruto do investimento",
                                           value: "\(formatDoubleString(simulation.grossAmount))"),
            InvestmentDetailsItemViewModel(title: "Valor do rendimento",
                                           value: "\(formatDoubleString(simulation.grossAmountProfit))"),
            InvestmentDetailsItemViewModel(title: "IR sobre o investimento",
                                           value: taxesRate),
            InvestmentDetailsItemViewModel(title: "Valor líquido do investimento",
                                           value: "\(formatDoubleString(simulation.netAmount))")
        ]
        let secondDetailsList: [InvestmentDetailsItemViewModel] = [
            InvestmentDetailsItemViewModel(title: "Data de resgate",
                                           value: "\(maturityDate)"),
            InvestmentDetailsItemViewModel(title: "Dias corridos",
                                           value: "\(simulation.investmentParameter?.maturityTotalDays ?? 0)"),
            InvestmentDetailsItemViewModel(title: "Rendimento mensal",
                                           value: "\(formatPercentualString(simulation.monthlyGrossRateProfit))"),
            InvestmentDetailsItemViewModel(title: "Persentual do CDI do investimento",
                                           value: "\(formatPercentualString(simulation.investmentParameter?.rate))"),
            InvestmentDetailsItemViewModel(title: "Rentabilidade anual",
                                           value: "\(formatPercentualString(simulation.annualGrossRateProfit))"),
            InvestmentDetailsItemViewModel(title: "Rentabilidade no período",
                                           value: "\(formatPercentualString(simulation.rateProfit))")
        ]
        let viewModel = InvestmentDetailsViewModel(
            grossAmount: formatDoubleString(simulation.grossAmount),
            grossAmountProfit: formatDoubleString(simulation.grossAmountProfit),
            firstDetailsList: InvestmentDetailsListViewModel(itens: firstDetailsList),
            secondDetailsList: InvestmentDetailsListViewModel(itens: secondDetailsList)
        )
        view?.displayDetails(viewModel)
    }
    func didFailure(_ error: Error) {
        view?.didFailure(error)
    }
}
