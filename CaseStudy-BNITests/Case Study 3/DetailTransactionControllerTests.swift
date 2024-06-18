//
//  DetailTransactionControllerTests.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 18/06/24.
//

import XCTest
@testable import CaseStudy_BNI

class DetailTransactionControllerTests: XCTestCase {

    var sut: DetailTransactionController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Initialize the DetailTransactionController
        sut = DetailTransactionController()
        
        // Load the view hierarchy (important for some UIKit functionality)
        sut.loadViewIfNeeded()
        
        // Mock data for testing
        let mockTransactions = [
            Transaction(trxDate: "2023-01-15", nominal: 500),
            Transaction(trxDate: "2023-01-20", nominal: 300)
        ]
        
        let mockData = DonutChartData(label: "Mock Transactions", percentage: 100.0, data: mockTransactions)
        
        // Set the mock data to the controller
        sut.setData(dataTransaction: mockData)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testTableViewNumberOfRows() {
        // Given
        let expectedRows = sut.dataTransaction?.data.count ?? 0
        
        // When
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, expectedRows)
    }
    
    func testEmptyStateCell() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let cell = sut.getEmptyStateCell(indexPath)
        
        // Then
        XCTAssertTrue(cell is EmptyStateCustom)
    }
    
    func testHistoryCell() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let cell = sut.getHistoryCell(indexPath)
        
        // Then
        XCTAssertTrue(cell is TransactionCell)
    }
    
    func testTableViewDelegateMethods() {
        // Given
        let tableView = sut.tableView
        let dataSource = sut
        
        // When
        let numberOfRowsInSection = dataSource?.tableView(tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRowsInSection, sut.dataTransaction?.data.count ?? 0)
        
        // When
        let emptyStateCell = dataSource?.getEmptyStateCell(IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(emptyStateCell is EmptyStateCustom)
        
        // When
        let historyCell = dataSource?.getHistoryCell(IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(historyCell is TransactionCell)
    }
}
