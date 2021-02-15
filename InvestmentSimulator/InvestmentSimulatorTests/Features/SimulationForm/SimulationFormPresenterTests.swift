//
//  SimulationFormPresenterTests.swift
//  InvestmentSimulatorTests
//
//  Created by Leo Valentim on 14/02/21.
//

import XCTest
@testable import InvestmentSimulator

class SimulationFormPresenterTests: XCTestCase {
    var sut: SimulationFormPresenter!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SimulationFormPresenter()
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    func testSubmitButtonState() throws {
        let spy = SimulationFormOutputSpy()
        sut.view = spy
        sut.didValidateFields(isValid: true)
        XCTAssertTrue(spy.didChangeSubmitButtonState,
                      "didValidateFields(isValid:) should ask the view controller to enable/disable simulate button")
    }
    func testFailure() throws {
        let spy = SimulationFormOutputSpy()
        sut.view = spy
        sut.didFailure(NSError())
        XCTAssertTrue(spy.didCallFailure,
                      "didFailure(_:) should ask the view controller to display error message")
    }
    // MARK: - Spy
    class SimulationFormOutputSpy: SimulationFormOutput {
        var didChangeSubmitButtonState: Bool = false
        var didCallFailure: Bool = false
        func changeSubmitButtonState(isEnable: Bool) {
            didChangeSubmitButtonState = true
        }
        func didFailure(_ error: Error) {
            didCallFailure = true
        }
    }
}
