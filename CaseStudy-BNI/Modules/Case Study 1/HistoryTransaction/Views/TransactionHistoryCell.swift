//
//  TransactionHistoryCell.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import Foundation
import UIKit

class TransactionHistoryCell: UITableViewCell {

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
        view.spacing = 16
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
        labelX.textColor = .red
        labelX.textAlignment = .right
        labelX.numberOfLines = 0
        labelX.lineBreakMode = .byWordWrapping
        labelX.text = "Expense"
        labelX.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return labelX
    }()
    
    private lazy var labelMerchant: UILabel = {
        let labelX = UILabel()
        labelX.font = .systemFont(ofSize: 16, weight: .medium)
        labelX.textColor = .black
        labelX.textAlignment = .left
        labelX.numberOfLines = 0
        labelX.lineBreakMode = .byWordWrapping
        labelX.text = "Merchant"
        labelX.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return labelX
    }()
    
    private lazy var labelTotal: UILabel = {
        let labelX = UILabel()
        labelX.font = .systemFont(ofSize: 14, weight: .bold)
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
        stackViewLabel.addArrangedSubViews(views: [stackViewStatus, labelMerchant, labelTotal])
        stackViewLabel.setCustomSpacing(8, after: labelMerchant)
        stackViewStatus.addArrangedSubViews(views: [StackViewHelpers.getSpacerH(), labelStatus])
    }
    
    public func setData(transactionHistory: TransactionHistory) {
        labelMerchant.text = nil
        labelTotal.text = nil
        
        labelMerchant.text = transactionHistory.merchant
        labelTotal.text = "RP \(FormattingHelper.addPeriods(to: transactionHistory.total))"
    }
}
