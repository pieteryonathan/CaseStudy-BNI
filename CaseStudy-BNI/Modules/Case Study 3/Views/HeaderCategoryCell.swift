//
//  HeaderCategoryCell.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 17/06/24.
//

import UIKit

class HeaderCategoryCell: UITableViewCell {
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.insetsLayoutMarginsFromSafeArea = false
        view.layoutMargins = .init(top: 16, left: 24, bottom: 0, right: 24)
        return view
    }()
    
    private lazy var stackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Portfolio"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
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
        containerView.addArrangedSubview(stackViewHeader)
        stackViewHeader.addArrangedSubview(labelTitle)
    }
    
    func setTitle(_ title: String) {
        labelTitle.text = title
    }
}
