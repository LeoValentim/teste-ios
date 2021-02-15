//
//  InvestmentDetailsModel.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 12/02/21.
//

import Foundation

typealias InvestmentDetailsViewModel = InvestmentDetailsModel.ViewModel.Result
typealias InvestmentDetailsListViewModel = InvestmentDetailsModel.ViewModel.DetailsList
typealias InvestmentDetailsItemViewModel = InvestmentDetailsModel.ViewModel.DetailsItem

enum InvestmentDetailsModel {
    enum Request {}
    enum Response {}
    enum ViewModel {}
}

// MARK: - ViewModel
extension InvestmentDetailsModel.ViewModel {
    struct Result {
        var grossAmount: String
        var grossAmountProfit: String
        var firstDetailsList: DetailsList
        var secondDetailsList: DetailsList
    }
    struct DetailsList {
        var itens: [DetailsItem]
    }
    struct DetailsItem {
        var title: String
        var value: String
    }
}
