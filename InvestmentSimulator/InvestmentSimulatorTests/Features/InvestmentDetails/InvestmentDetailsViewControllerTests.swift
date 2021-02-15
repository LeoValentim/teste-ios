//
//  InvestmentDetailsViewControllerTests.swift
//  InvestmentSimulatorTests
//
//  Created by Leo Valentim on 14/02/21.
//

import XCTest
@testable import InvestmentSimulator

class InvestmentDetailsViewControllerTests: XCTestCase {
    var sut: InvestmentDetailsViewController!
    var window: UIWindow!
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        sut = InvestmentDetailsViewController()
    }
    override func tearDownWithError() throws {
        window = nil
        try super.tearDownWithError()
    }
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    func testLoadInvestment() {
        let spy = InvestmentDetailsBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        XCTAssertTrue(spy.didCallLoadDetails,
                      "viewDidLoad() should ask the interactor to load investments details")
    }
    func testSimulateAgainAction() throws {
        let spy = InvestmentDetailsBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.simulateAgainAction(nil)
        XCTAssertTrue(spy.didCallSimulateAgain,
                      "simulateAgainAction() should call the interactor to go back to simulation form")
    }
    func testBindProperties() throws {
        let viewModel = InvestmentDetailsViewModel(grossAmount: "1000",
                                                   grossAmountProfit: "100",
                                                   firstDetailsList: InvestmentDetailsListViewModel(itens: []),
                                                   secondDetailsList: InvestmentDetailsListViewModel(itens: []))
        loadView()
        sut.bindProperties(viewModel)
        XCTAssertEqual(sut.grossAmountLabel.text, "1000")
        XCTAssertEqual(sut.grossAmountProfitLabel.attributedText?.string, "Rendimento total de 100")
    }
    // MARK: - Spy
    class InvestmentDetailsBusinessLogicSpy: InvestmentDetailsBusinessLogic {
        var didCallLoadDetails: Bool = false
        var didCallSimulateAgain: Bool = false
        func loadDetails() {
            didCallLoadDetails = true
        }
        func simulateAgain() {
            didCallSimulateAgain = true
        }
    }
}
