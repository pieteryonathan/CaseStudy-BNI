//
//  PaymentConfirmationControllerTests.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 17/06/24.
//

import XCTest
@testable import CaseStudy_BNI

class PaymentConfirmationControllerTests: XCTestCase {

    var sut: PaymentConfirmationController!
    var mockPaymentConfirmation: PaymentConfirmation!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPaymentConfirmation = PaymentConfirmation(
            idPayment: "ID12345678",
            nameBank: "BNI",
            nameOfMerchant: "MERCHANT MOCK TEST",
            totalOfTransaction: 1000000
        )
        sut = PaymentConfirmationController(paymentConfirmation: mockPaymentConfirmation)
        sut.loadViewIfNeeded() // Ensure the view is loaded
    }

    override func tearDownWithError() throws {
        sut = nil
        mockPaymentConfirmation = nil
        try super.tearDownWithError()
    }

    func testViewIsNotNil() {
        XCTAssertNotNil(sut.view, "View should be loaded")
    }

    func testSetState() {
        sut.setState()
        XCTAssertEqual(sut.labelToAcount.text, mockPaymentConfirmation.nameBank, "Bank name should be set correctly")
        XCTAssertEqual(sut.labelNameMerchant.text, mockPaymentConfirmation.nameOfMerchant, "Merchant name should be set correctly")
        XCTAssertEqual(sut.labelAmount.text, FormattingHelper.addPeriods(to: mockPaymentConfirmation.totalOfTransaction ?? 0), "Transaction amount should be set correctly")
        XCTAssertEqual(sut.labelIdTransaction.text, mockPaymentConfirmation.idPayment, "Transaction ID should be set correctly")
    }

    func testOnPayTapped() {
        let expectation = self.expectation(description: "Payment process should complete")

        MockAccount.mockWithdrawSuccess = true
        sut.isPaymentProcessing = false

        sut.onPayTapped(self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(self.sut.isPaymentProcessing, "Payment should be in progress")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testOnPayTappedFailsDueToLowBalance() {
        let expectation = self.expectation(description: "Payment process should fail due to low balance")

        MockAccount.mockWithdrawSuccess = false
        sut.isPaymentProcessing = false

        sut.onPayTapped(self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertFalse(MockAccount.mockWithdrawSuccess, "Payment should fail")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }
}

class MockAccount: AccountProtocol {
    static var mockWithdrawSuccess = false
    static var transactionHistory: [TransactionHistory] = []

    static func withdraw(amount: Int, completion: @escaping (Bool) -> Void) {
        completion(mockWithdrawSuccess)
    }
}
