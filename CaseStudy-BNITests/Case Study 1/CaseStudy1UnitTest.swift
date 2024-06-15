//
//  CaseStudy1UnitTest.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 14/06/24.
//

import XCTest
@testable import CaseStudy_BNI

final class CaseStudy1UnitTest: XCTestCase {
    
    func testWithdraw() {
        // Given
        Account.balance = 15000 // Assuming an initial balance
        
        // When
        let expectation = XCTestExpectation(description: "Withdrawal completed")
        Account.withdraw(amount: 10000) { success in
            // Then
            if success {
                print("Payment success")
                // Assert that the withdrawal succeeded
                XCTAssertTrue(Account.balance == 5000) // Check if balance is updated
                expectation.fulfill()
            } else {
                print("Payment failed")
                // Assert that the withdrawal failed
                XCTFail("Withdrawal should succeed")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Wait for the expectation to be fulfilled
    }
    
    func testDeposit() {
        // Given
        Account.balance = 0 // Assuming an initial balance of 0
        
        // When
        Account.deposit(amount: 5000)
        
        // Then
        XCTAssertEqual(Account.balance, 5000) // Assert that the balance is updated after depositing
    }
    
    // CASE STUDY 2
    
    
}
