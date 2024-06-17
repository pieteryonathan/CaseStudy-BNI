//
//  HistoryTransactionControllerTests.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 17/06/24.
//

import XCTest
@testable import CaseStudy_BNI

class HistoryTransactionControllerTests: XCTestCase {

    var sut: HistoryTransactionController!

    override func setUp() {
        super.setUp()
        sut = HistoryTransactionController()
        sut.loadViewIfNeeded() // Ensure viewDidLoad is called
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // Mock data for testing
    let mockTransactionHistory: [TransactionHistory] = [
        TransactionHistory(merchant: "Merchant 1", total: 100),
        TransactionHistory(merchant: "Merchant 2", total: 200)
    ]

    // MARK: - Test Cases

    func testNumberOfRowsInSection_EmptyHistory() {
        // Arrange
        Account.transactionHistory = [] // Simulate empty transaction history

        // Act
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)

        // Assert
        XCTAssertEqual(numberOfRows, 1, "Number of rows should be 1 for empty state cell")
    }

    func testNumberOfRowsInSection_NonEmptyHistory() {
        // Arrange
        Account.transactionHistory = mockTransactionHistory // Simulate non-empty transaction history

        // Act
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)

        // Assert
        XCTAssertEqual(numberOfRows, mockTransactionHistory.count, "Number of rows should match the count of transaction history")
    }

    func testGetEmptyStateCell() {
        // Arrange
        Account.transactionHistory = [] // Simulate empty transaction history

        // Act
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.getEmptyStateCell(indexPath)

        // Assert
        XCTAssertTrue(cell is EmptyStateCustom, "Cell should be of type EmptyStateCustom")
        // Add more assertions if needed to verify the content of the empty state cell
    }

    func testGetHistoryCell() {
        // Arrange
        Account.transactionHistory = mockTransactionHistory // Simulate non-empty transaction history

        // Act
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.getHistoryCell(indexPath) as! TransactionHistoryCell

        // Assert
        XCTAssertTrue(cell is TransactionHistoryCell, "Cell should be of type TransactionHistoryCell")
        // Add more assertions if needed to verify the content of the history cell
    }

    // Add more tests as needed to cover other scenarios and edge cases

}
