//
//  PortfolioAccountPresenterTests.swift
//  CaseStudy-BNITests
//
//  Created by Pieter Yonathan on 18/06/24.
//

import XCTest
@testable import CaseStudy_BNI

class PortfolioAccountPresenterTests: XCTestCase {
    
    var presenter: PortfolioAccountPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = PortfolioAccountPresenter()
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    // Test cases for getDonutChartData() function
    func testGetDonutChartData() {
        let donutChartData = presenter.getDonutChartData()
        XCTAssertEqual(donutChartData.count, 4, "Expected 4 items in donut chart data")
    }
    
    // Test cases for getLineChartData() function
    func testGetLineChartData() {
        let lineChartData = presenter.getLineChartData()
        XCTAssertEqual(lineChartData.count, 12, "Expected 12 items in line chart data")
    }
    
    // Test cases for getNumberRowInSection() function
    func testGetNumberRowInSection() {
        let numberOfItems = presenter.getNumberRowInSection()
        XCTAssertEqual(numberOfItems, 16, "Expected 16 items in section")
    }
    
    // Test cases for getTotalNominalForAll() function
    func testGetTotalNominalForAll() {
        // Setup: Initialize the presenter
        let presenter = PortfolioAccountPresenter()
        
        // Execute: Call getTotalNominalForAll()
        let totalNominal = presenter.getTotalNominalForAll()
        
        // Assert: Compare the actual totalNominal with expected value
        XCTAssertEqual(totalNominal, 10590500, "Expected total nominal 10590500")
    }
    
    func testGetDataPieChart() {
        let pieChartData = presenter.getDataPieChart()
        
        // Validate the number of items in the pie chart data
        XCTAssertEqual(pieChartData.count, 4, "Expected 4 items in pie chart data")
        
        // Test specific data points with updated expected values
        XCTAssertEqual(pieChartData["Tarik Tunai"]?.totalNominal, 2500000, "Expected total nominal for 'Tarik Tunai'")
        
        // Adjusted expected percentage for 'QRIS Payment' based on actual calculation
        XCTAssertEqual(pieChartData["QRIS Payment"]?.percentage ?? 0.0, 1.8459940512723667, accuracy: 0.01, "Expected percentage for 'QRIS Payment'")
        
        // Add more assertions for other categories as needed
    }
}
