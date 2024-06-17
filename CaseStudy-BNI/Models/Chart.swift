//
//  Chart.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 18/06/24.
//

import Foundation

struct Transaction: Decodable {
    let trxDate: String
    let nominal: Int
    
    enum CodingKeys: String, CodingKey {
        case trxDate = "trx_date"
        case nominal
    }
}

struct DonutChartData: Decodable {
    let label: String
    let percentage: Double
    let data: [Transaction]
}

struct LineChartData: Decodable {
    let month: [Int]
}

struct ChartData: Decodable {
    let type: String
    let data: [DonutChartData]?
    let lineData: LineChartData?
}

struct ChartsResponse: Decodable {
    let charts: [ChartData]
    
    enum CodingKeys: String, CodingKey {
        case charts = "data"
    }
}
