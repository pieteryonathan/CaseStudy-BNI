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
    
    lazy var viewLineChart: LineChartView = {
        let viewX = LineChartView()
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
        
        viewLineChart.delegate = self
        viewLineChart.data = nil

        containerView.addArrangedSubview(viewLineChart)
    }
    
    func setData() {
//        var entries: [LineChartDataEntry]
    }
}

extension LineChartCell: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
}
