//
//  PieChartCell.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 17/06/24.
//

import Foundation
import UIKit
import Charts
import DGCharts

class PieChartCell: UITableViewCell {

    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.insetsLayoutMarginsFromSafeArea = false
        view.layoutMargins = .init(top: 8, left: 24, bottom: 8, right: 24)
        return view
    }()
    
    lazy var viewPieChart: PieChartView = {
        let viewX = PieChartView()
        viewX.translatesAutoresizingMaskIntoConstraints = false
        viewX.heightAnchor.constraint(equalToConstant: 320).isActive = true
        return viewX
    }()

    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
        
    // MARK: - SETUP

    private func setupView() {
        backgroundColor = .clear
        
        NSLayoutConstraint.addSubviewAndCreateArroundEqualConstraint(in: containerView, toView: contentView)
        
        viewPieChart.drawEntryLabelsEnabled = false
        viewPieChart.delegate = self
        viewPieChart.data = nil

        containerView.addArrangedSubview(viewPieChart)
    }

    func setData(pieDatas: [String: (totalNominal: Int, percentage: Double)]) {
        var entries: [PieChartDataEntry] = []
        
        for (label, data) in pieDatas {
            let entry = PieChartDataEntry(value: data.percentage, label: label)
            entries.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        let colors = [UIColor.color1, UIColor.color2, UIColor.color3, UIColor.color4]
        dataSet.colors = colors
        
        dataSet.valueFormatter = PercentValueFormatter()
        dataSet.valueTextColor = .black
        dataSet.entryLabelColor = .black
        dataSet.valueFormatter = PercentValueFormatter()
        
        let data = PieChartData(dataSet: dataSet)
        viewPieChart.data = data
//        viewPieChart.legend.enabled = false
        viewPieChart.animate(xAxisDuration: 1.5, easingOption: .easeOutCirc)
    }
}

class PercentValueFormatter: NSObject, ValueFormatter {
    
    func stringForValue(_ value: Double, entry: ChartDataEntry?, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.1f%%", value)
    }
}

extension PieChartCell: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
}
