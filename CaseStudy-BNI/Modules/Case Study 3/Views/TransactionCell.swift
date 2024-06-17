//
//  TransactionCell.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 18/06/24.
//

import Foundation
import UIKit

class TransactionCell: UITableViewCell {

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
    
    private lazy var stackViewLabel: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .fill
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        view.layer.cornerRadius = 16
        view.isLayoutMarginsRelativeArrangement = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    private lazy var stackViewStatus: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    private lazy var labelStatus: UILabel = {
        let labelX = UILabel()
        labelX.font = .systemFont(ofSize: 12, weight: .regular)
        labelX.textColor = .black
        labelX.textAlignment = .right
        labelX.numberOfLines = 0
        labelX.lineBreakMode = .byWordWrapping
        labelX.text = "Date"
        labelX.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return labelX
    }()

    private lazy var labelTotal: UILabel = {
        let labelX = UILabel()
        labelX.font = .systemFont(ofSize: 16, weight: .bold)
        labelX.textColor = .black
        labelX.textAlignment = .left
        labelX.numberOfLines = 0
        labelX.lineBreakMode = .byWordWrapping
        labelX.text = "Rp 50.000"
        labelX.setContentHuggingPriority(.defaultLow, for: .vertical)
        return labelX
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
        containerView.addArrangedSubview(stackViewLabel)
        stackViewLabel.addArrangedSubViews(views: [stackViewStatus, labelTotal])
        stackViewStatus.addArrangedSubViews(views: [StackViewHelpers.getSpacerH(), labelStatus])
    }
    
    public func setData(transaction: Transaction) {
        labelTotal.text = nil
        labelStatus.text = nil
        
        labelTotal.text = "RP \(FormattingHelper.addPeriods(to: transaction.nominal))"
        labelStatus.text = transaction.trxDate
    }
}
