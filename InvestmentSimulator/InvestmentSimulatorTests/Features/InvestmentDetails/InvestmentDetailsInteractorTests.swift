//
//  InvestmentDetailsInteractorTests.swift
//  InvestmentSimulatorTests
//
//  Created by Leo Valentim on 14/02/21.
//

import XCTest
@testable import InvestmentSimulator

class InvestmentDetailsInteractorTests: XCTestCase {
    var sut: InvestmentDetailsInteractor!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = InvestmentDetailsInteractor(router: InvestmentDetailsNavigationSpy(),
                                          presenter: InvestmentDetailsPresentationLogicSpy(),
                                          simulation: try loadInvestmentObject())
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    func loadInvestmentObject() throws -> Investment {
        let data = Self.investmentJSON.data(using: .utf8)!
        return try JSONDecoder().decode(Investment.self, from: data)
    }
    func testDisplayDetails() throws {
        let spy = InvestmentDetailsPresentationLogicSpy()
        sut.presenter = spy
        sut.loadDetails()
        XCTAssertTrue(spy.didCallDisplayDetails, "loadDetails() should call presenter to display investment details")
    }
    func testGoBack() throws {
        let spy = InvestmentDetailsNavigationSpy()
        sut.router = spy
        sut.simulateAgain()
        XCTAssertTrue(spy.didGoBack, "simulateAgain() should call router to go back navigation")
    }
    // MARK: - Spy
    class InvestmentDetailsNavigationSpy: InvestmentDetailsNavigation {
        var didGoBack: Bool = false
        func goBack() {
            didGoBack = true
        }
    }
    class InvestmentDetailsPresentationLogicSpy: InvestmentDetailsPresentationLogic {
        var didCallDisplayDetails: Bool = false
        var didCallFailure: Bool = false
        func displayDetails(simulation: Investment) {
            didCallDisplayDetails = true
        }
        func didFailure(_ error: Error) {
            didCallFailure = true
        }
    }
}

extension InvestmentDetailsInteractorTests {
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
