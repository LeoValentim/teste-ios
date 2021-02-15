//
//  SimulationFormInteractorTests.swift
//  InvestmentSimulatorTests
//
//  Created by Leo Valentim on 14/02/21.
//

import XCTest
@testable import InvestmentSimulator

class SimulationFormInteractorTests: XCTestCase {
    var sut: SimulationFormInteractor!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SimulationFormInteractor(router: SimulationFormNavigationSpy(),
                                       service: SimulationStoreMOK(),
                                       presenter: SimulationFormPresentationLogicSpy())
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    func testInvestedAmountValidation() throws {
        let spy = SimulationFormPresentationLogicSpy()
        sut.presenter = spy
        sut.didChange(investedAmount: nil)
        XCTAssertNil(spy.didCallValidateFields,
                     "didChange(rate:) should validate fields")
        sut.didChange(rate: "2")
        sut.didChange(maturityDate: "12/12/2022")
        sut.didChange(investedAmount: "0")
        XCTAssertFalse(spy.didCallValidateFields!,
                       "should call didValidateFields(false) when is 0")
        spy.didCallValidateFields = nil
        sut.didChange(investedAmount: "1000")
        XCTAssertTrue(spy.didCallValidateFields!,
                      "didChange(rate:) should call didValidateFields(true)")
    }
    func testRateValidation() throws {
        let spy = SimulationFormPresentationLogicSpy()
        sut.presenter = spy
        sut.didChange(rate: nil)
        XCTAssertNil(spy.didCallValidateFields,
                     "didChange(rate:) should not call validateFields when is empty")
        sut.didChange(maturityDate: "12/12/2022")
        sut.didChange(investedAmount: "1000")
        sut.didChange(rate: "0")
        XCTAssertFalse(spy.didCallValidateFields!,
                       "didChange(maturityDate:) should call didValidateFields(false) when is 0")
        spy.didCallValidateFields = nil
        sut.didChange(rate: "2")
        XCTAssertTrue(spy.didCallValidateFields!, "didChange(rate:) should call didValidateFields(true)")
    }
    func testMaturityDateValidation() throws {
        let spy = SimulationFormPresentationLogicSpy()
        sut.presenter = spy
        sut.didChange(maturityDate: nil)
        XCTAssertNil(spy.didCallValidateFields,
                     "didChange(rate:) should not call validateFields when is empty")
        sut.didChange(maturityDate: "33/33")
        XCTAssertNil(spy.didCallValidateFields,
                     "didChange(maturityDate:) should not call validateFields when is empty")
        spy.didCallValidateFields = nil
        sut.didChange(rate: "2")
        sut.didChange(investedAmount: "1000")
        sut.didChange(maturityDate: "12/12/2022")
        XCTAssertTrue(spy.didCallValidateFields!,
                      "didChange(investedAmount:) should call didValidateFields(true)")
    }
    func testSubmitForm() {
        let spy = SimulationFormNavigationSpy()
        sut.router = spy
        sut.submitForm()
        let expectations = expectation(description: "The api request is successful")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(spy.didGoToDetails, "submitForm() should go to details")
            expectations.fulfill()
        }
        waitForExpectations(timeout: 30, handler: { (error) in
            if let error = error {
                XCTAssertNil(error, "The api request does not give response")
            }
        })
    }
    // MARK: - Spy
    class SimulationFormPresentationLogicSpy: SimulationFormPresentationLogic {
        var didCallValidateFields: Bool?
        var didCallFailure: Bool = false
        func didValidateFields(isValid: Bool) {
            didCallValidateFields = isValid
        }
        func didFailure(_ error: Error) {
            didCallFailure = true
        }
    }
    class SimulationFormNavigationSpy: SimulationFormNavigation {
        var didGoToDetails: Bool = false
        func goToDetails() {
            didGoToDetails = true
        }
    }
}
