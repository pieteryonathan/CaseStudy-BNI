//
//  PortfolioAccountControllerTests.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 18/06/24.
//

import XCTest
@testable import CaseStudy_BNI

class PortfolioAccountControllerTests: XCTestCase {
    
    var controller: PortfolioAccountController!
    var mockPresenter: MockPortfolioAccountPresenter!
    
    override func setUp() {
        super.setUp()
        controller = PortfolioAccountController()
        mockPresenter = MockPortfolioAccountPresenter()
        controller.presenter = mockPresenter
        
        // Load view hierarchy
        _ = controller.view
    }
    
    override func tearDown() {
        controller = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    // MARK: - Tests for UITableViewDataSource
    
    func testNumberOfSections() {
        let expectedSections = PortfolioAccountController.Section.allCases.count
        XCTAssertEqual(controller.numberOfSections(in: controller.tableView), expectedSections, "Expected number of sections does not match")
    }
    
    func testNumberOfRowsInSection() {
        // Test for each section
        XCTAssertEqual(controller.tableView(controller.tableView, numberOfRowsInSection: 0), 1, "Expected number of rows in header section")
        XCTAssertEqual(controller.tableView(controller.tableView, numberOfRowsInSection: 1), 1, "Expected number of rows in chart section")
        XCTAssertEqual(controller.tableView(controller.tableView, numberOfRowsInSection: 2), mockPresenter.getNumberRowInSection(), "Expected number of rows in history section")
    }
    
    func testCellForRowAt() {
        // Mock data for the presenter
        let indexPathHeader = IndexPath(row: 0, section: PortfolioAccountController.Section.header.rawValue)
        let indexPathChart = IndexPath(row: 0, section: PortfolioAccountController.Section.chart.rawValue)
        let indexPathHistory = IndexPath(row: 0, section: PortfolioAccountController.Section.history.rawValue)
        
        // Test Header Cell
        let headerCell = controller.tableView(controller.tableView, cellForRowAt: indexPathHeader) as? HeaderCell
        XCTAssertNotNil(headerCell, "Expected HeaderCell")
        
        // Test PieChart Cell
        let pieChartCell = controller.tableView(controller.tableView, cellForRowAt: indexPathChart) as? PieChartCell
        XCTAssertNotNil(pieChartCell, "Expected PieChartCell")
        
        // Test History Cells
        let historyCell = controller.tableView(controller.tableView, cellForRowAt: indexPathHistory) as? HeaderCategoryCell
        XCTAssertNotNil(historyCell, "Expected HeaderCategoryCell")
        
        // Additional test for getHistoryCell method indirectly tested
    }
}

// Mock PortfolioAccountPresenter for testing purposes
class MockPortfolioAccountPresenter: PortfolioAccountPresenter {
    
    override func getNumberRowInSection() -> Int {
        // Return a controlled number of rows for testing
        return 10 // Adjust as needed for your test cases
    }
    
    override func transactionIndexForRow(_ row: Int) -> (Int, Int)? {
        // Simulate transaction index for specific rows
        if row == 0 {
            return (0, -1) // Header category
        } else if row == 1 {
            return (0, 0) // First transaction in first category
        } else if row == 2 {
            return (1, -1) // Header category in second category
        } else if row == 3 {
            return (1, 0) // First transaction in second category
        }
        return nil // Handle other rows as needed
    }
}
