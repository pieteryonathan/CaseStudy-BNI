//
//  PortfolioAccountPresenter.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 18/06/24.
//

import Foundation
import UIKit
import Alamofire

class PortfolioAccountPresenter {
    
    let donutChartData: [DonutChartData] = [
        DonutChartData(
            label: "Tarik Tunai",
            percentage: 55.0,
            data: [
                Transaction(trxDate: "21/01/2023", nominal: 1000000),
                Transaction(trxDate: "20/01/2023", nominal: 500000),
                Transaction(trxDate: "19/01/2023", nominal: 1000000)
            ]
        ),
        DonutChartData(
            label: "QRIS Payment",
            percentage: 31.0,
            data: [
                Transaction(trxDate: "21/01/2023", nominal: 159000),
                Transaction(trxDate: "20/01/2023", nominal: 35000),
                Transaction(trxDate: "19/01/2023", nominal: 1500)
            ]
        ),
        DonutChartData(
            label: "Topup Gopay",
            percentage: 7.7,
            data: [
                Transaction(trxDate: "21/01/2023", nominal: 200000),
                Transaction(trxDate: "20/01/2023", nominal: 195000),
                Transaction(trxDate: "19/01/2023", nominal: 5000000)
            ]
        ),
        DonutChartData(
            label: "Lainnya",
            percentage: 6.3,
            data: [
                Transaction(trxDate: "21/01/2023", nominal: 1000000),
                Transaction(trxDate: "20/01/2023", nominal: 500000),
                Transaction(trxDate: "19/01/2023", nominal: 1000000)
            ]
        )
    ]
    
    let lineChartData: [Int] = [3, 7, 8, 10, 5, 10, 1, 3, 5, 10, 7, 7]
    
    func getDonutChartData() -> [DonutChartData] {
        return donutChartData
    }
    
    func getLineChartData() -> [Int] {
        return lineChartData
    }
    
    func getNumberRowInSection() -> Int {
        donutChartData.count + donutChartData.flatMap { $0.data }.count
    }
    
    func categoryIndexForRow(_ row: Int) -> Int? {
        var currentIndex = 0
        for (index, data) in donutChartData.enumerated() {
            if currentIndex == row {
                return index
            }
            currentIndex += 1
            if currentIndex + data.data.count > row {
                return nil
            }
            currentIndex += data.data.count
        }
        return nil
    }
    
    func transactionIndexForRow(_ row: Int) -> (Int, Int)? {
        var currentIndex = 0
        
        for (categoryIndex, data) in donutChartData.enumerated() {
            if currentIndex == row {
                return (categoryIndex, -1) // Header category
            } else if currentIndex < row && row <= currentIndex + data.data.count {
                let transactionIndex = row - currentIndex - 1
                return (categoryIndex, transactionIndex)
            }
            currentIndex += 1 + data.data.count
        }
        
        return nil
    }
    
    func getTotalNominalForAll() -> Int {
        var totalNominal = 0
        
        for category in donutChartData {
            for transaction in category.data {
                totalNominal += transaction.nominal
            }
        }
        
        return totalNominal
    }
    
    func getDataPieChart() -> [String: (totalNominal: Int, percentage: Double)] {
        var categoryTotals: [String: (totalNominal: Int, percentage: Double)] = [:]
        
        let totalNominalAll = getTotalNominalForAll()
        
        for category in donutChartData {
            var totalNominal = 0
            
            for transaction in category.data {
                totalNominal += transaction.nominal
            }
            
            let percentage = Double(totalNominal) / Double(totalNominalAll) * 100.0
            
            categoryTotals[category.label] = (totalNominal, percentage)
        }
        
        return categoryTotals
    }
}

