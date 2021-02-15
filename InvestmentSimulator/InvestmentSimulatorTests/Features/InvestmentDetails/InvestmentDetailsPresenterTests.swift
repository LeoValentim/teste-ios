//
//  InvestmentDetailsPresenterTests.swift
//  InvestmentSimulatorTests
//
//  Created by Leo Valentim on 14/02/21.
//

import XCTest
@testable import InvestmentSimulator

class InvestmentDetailsPresenterTests: XCTestCase {
    var sut: InvestmentDetailsPresenter!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = InvestmentDetailsPresenter()
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    func loadInvestmentObject() throws -> Investment {
        let data = Self.investmentJSON.data(using: .utf8)!
        return try JSONDecoder().decode(Investment.self, from: data)
    }
    func testDisplayDetails() throws {
        let spy = InvestmentDetailsOutputSpy()
        sut.view = spy
        sut.displayDetails(simulation: try loadInvestmentObject())
        XCTAssertTrue(spy.didCalldisplayDetails, "displayDetails() should call view to display investment details")
    }
    // MARK: - Spy
    class InvestmentDetailsOutputSpy: InvestmentDetailsOutput {
        var didCalldisplayDetails: Bool = false
        var didCallFailure: Bool = false
        func displayDetails(_ viewModel: InvestmentDetailsViewModel) {
            didCalldisplayDetails = true
        }
        func didFailure(_ error: Error) {
            didCallFailure = true
        }
    }
}

extension InvestmentDetailsPresenterTests {
    fileprivate static let investmentJSON = """
    {
        "investmentParameter": {
            "investedAmount": 32323.0,
            "yearlyInterestRate": 9.5512,
            "maturityTotalDays": 1981,
            "maturityBusinessDays": 1409,
            "maturityDate": "2023-03-03T00:00:00",
            "rate": 123.0,
            "isTaxFree": false
        },
        "grossAmount": 60528.20,
        "taxesAmount": 4230.78,
        "netAmount": 56297.42,
        "grossAmountProfit": 28205.20,
        "netAmountProfit": 23974.42,
        "annualGrossRateProfit": 87.26,
        "monthlyGrossRateProfit": 0.76,
        "dailyGrossRateProfit": 0.000445330025305748,
        "taxesRate": 15.0,
        "rateProfit": 9.5512,
        "annualNetRateProfit": 74.17
    }
    """
}
