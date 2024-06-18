//
//  LineChartCell.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 18/06/24.
//

import Foundation
import UIKit
import Charts
import DGCharts

class LineChartCell: UITableViewCell {
    
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
    
    lazy var viewLineChart: BarChartView = {
        let viewX = BarChartView()
        viewX.translatesAutoresizingMaskIntoConstraints = false
        viewX.heightAnchor.constraint(equalToConstant: 320).isActive = true
        return viewX
    }()
    
    private lazy var labelOtherCaseStudy: UILabel = {
        let label = UILabel()
        label.text = "Other Case Study"
        label.textAlignment = .right
        label.textColor = .orange
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.addTapAction(self, action: #selector(onOtherCaseStudyTapped))
        return label
    }()
    
    // MARK: - VARIABLE DECLARATION
    var onTapOtherCaseStudy: (() -> Void)?
    var onTapChart: ((_ index: Int) -> Void)?
    
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
        
        viewLineChart.delegate = self
        viewLineChart.data = nil
        
        containerView.addArrangedSubview(viewLineChart)
        containerView.addArrangedSubview(labelOtherCaseStudy)
    }
    
    func setData(chartData: [Int]) {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Octr", "Nov", "Dec"]
        
        var entries: [BarChartDataEntry] = []
        
        for (index, value) in chartData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: Double(value))
            entries.append(entry)
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: "")
        dataSet.colors = [UIColor.color1, UIColor.color2, UIColor.color3, UIColor.color4]
        dataSet.valueColors = [NSUIColor.black]
        
        let data = BarChartData(dataSet: dataSet)
        viewLineChart.data = data
        
        viewLineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        viewLineChart.xAxis.labelPosition = .bottom
        viewLineChart.xAxis.labelCount = months.count
        viewLineChart.xAxis.drawGridLinesEnabled = false
        
        viewLineChart.leftAxis.drawAxisLineEnabled = false
        viewLineChart.leftAxis.drawLabelsEnabled = false
        
        viewLineChart.rightAxis.enabled = false
        viewLineChart.legend.enabled = false
        viewLineChart.doubleTapToZoomEnabled = false
        viewLineChart.pinchZoomEnabled = false

        viewLineChart.notifyDataSetChanged()
    }
    
    // MARK: - ACTION
    @objc func onOtherCaseStudyTapped(_ sender: Any) {
        self.onTapOtherCaseStudy?()
    }
}

extension LineChartCell: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let dataEntry = entry as? BarChartDataEntry {
            self.onTapChart?(Int(dataEntry.x))
        }
    }
}
