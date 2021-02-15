//
//  SimulationFormViewControllerTests.swift
//  InvestmentSimulatorTests
//
//  Created by Leo Valentim on 14/02/21.
//

import XCTest
@testable import InvestmentSimulator

class SimulationFormViewControllerTests: XCTestCase {
    var sut: SimulationFormViewController!
    var window: UIWindow!
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        sut = SimulationFormViewController()
    }
    override func tearDownWithError() throws {
        window = nil
        try super.tearDownWithError()
    }
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    func testSubmitForm() throws {
        let spy = SimulationFormBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.simulateAction()
        XCTAssertTrue(spy.didSubmitForm, "simulateAction() should call the interactor to submit form")
    }
    // MARK: - Spy
    class SimulationFormBusinessLogicSpy: SimulationFormBusinessLogic {
        var didChangeInvestedAmount: Bool = false
        var didChangeMaturityDate: Bool = false
        var didChangeRate: Bool = false
        var didSubmitForm: Bool = false
        func didChange(investedAmount: String?) {
            didChangeInvestedAmount = true
        }
        func didChange(maturityDate: String?) {
            didChangeMaturityDate = true
        }
        func didChange(rate: String?) {
            didChangeRate = true
        }
        func submitForm() {
            didSubmitForm = true
        }
    }
}
